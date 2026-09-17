using VoicebotBillingMIS.Data.Contracts;
using VoicebotBillingMIS.Data.Models;
using VoicebotBillingMIS.Data.Repositories;

namespace VoicebotBillingMIS.Data.Services;

public class UsageService(IUsageRepository usageRepository) : IUsageService
{
    public Task<IReadOnlyList<Department>> GetDepartmentsAsync(CancellationToken cancellationToken = default)
        => usageRepository.GetDepartmentsAsync(cancellationToken);

    public Task<IReadOnlyList<Campaign>> GetCampaignsAsync(CancellationToken cancellationToken = default)
        => usageRepository.GetCampaignsAsync(cancellationToken);

    public Task<IReadOnlyList<Vendor>> GetVendorsAsync(CancellationToken cancellationToken = default)
        => usageRepository.GetVendorsAsync(cancellationToken);

    public Task<IReadOnlyList<VendorRateHistory>> GetVendorRateHistoryAsync(CancellationToken cancellationToken = default)
        => usageRepository.GetVendorRateHistoryAsync(cancellationToken);

    public Task<VendorRateHistory> AddVendorRateAsync(int vendorId, decimal ratePerMinute, DateTime effectiveFrom, CancellationToken cancellationToken = default)
        => usageRepository.AddVendorRateAsync(vendorId, ratePerMinute, effectiveFrom, cancellationToken);

    public Task<bool> UpdateCampaignBudgetAsync(int campaignId, decimal budgetAmount, CancellationToken cancellationToken = default)
        => usageRepository.UpdateCampaignBudgetAsync(campaignId, budgetAmount, cancellationToken);

    public async Task<IReadOnlyList<UsageRecordViewModel>> GetUsageRecordsAsync(
        UsageFilterRequest filterRequest,
        CancellationToken cancellationToken = default)
    {
        var rawRecords = await usageRepository.GetUsageRecordsAsync(filterRequest, cancellationToken);
        var vendors    = await usageRepository.GetVendorsAsync(cancellationToken);
        var campaigns  = await usageRepository.GetCampaignsAsync(cancellationToken);
        

        // Campaign is the source of truth for vendor mapping; usage row vendor text is display-only.
        var vendorByName = vendors.ToDictionary(v => v.Name, v => v, StringComparer.OrdinalIgnoreCase);
        var vendorById = vendors.ToDictionary(v => v.Id);
        var campaignByName = campaigns.ToDictionary(c => c.Name, c => c, StringComparer.OrdinalIgnoreCase);

        var result = new List<UsageRecordViewModel>(rawRecords.Count);

        foreach (var r in rawRecords)
        {
            campaignByName.TryGetValue(r.Campaign, out var campaign);

            // Apply Department / Campaign / Vendor filters in the application layer.
            // The SQL stored procedure only accepts From and To.
            if (filterRequest.DepartmentIds.Count > 0 &&
                (campaign is null || !filterRequest.DepartmentIds.Contains(campaign.DepartmentId)))
            {
                continue;
            }

            if (filterRequest.CampaignIds.Count > 0 &&
                (campaign is null || !filterRequest.CampaignIds.Contains(campaign.Id)))
            {
                continue;
            }

            if (filterRequest.VendorIds.Count > 0 &&
                (campaign is null || !filterRequest.VendorIds.Contains(campaign.VendorId)))
            {
                continue;
            }

            Vendor? vendor = null;
            if (campaign is not null)
            {
                vendorById.TryGetValue(campaign.VendorId, out vendor);
            }

            if (vendor is null)
            {
                vendorByName.TryGetValue(r.Vendor, out vendor);
            }

            // Prefer the rate-history-derived current rate; fall back to the vendor's flat
            // PerMinuteRate for vendors that have no history rows yet (e.g. Gnani with no rate).
            decimal? perMinuteRate = vendor?.Name switch
            {
                "Greylabs" => filterRequest.GreylabsRatePerMinute,
                "Fogteams" => filterRequest.FogteamsRatePerMinute,
                "Gnani" => filterRequest.GnaniRatePerMinute,
                _ => vendor?.PerMinuteRate
            };

            // The stored procedure now supplies the final MOU value directly.
            long? mou = r.Mou;

            // Running cost: only compute if all three components are available
            decimal? runningCost = mou.HasValue && perMinuteRate.HasValue
                ? BillingCalculations.ComputeRunningCost(mou.Value, perMinuteRate.Value)
                : null;

            decimal budgetAmount = campaign?.BudgetAmount ?? 0m;
            var budget = BillingCalculations.CalculateBudget(
                runningCost,
                budgetAmount,
                filterRequest.From,
                filterRequest.To);

            // Intensity calculations: null-guard in case component fields are missing
            decimal? attemptIntensity = (r.TotalAttempts.HasValue && r.UniqueBase.HasValue && r.UniqueBase > 0)
                ? (decimal)r.TotalAttempts.Value / r.UniqueBase.Value
                : null;

            decimal? connectIntensity = (r.TotalConnects.HasValue && r.UniqueConnects.HasValue && r.UniqueConnects > 0)
                ? (decimal)r.TotalConnects.Value / r.UniqueConnects.Value
                : null;

            result.Add(new UsageRecordViewModel
            {
                // Raw
                Department           = r.Department,
                Campaign             = r.Campaign,
                Vendor               = vendor?.Name ?? r.Vendor,
                UniqueBase           = r.UniqueBase,
                TotalAttempts        = r.TotalAttempts,
                UniqueConnects       = r.UniqueConnects,
                TotalConnects        = r.TotalConnects,
                // Calculated
                AttemptIntensity = attemptIntensity,
                ConnectIntensity = connectIntensity,
                Mou              = mou,
                RunningCost      = runningCost,
                BudgetAmount     = budgetAmount,
                ApplicableTimeBudget = budget.ApplicableTimeBudget,
                BudgetBurnPercentage = budget.BudgetBurnPercentage,
                ExpectedTimeCoveragePercentage = budget.ExpectedTimeCoveragePercentage,
                PaceRatio = budget.PaceRatio,
                BudgetStatus = budget.Status,
            });
        }

        return result;
    }
}
