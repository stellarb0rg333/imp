USE [GENESYS_OUTBOUND]
GO
/****** Object:  StoredProcedure [dbo].[sp_vb_cost_analysis_dg]    Script Date: 9/17/2026 10:49:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[sp_vb_cost_analysis_dg]
		@FromDate DATETIME,
		@ToDate DATETIME
AS
	BEGIN

		SET NOCOUNT ON;	


SELECT 

    'Voicebot_ECS_Greylabs' AS CampaignName,
    
	'7004' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_ECS_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_ECS_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_ECS_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_ECS_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed  WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '7004'),0) AS Duration

 
UNION ALL

SELECT 

    'Voicebot_Final_Settlement_Grey' AS CampaignName,

	'7005' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_Final_Settlement_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_Final_Settlement_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_Final_Settlement_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_Final_Settlement_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

		ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '7005'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_Insurance_Grey' AS CampaignName,

	'7009' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_Insurance_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_Insurance_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_Insurance_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_Insurance_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

		ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '7009'),0) AS Duration

 
UNION ALL


SELECT 

    'voicebot_KTP_qualification' AS CampaignName,

	'82945ae8-57da-4786-a1b3-944f96f79bb3' AS STR_BOT_ID,
    

	 ISNULL((SELECT SUM(attempt) FROM voicebot_KTP_qualification WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM voicebot_KTP_qualification WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM voicebot_KTP_qualification WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM voicebot_KTP_qualification WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

		 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '82945ae8-57da-4786-a1b3-944f96f79bb3'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_MFI_Predue_Greylabs' AS CampaignName,

    '7002' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_MFI_Predue_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_MFI_Predue_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_MFI_Predue_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_MFI_Predue_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

		ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '7002'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_MFI_Sales_Greylabs' AS CampaignName,

    '7022' AS STR_BOT_Id,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_MFI_Sales_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_MFI_Sales_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_MFI_Sales_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_MFI_Sales_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

		 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '7022'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_PL_Websites' AS CampaignName,

	'b1ea56d1-b573-4d0c-bf2d-10f73c4eddf3' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_PL_Websites WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_PL_Websites WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_PL_Websites WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_PL_Websites WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

		ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = 'b1ea56d1-b573-4d0c-bf2d-10f73c4eddf3'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_Postdue_BX_Grey' AS CampaignName,

    '7008' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_Postdue_BX_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_Postdue_BX_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_Postdue_BX_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_Postdue_BX_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

		 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '7008'),0) AS Duration

 
UNION ALL



SELECT 

    'voicebot_postdue_collection' AS CampaignName,

    'b2ac7be2-224b-4b6d-8470-b601a65c2709' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM voicebot_postdue_collection WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM voicebot_postdue_collection WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM voicebot_postdue_collection WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM voicebot_postdue_collection WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

		 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = 'b2ac7be2-224b-4b6d-8470-b601a65c2709'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_Postdue_Collection_Grey' AS CampaignName,

    '7003' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_Postdue_Collection_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_Postdue_Collection_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_Postdue_Collection_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_Postdue_Collection_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

		 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '7003'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_Predue_Collection_Grey' AS CampaignName,

    '7001' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_Predue_Collection_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_Predue_Collection_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_Predue_Collection_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_Predue_Collection_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '7001'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_PreDue_Gold_Grey' AS CampaignName,
    
	'7021' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_PreDue_Gold_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_PreDue_Gold_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_PreDue_Gold_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_PreDue_Gold_Grey WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '7021'),0) AS Duration

 
UNION ALL

SELECT 

    'voicebot_reminder_collection' AS CampaignName,
    
	'aa887c28-cf17-4dc8-8c66-43917d0a8f96' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM voicebot_reminder_collection WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM voicebot_reminder_collection WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM voicebot_reminder_collection WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM voicebot_reminder_collection WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = 'aa887c28-cf17-4dc8-8c66-43917d0a8f96'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_shakti_DHFL_Fogteams' AS CampaignName,
    
	'9217ce68-9c4e-4642-980b-693c64cad7e1' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_shakti_DHFL_Fogteams WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_shakti_DHFL_Fogteams WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_shakti_DHFL_Fogteams WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_shakti_DHFL_Fogteams WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '9217ce68-9c4e-4642-980b-693c64cad7e1'),0) AS Duration

 
UNION ALL



SELECT 

    'Voicebot_shakti_PQ_Fogteams' AS CampaignName,
    
	'1069ec4f-7b77-46d7-b0ba-65ee35021088' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_shakti_PQ_Fogteams WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_shakti_PQ_Fogteams WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_shakti_PQ_Fogteams WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_shakti_PQ_Fogteams WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '1069ec4f-7b77-46d7-b0ba-65ee35021088'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_Shakti_PQ_Gnani' AS CampaignName,
    
	'prod-91d91aaOcc20' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_Shakti_PQ_Gnani WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_Shakti_PQ_Gnani WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_Shakti_PQ_Gnani WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_Shakti_PQ_Gnani WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = 'prod-91d91aaOcc20'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_shakti_PQ_OTP_Fogteams' AS CampaignName,
    
	'2c8dc98d-18bd-4197-9280-9648177dc79b' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_shakti_PQ_OTP_Fogteams WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_shakti_PQ_OTP_Fogteams WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_shakti_PQ_OTP_Fogteams WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_shakti_PQ_OTP_Fogteams WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '2c8dc98d-18bd-4197-9280-9648177dc79b'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_UBL_Sales_Greylabs' AS CampaignName,
    
	'7007' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_UBL_Sales_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_UBL_Sales_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_UBL_Sales_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_UBL_Sales_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '7007'),0) AS Duration

 
UNION ALL

SELECT 

    'voicebot_welcome_calling_PL' AS CampaignName,
    
	'ce0c96d8-316d-479d-b07f-31f313c10c14' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM voicebot_welcome_calling_PL WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM voicebot_welcome_calling_PL WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM voicebot_welcome_calling_PL WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM voicebot_welcome_calling_PL WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = 'ce0c96d8-316d-479d-b07f-31f313c10c14'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_welcome_calling_UBL' AS CampaignName,
    
	'1e508fca-92fc-48fb-8750-88a539848247' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_welcome_calling_UBL WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_welcome_calling_UBL WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_welcome_calling_UBL WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_welcome_calling_UBL WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '1e508fca-92fc-48fb-8750-88a539848247'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_welcome_calling_UCL' AS CampaignName,
    
	'ff423058-5ea4-4ce1-99bc-89628bc990d2' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_welcome_calling_UCL WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_welcome_calling_UCL WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_welcome_calling_UCL WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_welcome_calling_UCL WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = 'ff423058-5ea4-4ce1-99bc-89628bc990d2'),0) AS Duration

 
UNION ALL



SELECT 

    'Voicebot_Welcome_EF_NSNC' AS CampaignName,
    
	'74e5caa5-8b0d-4fa3-8af9-3c68f90c916a' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_Welcome_EF_NSNC WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_Welcome_EF_NSNC WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_Welcome_EF_NSNC WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_Welcome_EF_NSNC WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '74e5caa5-8b0d-4fa3-8af9-3c68f90c916a'),0) AS Duration

 
UNION ALL


SELECT 

    'Voicebot_welcome_MFI_Greylabs' AS CampaignName,
    
	'7006' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM Voicebot_welcome_MFI_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM Voicebot_welcome_MFI_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM Voicebot_welcome_MFI_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM Voicebot_welcome_MFI_Greylabs WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '7006'),0) AS Duration

 
UNION ALL


SELECT 

    'voicebot_welcome_vendor' AS CampaignName,

    '097f696c-1bdd-4ec0-804f-6e472ed9b9a0' AS STR_BOT_ID,

	 ISNULL((SELECT SUM(attempt) FROM voicebot_welcome_vendor WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalAttempts,

	 ISNULL(( SELECT DISTINCT COUNT(*) FROM voicebot_welcome_vendor WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate),0) AS TotalUniqueBase, 

    (SELECT COUNT(*) FROM voicebot_welcome_vendor WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalConnects,

	 (SELECT DISTINCT COUNT(*) FROM voicebot_welcome_vendor WITH(NOLOCK)

     WHERE CONVERT(varchar(20), Created_Date, 121) BETWEEN @FromDate AND @ToDate AND call_result = 33) AS TotalUniqueConnects,

	 ISNULL((SELECT sum(ceiling(b_playfraudalert/60.0)) as MinutesOfUsage
		FROM tbl_voicebot_reversefeed WITH(NOLOCK)
		WHERE ISNULL(b_playfraudalert,0) <>0 
		AND dt_created BETWEEN @FromDate AND @ToDate
		AND str_bot_id = '097f696c-1bdd-4ec0-804f-6e472ed9b9a0'),0) AS Duration

	END
	
