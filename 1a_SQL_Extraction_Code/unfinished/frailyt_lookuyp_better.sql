WITH apc_by_icd AS (
    SELECT TOP (2000)
         [Der_Pseudo_NHS_Number]
        ,[Der_Diagnosis_All]
        ,[Admission_Date]
        -- pg1 --
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%F00%' THEN 7.1 ELSE 0 END) AS Frailty001 -- Dementia in Alzheimer's disease
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%G81%' THEN 4.4 ELSE 0 END) AS Frailty002 -- Hemiplegia 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%G30%' THEN 4.0 ELSE 0 END) AS Frailty003 -- Alzheimer's disease 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%I69%' THEN 3.7 ELSE 0 END) AS Frailty004 -- Sequelae of cerebrovascular disease (secondary codes) 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R29%' THEN 3.6 ELSE 0 END) AS Frailty005 -- Other symptoms and signs involving the nervous and musculoskeletal systems (R29·6 Tendency to fall) 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%N39%' THEN 3.2 ELSE 0 END) AS Frailty006 -- Other disorders of urinary system 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%F05%' THEN 3.2 ELSE 0 END) AS Frailty007 -- Delirium, not induced by alcohol and other psychoactive substances 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%W19%' THEN 3.2 ELSE 0 END) AS Frailty008 -- Unspecified fall 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%S00%' THEN 3.2 ELSE 0 END) AS Frailty009 -- Superficial injury of head 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R31%' THEN 3.0 ELSE 0 END) AS Frailty010 -- Unspecified haematuria 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%B96%' THEN 2.9 ELSE 0 END) AS Frailty011 -- Other bacterial agents as the cause of diseases classified to other chapters (secondary code) 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R41%' THEN 2.7 ELSE 0 END) AS Frailty012 -- Other symptoms and signs involving cognitive functions and awareness 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R26%' THEN 2.6 ELSE 0 END) AS Frailty013 -- Abnormalities of gait and mobility 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%I67%' THEN 2.6 ELSE 0 END) AS Frailty014 -- Other cerebrovascular diseases  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R56%' THEN 2.6 ELSE 0 END) AS Frailty015 -- Convulsions, not elsewhere classified 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R40%' THEN 2.5 ELSE 0 END) AS Frailty016 -- Somnolence, stupor and coma  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%T83%' THEN 2.4 ELSE 0 END) AS Frailty017 -- Complications of genitourinary prosthetic devices, implants and grafts 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%S06%' THEN 2.4 ELSE 0 END) AS Frailty018 -- Intracranial injury  
        -- pg 2 --
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%S42%' THEN 2.3 ELSE 0 END) AS Frailty019 -- Fracture of shoulder and upper arm  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%E87%' THEN 2.3 ELSE 0 END) AS Frailty020 -- Other disorders of fluid, electrolyte and acidbase balance
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%M25%' THEN 2.3 ELSE 0 END) AS Frailty021 -- Other joint disorders, not elsewhere classified  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%E86%' THEN 2.3 ELSE 0 END) AS Frailty022 -- Volume depletion 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R54%' THEN 2.2 ELSE 0 END) AS Frailty023 -- Senility  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%Z50%' THEN 2.1 ELSE 0 END) AS Frailty024 -- Care involving use of rehabilitation procedures 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%F03%' THEN 2.1 ELSE 0 END) AS Frailty025 -- Unspecified dementia  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%W18%' THEN 2.1 ELSE 0 END) AS Frailty026 -- Other fall on same level  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%Z75%' THEN 2.0 ELSE 0 END) AS Frailty027 -- Problems related to medical facilities and other health care 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%F01%' THEN 2.0 ELSE 0 END) AS Frailty028 -- Vascular dementia 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%S80%' THEN 2.0 ELSE 0 END) AS Frailty029 -- Superficial injury of lower leg 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%L03%' THEN 2.0 ELSE 0 END) AS Frailty030 -- Cellulitis  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%H54%' THEN 1.9 ELSE 0 END) AS Frailty031 -- Blindness and low vision
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%E53%' THEN 1.9 ELSE 0 END) AS Frailty032 -- Deficiency of other B group vitamins  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%Z60%' THEN 1.8 ELSE 0 END) AS Frailty033 -- Problems related to social environment  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%G20%' THEN 1.8 ELSE 0 END) AS Frailty034 -- Parkinson's disease 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R55%' THEN 1.8 ELSE 0 END) AS Frailty035 -- Syncope and collapse 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%S22%' THEN 1.8 ELSE 0 END) AS Frailty036 -- Fracture of rib(s), sternum and thoracic spine 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%K59%' THEN 1.8 ELSE 0 END) AS Frailty037 -- Other functional intestinal disorders  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%N17%' THEN 1.8 ELSE 0 END) AS Frailty038 -- Acute renal failure 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%L89%' THEN 1.7 ELSE 0 END) AS Frailty039 -- Decubitus ulcer 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%Z22%' THEN 1.7 ELSE 0 END) AS Frailty040 -- Carrier of infectious disease  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%B95%' THEN 1.7 ELSE 0 END) AS Frailty041 -- Streptococcus and staphylococcus as the cause of diseases classified to other chapters 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%L97%' THEN 1.6 ELSE 0 END) AS Frailty042 -- Ulcer of lower limb, not elsewhere classified 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R44%' THEN 1.6 ELSE 0 END) AS Frailty043 -- Other symptoms and signs involving general sensations and perceptions 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%K26%' THEN 1.6 ELSE 0 END) AS Frailty044 -- Duodenal ulcer 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%I95%' THEN 1.6 ELSE 0 END) AS Frailty045 -- Hypotension  
        -- pg 3 --
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%N19%' THEN 1.6 ELSE 0 END) AS Frailty056 -- Unspecified renal failure 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%A41%' THEN 1.6 ELSE 0 END) AS Frailty057 -- Other septicaemia 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%Z87%' THEN 1.5 ELSE 0 END) AS Frailty058 -- Personal history of other diseases and conditions 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%J96%' THEN 1.5 ELSE 0 END) AS Frailty059 -- Respiratory failure, not elsewhere classified  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%X59%' THEN 1.5 ELSE 0 END) AS Frailty060 -- Exposure to unspecified factor 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%M19%' THEN 1.5 ELSE 0 END) AS Frailty061 -- Other arthrosis  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%G40%' THEN 1.5 ELSE 0 END) AS Frailty062 -- Epilepsy 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%M81%' THEN 1.4 ELSE 0 END) AS Frailty063 -- Osteoporosis without pathological fracture 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%S72%' THEN 1.4 ELSE 0 END) AS Frailty064 -- Fracture of femur 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%S32%' THEN 1.4 ELSE 0 END) AS Frailty065 -- Fracture of lumbar spine and pelvis 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%E16%' THEN 1.4 ELSE 0 END) AS Frailty066 -- Other disorders of pancreatic internal secretion 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R94%' THEN 1.4 ELSE 0 END) AS Frailty067 -- Abnormal results of function studies 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%N18%' THEN 1.4 ELSE 0 END) AS Frailty068 -- Chronic renal failure  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R33%' THEN 1.3 ELSE 0 END) AS Frailty069 -- Retention of urine  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R69%' THEN 1.3 ELSE 0 END) AS Frailty070 -- Unknown and unspecified causes of morbidity 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%N28%' THEN 1.3 ELSE 0 END) AS Frailty071 -- Other disorders of kidney and ureter, not elsewhere classified 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R32%' THEN 1.2 ELSE 0 END) AS Frailty072 -- Unspecified urinary incontinence 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%G31%' THEN 1.2 ELSE 0 END) AS Frailty073 -- Other degenerative diseases of nervous system, not elsewhere classified 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%Y95%' THEN 1.2 ELSE 0 END) AS Frailty074 -- Nosocomial condition  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%S09%' THEN 1.2 ELSE 0 END) AS Frailty075 -- Other and unspecified injuries of head  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R45%' THEN 1.2 ELSE 0 END) AS Frailty076 -- Symptoms and signs involving emotional state 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%G45%' THEN 1.2 ELSE 0 END) AS Frailty077 -- Transient cerebral ischaemic attacks and related syndromes 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%Z74%' THEN 1.1 ELSE 0 END) AS Frailty078 -- Problems related to care-provider dependency 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%M79%' THEN 1.1 ELSE 0 END) AS Frailty079 -- Other soft tissue disorders, not elsewhere classified 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%W06%' THEN 1.1 ELSE 0 END) AS Frailty081 -- Fall involving bed 
        -- pg 4 --
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%S01%' THEN 1.1 ELSE 0 END) AS Frailty082 -- Open wound of head  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%A04%' THEN 1.1 ELSE 0 END) AS Frailty083 -- Other bacterial intestinal infections 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%A09%' THEN 1.1 ELSE 0 END) AS Frailty084 -- Diarrhoea and gastroenteritis of presumed infectious origin 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%J18%' THEN 1.1 ELSE 0 END) AS Frailty085 -- Pneumonia, organism unspecified 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%J69%' THEN 1.0 ELSE 0 END) AS Frailty086 -- Pneumonitis due to solids and liquids 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R47%' THEN 1.0 ELSE 0 END) AS Frailty087 -- Speech disturbances, not elsewhere classified 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%E55%' THEN 1.0 ELSE 0 END) AS Frailty088 -- Vitamin D deficiency 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%Z93%' THEN 1.0 ELSE 0 END) AS Frailty089 -- Artificial opening status  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R63%' THEN 0.9 ELSE 0 END) AS Frailty090 -- Gangrene, not elsewhere classified  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R02%' THEN 1.0 ELSE 0 END) AS Frailty091 -- Symptoms and signs concerning food and fluid intake 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%H91%' THEN 0.9 ELSE 0 END) AS Frailty092 -- Other hearing loss 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%W10%' THEN 0.9 ELSE 0 END) AS Frailty093 -- Fall on and from stairs and steps  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%W01%' THEN 0.9 ELSE 0 END) AS Frailty094 -- Fall on same level from slipping, tripping and stumbling 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%E05%' THEN 0.9 ELSE 0 END) AS Frailty095 -- Thyrotoxicosis [hyperthyroidism] 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%M41%' THEN 0.9 ELSE 0 END) AS Frailty096 -- Scoliosis 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R13%' THEN 0.8 ELSE 0 END) AS Frailty097 -- Dysphagia  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%Z99%' THEN 0.8 ELSE 0 END) AS Frailty098 -- Dependence on enabling machines and devices 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%U80%' THEN 0.8 ELSE 0 END) AS Frailty099 -- Agent resistant to penicillin and related antibiotics 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%M80%' THEN 0.8 ELSE 0 END) AS Frailty100 -- Osteoporosis with pathological fracture
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%K92%' THEN 0.8 ELSE 0 END) AS Frailty101 -- Other diseases of digestive system 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%I63%' THEN 0.8 ELSE 0 END) AS Frailty102 -- Cerebral Infarction  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%N20%' THEN 0.7 ELSE 0 END) AS Frailty103 -- Calculus of kidney and ureter 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%F10%' THEN 0.7 ELSE 0 END) AS Frailty104 -- Mental and behavioural disorders due to use of alcohol 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%Y84%' THEN 0.7 ELSE 0 END) AS Frailty105 -- Other medical procedures as the cause of abnormal reaction of the patient 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R00%' THEN 0.7 ELSE 0 END) AS Frailty106 -- Abnormalities of heart beat
        -- pg 5 --
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%J22%' THEN 0.7 ELSE 0 END) AS Frailty107 -- Unspecified acute lower respiratory infection 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%Z73%' THEN 0.6 ELSE 0 END) AS Frailty108 -- Problems related to life-management difficulty 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R79%' THEN 0.6 ELSE 0 END) AS Frailty109 -- Other abnormal findings of blood chemistry 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%Z91%' THEN 0.5 ELSE 0 END) AS Frailty110 -- Personal history of risk-factors, not elsewhere classified 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%S51%' THEN 0.5 ELSE 0 END) AS Frailty111 -- Open wound of forearm 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%F32%' THEN 0.5 ELSE 0 END) AS Frailty112 -- Depressive episode 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%M48%' THEN 0.5 ELSE 0 END) AS Frailty113 -- Spinal stenosis (secondary code only) 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%E83%' THEN 0.4 ELSE 0 END) AS Frailty114 -- Disorders of mineral metabolism  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%M15%' THEN 0.4 ELSE 0 END) AS Frailty115 -- Polyarthrosis 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%D64%' THEN 0.4 ELSE 0 END) AS Frailty116 -- Other anaemias  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%L08%' THEN 0.4 ELSE 0 END) AS Frailty117 -- Other local infections of skin and subcutaneous tissue 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R11%' THEN 0.3 ELSE 0 END) AS Frailty118 -- Nausea and vomiting  
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%K52%' THEN 0.3 ELSE 0 END) AS Frailty119 -- Other noninfective gastroenteritis and colitis 
        ,(CASE WHEN [Der_Diagnosis_All] LIKE '%R50%' THEN 0.1 ELSE 0 END) AS Frailty120 -- Fever of unknown origin 
    FROM [MESH_APC].[APCS_Core_Daily_1]
    WHERE [Der_Pseudo_NHS_Number] IS NOT NULL  -- Ensure no NULL NHS Numbers are included
) 
SELECT 
    [Der_Pseudo_NHS_Number]
   ,[Der_Diagnosis_All]
   ,[Admission_Date]
   , Frailty001
   , Frailty002
   , Frailty003
   , Frailty004
   , Frailty005
   , Frailty006
   , Frailty007
   , Frailty008
   , Frailty009
   , Frailty010
   , Frailty011
   , Frailty012
   , Frailty013
   , Frailty014
   , Frailty015
   , Frailty016
   , Frailty017
   , Frailty018
   , Frailty019
   , Frailty020
   , Frailty021
   , Frailty022
   , Frailty023
   , Frailty024
   , Frailty025
   , Frailty026
   , Frailty027
   , Frailty028
   , Frailty029
   , Frailty030
   , Frailty031
   , Frailty032
   , Frailty033
   , Frailty034
   , Frailty035
   , Frailty036
   , Frailty037
   , Frailty038
   , Frailty039
   , Frailty040
   , Frailty041
   , Frailty042
   , Frailty043
   , Frailty044
   , Frailty045
   , Frailty056
   , Frailty057
   , Frailty058
   , Frailty059
   , Frailty060
   , Frailty061
   , Frailty062
   , Frailty063
   , Frailty064
   , Frailty065
   , Frailty066
   , Frailty067
   , Frailty068
   , Frailty069
   , Frailty070
   , Frailty071
   , Frailty072
   , Frailty073
   , Frailty074
   , Frailty075
   , Frailty076
   , Frailty077
   , Frailty078
   , Frailty079
   , Frailty081
   , Frailty082
   , Frailty083
   , Frailty084
   , Frailty085
   , Frailty086
   , Frailty087
   , Frailty088
   , Frailty089
   , Frailty090
   , Frailty091
   , Frailty092
   , Frailty093
   , Frailty094
   , Frailty095
   , Frailty096
   , Frailty097
   , Frailty098
   , Frailty099
   , Frailty100
   , Frailty101
   , Frailty102
   , Frailty103
   , Frailty104
   , Frailty105
   , Frailty106
   , Frailty107
   , Frailty108
   , Frailty109
   , Frailty110
   , Frailty111
   , Frailty112
   , Frailty113
   , Frailty114
   , Frailty115
   , Frailty116
   , Frailty117
   , Frailty118
   , Frailty119
   , Frailty120
FROM apc_by_icd