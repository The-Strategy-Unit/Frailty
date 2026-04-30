
SELECT TOP (500)
     [Der_Provider_Site_Code]
   , [Der_Provider_Code]
   , [Der_Activity_Month]
   ,([EC_Departure_Time_Since_Arrival] - [Clinically_Ready_To_Proceed_Time_Since_Arrival]) 
       AS [Departure_Since_Ready_To_Proceed]
FROM 
	[MESH_ECDS].[EC_Core_1]
WHERE 
	[EC_Department_Type] = '01' -- a&e
AND [Arrival_Planned] IN ('FALSE', 'NULL') -- exclude small number of known to be planned activity
