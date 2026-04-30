WITH apc_by_icd AS (
    SELECT
         [Der_Pseudo_NHS_Number]
        ,[Der_Diagnosis_All]
        ,[Admission_Date]
        ,[Der_Commissioner_Code]
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
    WHERE [Der_Pseudo_NHS_Number] IS NOT NULL 
), lookback AS (
    SELECT
        a.[Der_Pseudo_NHS_Number],
        a.[Admission_Date],
        a.[Der_Diagnosis_All],
        a.[Der_Commissioner_Code],
        MAX(b.Frailty001) AS Frailty001b,
        MAX(b.Frailty002) AS Frailty002b,
        MAX(b.Frailty003) AS Frailty003b,
        MAX(b.Frailty004) AS Frailty004b,
        MAX(b.Frailty005) AS Frailty005b,
        MAX(b.Frailty006) AS Frailty006b,
        MAX(b.Frailty007) AS Frailty007b,
        MAX(b.Frailty008) AS Frailty008b,
        MAX(b.Frailty009) AS Frailty009b,
        MAX(b.Frailty010) AS Frailty010b,
        MAX(b.Frailty011) AS Frailty011b,
        MAX(b.Frailty012) AS Frailty012b,
        MAX(b.Frailty013) AS Frailty013b,
        MAX(b.Frailty014) AS Frailty014b,
        MAX(b.Frailty015) AS Frailty015b,
        MAX(b.Frailty016) AS Frailty016b,
        MAX(b.Frailty017) AS Frailty017b,
        MAX(b.Frailty018) AS Frailty018b,
        MAX(b.Frailty019) AS Frailty019b,
        MAX(b.Frailty020) AS Frailty020b,
        MAX(b.Frailty021) AS Frailty021b,
        MAX(b.Frailty022) AS Frailty022b,
        MAX(b.Frailty023) AS Frailty023b,
        MAX(b.Frailty024) AS Frailty024b,
        MAX(b.Frailty025) AS Frailty025b,
        MAX(b.Frailty026) AS Frailty026b,
        MAX(b.Frailty027) AS Frailty027b,
        MAX(b.Frailty028) AS Frailty028b,
        MAX(b.Frailty029) AS Frailty029b,
        MAX(b.Frailty030) AS Frailty030b,
        MAX(b.Frailty031) AS Frailty031b,
        MAX(b.Frailty032) AS Frailty032b,
        MAX(b.Frailty033) AS Frailty033b,
        MAX(b.Frailty034) AS Frailty034b,
        MAX(b.Frailty035) AS Frailty035b,
        MAX(b.Frailty036) AS Frailty036b,
        MAX(b.Frailty037) AS Frailty037b,
        MAX(b.Frailty038) AS Frailty038b,
        MAX(b.Frailty039) AS Frailty039b,
        MAX(b.Frailty040) AS Frailty040b,
        MAX(b.Frailty041) AS Frailty041b,
        MAX(b.Frailty042) AS Frailty042b,
        MAX(b.Frailty043) AS Frailty043b,
        MAX(b.Frailty044) AS Frailty044b,
        MAX(b.Frailty045) AS Frailty045b,
        MAX(b.Frailty056) AS Frailty056b,
        MAX(b.Frailty057) AS Frailty057b,
        MAX(b.Frailty058) AS Frailty058b,
        MAX(b.Frailty059) AS Frailty059b,
        MAX(b.Frailty060) AS Frailty060b,
        MAX(b.Frailty061) AS Frailty061b,
        MAX(b.Frailty062) AS Frailty062b,
        MAX(b.Frailty063) AS Frailty063b,
        MAX(b.Frailty064) AS Frailty064b,
        MAX(b.Frailty065) AS Frailty065b,
        MAX(b.Frailty066) AS Frailty066b,
        MAX(b.Frailty067) AS Frailty067b,
        MAX(b.Frailty068) AS Frailty068b,
        MAX(b.Frailty069) AS Frailty069b,
        MAX(b.Frailty070) AS Frailty070b,
        MAX(b.Frailty071) AS Frailty071b,
        MAX(b.Frailty072) AS Frailty072b,
        MAX(b.Frailty073) AS Frailty073b,
        MAX(b.Frailty074) AS Frailty074b,
        MAX(b.Frailty075) AS Frailty075b,
        MAX(b.Frailty076) AS Frailty076b,
        MAX(b.Frailty077) AS Frailty077b,
        MAX(b.Frailty078) AS Frailty078b,
        MAX(b.Frailty079) AS Frailty079b,
        MAX(b.Frailty081) AS Frailty081b,
        MAX(b.Frailty082) AS Frailty082b,
        MAX(b.Frailty083) AS Frailty083b,
        MAX(b.Frailty084) AS Frailty084b,
        MAX(b.Frailty085) AS Frailty085b,
        MAX(b.Frailty086) AS Frailty086b,
        MAX(b.Frailty087) AS Frailty087b,
        MAX(b.Frailty088) AS Frailty088b,
        MAX(b.Frailty089) AS Frailty089b,
        MAX(b.Frailty090) AS Frailty090b,
        MAX(b.Frailty091) AS Frailty091b,
        MAX(b.Frailty092) AS Frailty092b,
        MAX(b.Frailty093) AS Frailty093b,
        MAX(b.Frailty094) AS Frailty094b,
        MAX(b.Frailty095) AS Frailty095b,
        MAX(b.Frailty096) AS Frailty096b,
        MAX(b.Frailty097) AS Frailty097b,
        MAX(b.Frailty098) AS Frailty098b,
        MAX(b.Frailty099) AS Frailty099b,
        MAX(b.Frailty100) AS Frailty100b,
        MAX(b.Frailty101) AS Frailty101b,
        MAX(b.Frailty102) AS Frailty102b,
        MAX(b.Frailty103) AS Frailty103b,
        MAX(b.Frailty104) AS Frailty104b,
        MAX(b.Frailty105) AS Frailty105b,
        MAX(b.Frailty106) AS Frailty106b,
        MAX(b.Frailty107) AS Frailty107b,
        MAX(b.Frailty108) AS Frailty108b,
        MAX(b.Frailty109) AS Frailty109b,
        MAX(b.Frailty110) AS Frailty110b,
        MAX(b.Frailty111) AS Frailty111b,
        MAX(b.Frailty112) AS Frailty112b,
        MAX(b.Frailty113) AS Frailty113b,
        MAX(b.Frailty114) AS Frailty114b,
        MAX(b.Frailty115) AS Frailty115b,
        MAX(b.Frailty116) AS Frailty116b,
        MAX(b.Frailty117) AS Frailty117b,
        MAX(b.Frailty118) AS Frailty118b,
        MAX(b.Frailty119) AS Frailty119b,
        MAX(b.Frailty120) AS Frailty120b
 FROM apc_by_icd a
    LEFT JOIN apc_by_icd b
        ON b.[Der_Pseudo_NHS_Number] = a.[Der_Pseudo_NHS_Number]
       AND b.[Admission_Date] BETWEEN DATEADD(YEAR, -2, a.[Admission_Date])
                                   AND a.[Admission_Date]
    GROUP BY
        a.[Der_Pseudo_NHS_Number]
       ,a.[Admission_Date]
       ,a.[Der_Commissioner_Code]
       ,a.[Der_Diagnosis_All]
), frail_apc_admissions AS (
SELECT
    [Der_Pseudo_NHS_Number]
    ,[Admission_Date]
    ,[Der_Commissioner_Code]
    ,[Der_Diagnosis_All]
   ,ISNULL(Frailty001b, 0)
  + ISNULL(Frailty002b, 0)
  + ISNULL(Frailty003b, 0)
  + ISNULL(Frailty004b, 0)
  + ISNULL(Frailty005b, 0)
  + ISNULL(Frailty006b, 0)
  + ISNULL(Frailty007b, 0)
  + ISNULL(Frailty008b, 0)
  + ISNULL(Frailty009b, 0)
  + ISNULL(Frailty010b, 0)
  + ISNULL(Frailty011b, 0)
  + ISNULL(Frailty012b, 0)
  + ISNULL(Frailty013b, 0)
  + ISNULL(Frailty014b, 0)
  + ISNULL(Frailty015b, 0)
  + ISNULL(Frailty016b, 0)
  + ISNULL(Frailty017b, 0)
  + ISNULL(Frailty018b, 0)
  + ISNULL(Frailty019b, 0)
  + ISNULL(Frailty020b, 0)
  + ISNULL(Frailty021b, 0)
  + ISNULL(Frailty022b, 0)
  + ISNULL(Frailty023b, 0)
  + ISNULL(Frailty024b, 0)
  + ISNULL(Frailty025b, 0)
  + ISNULL(Frailty026b, 0)
  + ISNULL(Frailty027b, 0)
  + ISNULL(Frailty028b, 0)
  + ISNULL(Frailty029b, 0)
  + ISNULL(Frailty030b, 0)
  + ISNULL(Frailty031b, 0)
  + ISNULL(Frailty032b, 0)
  + ISNULL(Frailty033b, 0)
  + ISNULL(Frailty034b, 0)
  + ISNULL(Frailty035b, 0)
  + ISNULL(Frailty036b, 0)
  + ISNULL(Frailty037b, 0)
  + ISNULL(Frailty038b, 0)
  + ISNULL(Frailty039b, 0)
  + ISNULL(Frailty040b, 0)
  + ISNULL(Frailty041b, 0)
  + ISNULL(Frailty042b, 0)
  + ISNULL(Frailty043b, 0)
  + ISNULL(Frailty044b, 0)
  + ISNULL(Frailty045b, 0)
  + ISNULL(Frailty056b, 0)
  + ISNULL(Frailty057b, 0)
  + ISNULL(Frailty058b, 0)
  + ISNULL(Frailty059b, 0)
  + ISNULL(Frailty060b, 0)
  + ISNULL(Frailty061b, 0)
  + ISNULL(Frailty062b, 0)
  + ISNULL(Frailty063b, 0)
  + ISNULL(Frailty064b, 0)
  + ISNULL(Frailty065b, 0)
  + ISNULL(Frailty066b, 0)
  + ISNULL(Frailty067b, 0)
  + ISNULL(Frailty068b, 0)
  + ISNULL(Frailty069b, 0)
  + ISNULL(Frailty070b, 0)
  + ISNULL(Frailty071b, 0)
  + ISNULL(Frailty072b, 0)
  + ISNULL(Frailty073b, 0)
  + ISNULL(Frailty074b, 0)
  + ISNULL(Frailty075b, 0)
  + ISNULL(Frailty076b, 0)
  + ISNULL(Frailty077b, 0)
  + ISNULL(Frailty078b, 0)
  + ISNULL(Frailty079b, 0)
  + ISNULL(Frailty081b, 0)
  + ISNULL(Frailty082b, 0)
  + ISNULL(Frailty083b, 0)
  + ISNULL(Frailty084b, 0)
  + ISNULL(Frailty085b, 0)
  + ISNULL(Frailty086b, 0)
  + ISNULL(Frailty087b, 0)
  + ISNULL(Frailty088b, 0)
  + ISNULL(Frailty089b, 0)
  + ISNULL(Frailty090b, 0)
  + ISNULL(Frailty091b, 0)
  + ISNULL(Frailty092b, 0)
  + ISNULL(Frailty093b, 0)
  + ISNULL(Frailty094b, 0)
  + ISNULL(Frailty095b, 0)
  + ISNULL(Frailty096b, 0)
  + ISNULL(Frailty097b, 0)
  + ISNULL(Frailty098b, 0)
  + ISNULL(Frailty099b, 0)
  + ISNULL(Frailty100b, 0)
  + ISNULL(Frailty101b, 0)
  + ISNULL(Frailty102b, 0)
  + ISNULL(Frailty103b, 0)
  + ISNULL(Frailty104b, 0)
  + ISNULL(Frailty105b, 0)
  + ISNULL(Frailty106b, 0)
  + ISNULL(Frailty107b, 0)
  + ISNULL(Frailty108b, 0)
  + ISNULL(Frailty109b, 0)
  + ISNULL(Frailty110b, 0)
  + ISNULL(Frailty111b, 0)
  + ISNULL(Frailty112b, 0)
  + ISNULL(Frailty113b, 0)
  + ISNULL(Frailty114b, 0)
  + ISNULL(Frailty115b, 0)
  + ISNULL(Frailty116b, 0)
  + ISNULL(Frailty117b, 0)
  + ISNULL(Frailty118b, 0)
  + ISNULL(Frailty119b, 0)
  + ISNULL(Frailty120b, 0)  AS TotalFrailtyScore
FROM lookback
), frail_ids AS ( 
SELECT
    [Der_Pseudo_NHS_Number]
   ,[Admission_Date]
   ,[Der_Commissioner_Code]
   ,[Der_Diagnosis_All]
   ,TotalFrailtyScore
FROM frail_apc_admissions
WHERE TotalFrailtyScore > 4.9) 
SELECT 
        [Der_Commissioner_Code]
	   ,[Der_Provider_Code]
       ,[Der_Activity_Month]
	   ,COUNT(*) AS Count
FROM [MESH_ECDS].[EC_Core_1] c1
WHERE [EC_Department_Type] = '01' -- a&e
  AND [Arrival_Planned] IN ('FALSE', 'NULL') -- exclude small number of known to be planned activity
  AND EXISTS (
    SELECT 1
    FROM frail_ids c2
    WHERE c2.[Der_Pseudo_NHS_Number] = c1.[Der_Pseudo_NHS_Number]
    AND c2.[Admission_Date] BETWEEN DATEADD(year, -1, c1.[Arrival_Date]) AND DATEADD(year, 1, c1.[Arrival_Date])
    )
GROUP BY 
        [Der_Commissioner_Code]
	   ,[Der_Provider_Code]
       ,[Der_Activity_Month]