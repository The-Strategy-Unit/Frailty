SELECT
	  [Der_Provider_Code]
     ,[Der_Provider_Site_Code]
	 ,[Der_Activity_Month]
	 ,COUNT(*) AS Count
FROM [MESH_APC].[APCS_Core_Daily_1]
WHERE NOT ([Discharge_Destination] = ('98')) -- exclude unfinished spells
-- WHERE, to filter by frailty measure
GROUP BY 
	[Der_Provider_Code]
   ,[Der_Provider_Site_Code]
   ,[Der_Activity_Month]
