SELECT 
        [Der_Provider_Site_Code]
	   ,[Der_Provider_Code]
	   ,COUNT(*) AS Count
FROM [MESH_ECDS].[EC_Core_1]
WHERE [EC_Department_Type] = '01' -- a&e
  AND [Arrival_Planned] IN ('FALSE', 'NULL') -- exclude small number of known to be planned activity
GROUP BY 
        [Der_Provider_Site_Code]
	   ,[Der_Provider_Code]
ORDER BY [Der_Provider_Code]