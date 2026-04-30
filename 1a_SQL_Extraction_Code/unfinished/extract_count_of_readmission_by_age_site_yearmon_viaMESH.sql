WITH PreviousDischargeTbl AS (
SELECT 
       [Der_Pseudo_NHS_Number]
	  ,[Admission_Date]  
      ,[Discharge_Date]
	  ,[Der_Diagnosis_All]
	  ,[Sex]
	  ,[Admission_Method]
	  ,[Der_Dischg_Treatment_Function_Code]
	  ,[Discharge_Method] 
	  ,[Der_Procedure_All]
	  ,[Age_At_CDS_Activity_Date]
	  ,[Der_Provider_Site_Code]
		,[Der_Provider_Code]
	  , LAG( [Discharge_Date] ) OVER (PARTITION BY [Der_Pseudo_NHS_Number] ORDER BY [Admission_Date]) AS PreviousDischarge
	  , LAG( [Admission_Method] ) OVER (PARTITION BY [Der_Pseudo_NHS_Number] ORDER BY [Admission_Date]) AS PreviousAdmissionMethod
	  , LAG( [Discharge_Method] ) OVER (PARTITION BY [Der_Pseudo_NHS_Number] ORDER BY [Admission_Date]) AS PreviousDischargeMethod
	  , LAG( [Patient_Classification] ) OVER (PARTITION BY [Der_Pseudo_NHS_Number] ORDER BY [Admission_Date]) AS PreviousPatClass
	  , LAG( [Der_Procedure_All] ) OVER (PARTITION BY [Der_Pseudo_NHS_Number] ORDER BY [Admission_Date]) AS PreviousProcedures
	  , LAG( [Der_Diagnosis_All] ) OVER (PARTITION BY [Der_Pseudo_NHS_Number] ORDER BY [Admission_Date]) AS PreviousDiagnoses
	  , LAG( [Discharge_Date] ) OVER (PARTITION BY [Der_Pseudo_NHS_Number] ORDER BY [Admission_Date]) AS PreviousDischargeDate

FROM [SUS_APC].[APCS_Core_Monthly_Historic_1] 
WHERE [Age_At_CDS_Activity_Date] < 28)
SELECT FORMAT(PreviousDischargeDate, 'yyyy-MM') AS Year_Month
	  ,[Der_Provider_Site_Code]
		,[Der_Provider_Code]
	  ,[Age_At_CDS_Activity_Date]
	  , COUNT(*) AS Count
FROM PreviousDischargeTbl
WHERE [Admission_Date] > PreviousDischarge
AND [Discharge_Method] IN (1,3)
AND [Admission_Method] IN ('21', '22', '23', '24', '25', '28', 
						   '2A', '2B', '2C', '2D')
AND PreviousAdmissionMethod IN ('11', '12', '13', 
						   '21', '22', '23', '24', '25', '28', 
						   '2A', '2B', '2C', '2D', 
						   '31', '32', 
						   '81', '82', '83', '84', '89')
AND PreviousPatClass = 1
AND [Sex] IN (1,2)
AND [Der_Diagnosis_All] NOT LIKE '%C%'-- Cancer
AND [Der_Diagnosis_All] NOT LIKE '%D37%'
AND [Der_Diagnosis_All] NOT LIKE '%D38%'
AND [Der_Diagnosis_All] NOT LIKE '%D39%'
AND [Der_Diagnosis_All] NOT LIKE '%D40%'
AND [Der_Diagnosis_All] NOT LIKE '%D41%'
AND [Der_Diagnosis_All] NOT LIKE '%D42%'
AND [Der_Diagnosis_All] NOT LIKE '%D43%'
AND [Der_Diagnosis_All] NOT LIKE '%D44%'
AND [Der_Diagnosis_All] NOT LIKE '%D45%'
AND [Der_Diagnosis_All] NOT LIKE '%D46%'
AND [Der_Diagnosis_All] NOT LIKE '%D47%'
AND [Der_Diagnosis_All] NOT LIKE '%D48%'
AND [Der_Diagnosis_All] NOT LIKE '%Z51.1%' -- Chemotherapy
AND [Der_Diagnosis_All] NOT LIKE '%O%' -- Obstetrics
AND PreviousDiagnoses NOT LIKE '%C%'
AND PreviousDiagnoses NOT LIKE '%D37%'
AND PreviousDiagnoses NOT LIKE '%D38%'
AND PreviousDiagnoses NOT LIKE '%D39%'
AND PreviousDiagnoses NOT LIKE '%D40%'
AND PreviousDiagnoses NOT LIKE '%D41%'
AND PreviousDiagnoses NOT LIKE '%D42%'
AND PreviousDiagnoses NOT LIKE '%D43%'
AND PreviousDiagnoses NOT LIKE '%D44%'
AND PreviousDiagnoses NOT LIKE '%D45%'
AND PreviousDiagnoses NOT LIKE '%D46%'
AND PreviousDiagnoses NOT LIKE '%D47%'
AND PreviousDiagnoses NOT LIKE '%D48%'
AND PreviousDiagnoses NOT LIKE '%Z51.1%'
AND PreviousDiagnoses NOT LIKE '%O%'
AND [Der_Dischg_Treatment_Function_Code] NOT IN (501, 560, 610)
AND DATEDIFF(DAY, PreviousDischarge, [Admission_Date]) < 30
GROUP BY FORMAT(PreviousDischargeDate, 'yyyy-MM')
		,[Der_Provider_Site_Code]
		,[Der_Provider_Code]
		,[Age_At_CDS_Activity_Date]

