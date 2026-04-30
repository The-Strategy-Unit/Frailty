SELECT 
	   [Der_Postcode_LSOA_2021_Code]
       ,[Der_Provider_Site_Code]
	   ,[Der_Provider_Code]
	   ,[Der_Age_At_CDS_Activity_Date]
	  , COUNT(*) AS Count
  FROM [MESH_ECDS].[EC_Core_1]
  WHERE [Der_Age_At_CDS_Activity_Date] <= 25
  AND [Der_Age_At_CDS_Activity_Date] >= 0 
  AND [EC_Department_Type] = '01' -- a&e
  AND [Der_Activity_Month] > '201806'
  AND [Der_Activity_Month] <= '202406'
   GROUP BY 
 	    [Der_Postcode_LSOA_2021_Code]
       ,[Der_Provider_Site_Code]
	   ,[Der_Provider_Code]
	   ,[Der_Age_At_CDS_Activity_Date] 
	ORDER BY [Der_Provider_Code]