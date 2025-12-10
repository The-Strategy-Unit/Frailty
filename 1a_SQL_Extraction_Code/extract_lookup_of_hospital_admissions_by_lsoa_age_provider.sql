  SELECT 
	   [Der_Postcode_LSOA_2021_Code]
      ,[Der_Provider_Code]
      ,[Der_Provider_Site_Code]
	  ,[Der_Age_At_CDS_Activity_Date]
	  ,COUNT(*) AS Count
  FROM [SUS_APC].[APCS_Core_Monthly_Historic_1] 
  WHERE [Der_Age_At_CDS_Activity_Date] <= 25
  AND [Der_Age_At_CDS_Activity_Date] >= 0 
  AND [Der_Activity_Month] > '202106'
  AND [Der_Activity_Month] <= '202406'
  GROUP BY 
 	    [Der_Postcode_LSOA_2021_Code]
      ,[Der_Provider_Code]
       ,[Der_Provider_Site_Code]
	   ,[Der_Age_At_CDS_Activity_Date]



							
