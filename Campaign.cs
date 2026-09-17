namespace VoicebotBillingMIS.Data.Models;

public class Campaign
{
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;

    public int DepartmentId { get; set; }

    public int VendorId { get; set; }

    public decimal BudgetAmount { get; set; }

    /// <summary>Call Flow ID (STR_BOT_ID from dbo.sp_vb_cost_analysis_dg) for linking to actual usage data.</summary>
    public string? CallFlowId { get; set; }
}

/// <summary>
/// A UsageRecord enriched with all Phase-2 calculated fields.
/// Produced by UsageService; consumed directly by the controller and view.
/// No math belongs in the view - every value here is pre-computed.
/// </summary>
public class UsageRecordViewModel
{
    public string Department { get; set; } = string.Empty;
    public string Campaign { get; set; } = string.Empty;
    public string Vendor { get; set; } = string.Empty;

    public int? UniqueBase { get; set; }
    public int? TotalAttempts { get; set; }
    public int? UniqueConnects { get; set; }
    public int? TotalConnects { get; set; }
    public decimal? AttemptIntensity { get; set; }
    public decimal? ConnectIntensity { get; set; }
    public long? Mou { get; set; }
    public decimal? RunningCost { get; set; }
    public decimal BudgetAmount { get; set; }
    public decimal? BudgetBurnPercentage { get; set; }
    public decimal? ExpectedTimeCoveragePercentage { get; set; }
    public decimal? PaceRatio { get; set; }
    public decimal? ApplicableTimeBudget { get; set; }
    public BudgetStatus BudgetStatus { get; set; }
}
