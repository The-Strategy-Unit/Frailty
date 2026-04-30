-- Create the first temporary table --
WITH Temp_Tbl1 AS (
SELECT
	  [Der_Provider_Code]
     ,[Der_Provider_Site_Code]
	 ,[Der_Activity_Month]
	 ,[Age_At_CDS_Activity_Date]
	 ,[Discharge_Destination]
	 ,[Source_of_Admission]
	 , CASE 
		WHEN ([Discharge_Destination] IN ('19', '29')) THEN 'residence'
		WHEN ([Discharge_Destination] IN ('37', '38', '40', '42')) THEN 'legal system'
		WHEN ([Discharge_Destination] IN ('30', '48', '49')) THEN 'secure psychiatric'
		WHEN ([Discharge_Destination] IN ('50', '84')) THEN 'secure hospital (NHS or independent)'
		WHEN ([Discharge_Destination] IN ('51', '52', '53', '87')) THEN 'other hospital'
		WHEN ([Discharge_Destination] IN ('54', '55', '56', '65', '85')) THEN 'care home' -- incl. local authority residental accomodation & non-NHS care home
		WHEN ([Discharge_Destination] IN ('66')) THEN 'foster care'
		WHEN ([Discharge_Destination] IN ('79')) THEN 'patient died'
		WHEN ([Discharge_Destination] IN ('88')) THEN 'hospice'
		WHEN ([Discharge_Destination] IN ('89')) THEN 'forced repatriation'
		WHEN ([Discharge_Destination] IN ('98')) THEN 'spell not finished'
		WHEN ([Discharge_Destination] IN ('99')) THEN 'unknown'
		WHEN ([Discharge_Destination] IS NULL) THEN 'unknown'
		ELSE 'other'
	   END AS [Discharge_Location]
	, CASE 
		WHEN ([Source_of_Admission] IN ('19', '29')) THEN 'residence'
		WHEN ([Source_of_Admission] IN ('37', '38', '39', '40', '42')) THEN 'legal system'
		WHEN ([Source_of_Admission] IN ('30', '48', '49')) THEN 'secure psychiatric'
		WHEN ([Source_of_Admission] IN ('50', '84')) THEN 'secure hospital (NHS or independent)'
		WHEN ([Source_of_Admission] IN ('51', '52', '53', '87')) THEN 'other hospital'
		WHEN ([Source_of_Admission] IN ('54', '55', '56', '65', '85')) THEN 'care home' -- incl. local authority residental accomodation & non-NHS care home
		WHEN ([Source_of_Admission] IN ('66')) THEN 'foster care'
		WHEN ([Source_of_Admission] IN ('79')) THEN 'patient born'
		WHEN ([Source_of_Admission] IN ('88')) THEN 'hospice'
		WHEN ([Source_of_Admission] IN ('89')) THEN 'forced repatriation'
		WHEN ([Source_of_Admission] IN ('98')) THEN 'not applicable'
		WHEN ([Source_of_Admission] IN ('99')) THEN 'unknown'
		WHEN ([Source_of_Admission] IS NULL) THEN 'unknown'
		ELSE 'other'
	   END AS [Admission_Location]
FROM  [MESH_APC].[APCS_Core_Daily_1]  ),
 -- create the second temporary table --
Temp_Tbl2 AS (
SELECT
	  [Der_Provider_Code]
     ,[Der_Provider_Site_Code]
	 ,[Der_Activity_Month]
	 ,[Admission_Location]
	 ,[Discharge_Location]
	 , CASE
		 WHEN ([Discharge_Location] = 'residence') THEN 'usual residence'
	 	 WHEN ([Discharge_Location] = 'foster care') THEN 'ususal residence'
		 WHEN ([Discharge_Location] = 'legal system') THEN 'exclude'
		 WHEN ([Discharge_Location] = 'patient died') THEN 'exclude'
	 	 WHEN ([Discharge_Location] = 'spell not finished') THEN 'exclude'
	 	 WHEN ([Discharge_Location] = 'forced repatriation') THEN 'exclude'
		 WHEN ([Discharge_Location] = 'care home' AND [Admission_Location] = 'care home') THEN 'care home to care home'
	 	 WHEN ([Discharge_Location] = 'hospice' AND [Admission_Location] = 'hospice') THEN 'hospice to hospice'
		 WHEN ([Discharge_Location] = [Admission_Location]) THEN 'admissions equals discharge'
		 WHEN ([Discharge_Location] = 'care home') THEN 'not usual residence'
	 	 WHEN ([Discharge_Location] = 'hospice') THEN 'not usual residence'
	 	 WHEN ([Discharge_Location] = 'other hospital') THEN 'not usual residence'
	 	 WHEN ([Discharge_Location] = 'secure hospital (NHS or independent)') THEN 'not usual residence'
	 	 WHEN ([Discharge_Location] = 'secure psychiatric') THEN 'not usual residence'
	 	 WHEN ([Discharge_Location] = 'unknown') THEN 'exclude'
		 ELSE 'problem'
	   END AS [Discharged_To_Usual_Residence]
FROM Temp_Tbl1 )  -- This is where the filter by frailty condition would go using WHERE
-- create the final table with the grouping and count --
SELECT
	  [Der_Provider_Code]
     ,[Der_Provider_Site_Code]
	 ,[Der_Activity_Month]
	 ,[Discharged_To_Usual_Residence]
	 ,COUNT(*) AS Count
FROM Temp_Tbl2
GROUP BY 
	[Der_Provider_Code]
   ,[Der_Provider_Site_Code]
   ,[Der_Activity_Month]
   ,[Discharged_To_Usual_Residence]
