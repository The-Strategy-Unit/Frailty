
SELECT 
    [Der_Provider_Site_Code]
   ,[Der_Provider_Code]
   ,[Der_Activity_Month]
   , COUNT(*) AS Count
FROM 
	[MESH_ECDS].[EC_Core_1]
WHERE 
	[EC_Department_Type] = '01' -- a&e
AND [Arrival_Planned] IN ('FALSE', 'NULL') -- exclude small number of known to be planned activity
AND [EC_Arrival_Mode_SNOMED_CT] IN ( 
                                 --  '1047991000000102' -- prison transport
                                 -- ,'1048001000000106' -- police transport
                                     '1048021000000102' -- non emergency road ambulance
                                    ,'1048031000000100' -- emergency road ambulance
                                    ,'1048041000000109' -- emergency road ambulance with medical escort
                                    ,'1048051000000107' -- helicoper air ambulance
                                 -- ,'1048061000000105' -- public transport
                                 -- ,'1048071000000103' -- own transport
                                 -- ,'1048081000000101' -- medical repatriation air ambulance
                                    ) 
GROUP BY 
	[Der_Provider_Site_Code]
   ,[Der_Provider_Code]
   ,[Der_Activity_Month]