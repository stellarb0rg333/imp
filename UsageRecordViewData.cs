namespace VoicebotBillingMIS.Models;

using System;
using VoicebotBillingMIS.Data.Models;

/// <summary>
/// A UsageRecord enriched with all Phase-2 calculated fields.
/// Produced by UsageService; consumed directly by the controller and view.
/// No math belongs in the view - every value here is pre-computed.
/// </summary>
public class UsageRecordViewData
{
    // Raw fields (passed through from UsageRecord)
    public string Department { get; set; } = string.Empty;
    public string Campaign { get; set; } = string.Empty;
    public string Vendor { get; set; } = string.Empty;

    // Raw metrics supplied by dbo.sp_vb_cost_analysis_dg.
    public int? UniqueBase { get; set; }
    public int? TotalAttempts { get; set; }
    public int? UniqueConnects { get; set; }
    public int? TotalConnects { get; set; }
    // Calculated fields (set by UsageService)

    /// <summary>TotalAttempts / UniqueBase. Null if either component is missing.</summary>
    public decimal? AttemptIntensity { get; set; }

    /// <summary>TotalConnects / UniqueConnects. Null if either component is missing.</summary>
    public decimal? ConnectIntensity { get; set; }

    /// <summary>Final MOU in minutes supplied by the stored procedure's Duration column.</summary>
    public long? Mou { get; set; }

    /// <summary>
    /// MOU * perMinuteRate * 1.18 (GST). Null when vendor rate or MOU is not provided.
    /// Does NOT include one-time bot development cost - that is tracked separately.
    /// </summary>
    public decimal? RunningCost { get; set; }

    /// <summary>Campaign BudgetAmount used for threshold comparison.</summary>
    public decimal BudgetAmount { get; set; }

    /// <summary>Normal / Nearing / Exceeded - determined by BillingCalculations.GetBudgetStatus.</summary>
    public BudgetStatus BudgetStatus { get; set; }
}
