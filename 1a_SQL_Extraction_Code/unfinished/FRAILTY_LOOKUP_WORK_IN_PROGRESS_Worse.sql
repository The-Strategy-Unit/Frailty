WITH frailty_scores AS (
-- PAGE ONE --
    SELECT 'F00' AS icd_code, 7.1 AS score -- Dementia in Alzheimer's disease
    UNION ALL
    SELECT 'G81', 4.4  -- Hemiplegia
    UNION ALL
    SELECT 'G30', 4.0 -- Alzheimer's disease
    UNION ALL
    SELECT 'I69', 3.7 -- Sequelae of cerebrovascular disease (secondary codes)
    UNION ALL
    SELECT 'R29', 3.6 -- Other symptoms and signs involving the nervous and musculoskeletal systems (R29·6 Tendency to fall)
    UNION ALL
    SELECT 'N39', 3.2 -- Other disorders of urinary system
    UNION ALL
    SELECT 'F05', 3.2 -- Delirium, not induced by alcohol and other psychoactive substances
    UNION ALL
    SELECT 'W19', 3.2 -- Unspecified fall
    UNION ALL
    SELECT 'S00', 3.2 -- Superficial injury of head
    UNION ALL
    SELECT 'R31', 3.0 -- Unspecified haematuria
    UNION ALL
    SELECT 'B96', 2.9 -- Other bacterial agents as the cause of diseases classified to other chapters (secondary code)
    UNION ALL
    SELECT 'R41', 2.7 -- Other symptoms and signs involving cognitive functions and awareness
    UNION ALL
    SELECT 'R26', 2.6 -- Abnormalities of gait and mobility
    UNION ALL
    SELECT 'I67', 2.6 -- Other cerebrovascular diseases 
    UNION ALL
    SELECT 'R56', 2.6 -- Convulsions, not elsewhere classified
    UNION ALL
    SELECT 'R40', 2.5 -- Somnolence, stupor and coma 
    UNION ALL
    SELECT 'T83', 2.4 -- Complications of genitourinary prosthetic devices, implants and grafts
    UNION ALL
    SELECT 'S06', 2.4 -- Intracranial injury 
    UNION ALL
-- PAGE TWO --
    SELECT 'S42', 2.3 -- Fracture of shoulder and upper arm 
    UNION ALL
    SELECT 'E87', 2.3 -- Other disorders of fluid, electrolyte and acidbase balance
    UNION ALL
    SELECT 'M25', 2.3 -- Other joint disorders, not elsewhere classified 
    UNION ALL
    SELECT 'E86', 2.3 -- Volume depletion 
    UNION ALL
    SELECT 'R54', 2.2 -- Senility 
    UNION ALL
    SELECT 'Z50', 2.1 -- Care involving use of rehabilitation procedures
    UNION ALL
    SELECT 'F03', 2.1 -- Unspecified dementia 
    UNION ALL
    SELECT 'W18', 2.1 -- Other fall on same level 
    UNION ALL
    SELECT 'Z75', 2.0 -- Problems related to medical facilities and other health care
    UNION ALL
    SELECT 'F01', 2.0 -- Vascular dementia
    UNION ALL
    SELECT 'S80', 2.0 -- Superficial injury of lower leg
    UNION ALL
    SELECT 'L03', 2.0 -- Cellulitis 
    UNION ALL
    SELECT 'H54', 1.9 -- Blindness and low vision
    UNION ALL
    SELECT 'E53', 1.9 -- Deficiency of other B group vitamins 
    UNION ALL
    SELECT 'Z60', 1.8 -- Problems related to social environment
    UNION ALL
    SELECT 'G20', 1.8 -- Parkinson's disease
    UNION ALL
    SELECT 'R55', 1.8 -- Syncope and collapse
    UNION ALL
    SELECT 'S22', 1.8 -- Fracture of rib(s), sternum and thoracic spine
    UNION ALL
    SELECT 'K59', 1.8 -- Other functional intestinal disorders 
    UNION ALL
    SELECT 'N17', 1.8 -- Acute renal failure
    UNION ALL
    SELECT 'L89', 1.7 -- Decubitus ulcer
    UNION ALL
    SELECT 'Z22', 1.7 -- Carrier of infectious disease 
    UNION ALL
    SELECT 'B95', 1.7 -- Streptococcus and staphylococcus as the cause of diseases classified to other chapters
    UNION ALL
    SELECT 'L97', 1.6 -- Ulcer of lower limb, not elsewhere classified
    UNION ALL
    SELECT 'R44', 1.6 -- Other symptoms and signs involving general sensations and perceptions
    UNION ALL
    SELECT 'K26', 1.6 -- Duodenal ulcer
    UNION ALL
    SELECT 'I95', 1.6 -- Hypotension
    UNION ALL 
-- PAGE THREE --
    SELECT 'N19', 1.6 -- Unspecified renal failure
    UNION ALL
    SELECT 'A41', 1.6 -- Other septicaemia
    UNION ALL
    SELECT 'Z87', 1.5 -- Personal history of other diseases and conditions
    UNION ALL
    SELECT 'J96', 1.5 -- Respiratory failure, not elsewhere classified 
    UNION ALL
    SELECT 'X59', 1.5 -- Exposure to unspecified factor
    UNION ALL
    SELECT 'M19', 1.5 -- Other arthrosis 
    UNION ALL
    SELECT 'G40', 1.5 -- Epilepsy
    UNION ALL
    SELECT 'M81', 1.4 -- Osteoporosis without pathological fracture
    UNION ALL
    SELECT 'S72', 1.4 -- Fracture of femur
    UNION ALL
    SELECT 'S32', 1.4 -- Fracture of lumbar spine and pelvis
    UNION ALL
    SELECT 'E16', 1.4 -- Other disorders of pancreatic internal secretion
    UNION ALL
    SELECT 'R94', 1.4 -- Abnormal results of function studies
    UNION ALL
    SELECT 'N18', 1.4 -- Chronic renal failure 
    UNION ALL
    SELECT 'R33', 1.3 -- Retention of urine 
    UNION ALL
    SELECT 'R69', 1.3 -- Unknown and unspecified causes of morbidity
    UNION ALL
    SELECT 'N28', 1.3 -- Other disorders of kidney and ureter, not elsewhere classified
    UNION ALL
    SELECT 'R32', 1.2 -- Unspecified urinary incontinence
    UNION ALL
    SELECT 'G31', 1.2 -- Other degenerative diseases of nervous system, not elsewhere classified
    UNION ALL
    SELECT 'Y95', 1.2 -- Nosocomial condition 
    UNION ALL
    SELECT 'S09', 1.2 -- Other and unspecified injuries of head 
    UNION ALL
    SELECT 'R45', 1.2 -- Symptoms and signs involving emotional state
    UNION ALL
    SELECT 'G45', 1.2 -- Transient cerebral ischaemic attacks and related syndromes
    UNION ALL
    SELECT 'Z74', 1.1 -- Problems related to care-provider dependency
    UNION ALL
    SELECT 'M79', 1.1 -- Other soft tissue disorders, not elsewhere classified
    UNION ALL
    SELECT 'W06', 1.1 -- Fall involving bed 
    UNION ALL
-- PAGE 4 --
    SELECT 'S01', 1.1 -- Open wound of head
    UNION ALL
    SELECT 'A04', 1.1 -- Other bacterial intestinal infections
    UNION ALL
    SELECT 'A09', 1.1 -- Diarrhoea and gastroenteritis of presumed infectious origin
    UNION ALL
    SELECT 'J18', 1.1 -- Pneumonia, organism unspecified
    UNION ALL
    SELECT 'J69', 1.0 -- Pneumonitis due to solids and liquids
    UNION ALL
    SELECT 'R47', 1.0 -- Speech disturbances, not elsewhere classified
    UNION ALL
    SELECT 'E55', 1.0 -- Vitamin D deficiency
    UNION ALL
    SELECT 'Z93', 1.0 -- Artificial opening status 
    UNION ALL
    SELECT 'R02', 1.0 -- Gangrene, not elsewhere classified 
    UNION ALL
    SELECT 'R63', 0.9 -- Symptoms and signs concerning food and fluid intake
    UNION ALL
    SELECT 'H91', 0.9 -- Other hearing loss
    UNION ALL
    SELECT 'W10', 0.9 -- Fall on and from stairs and steps 
    UNION ALL
    SELECT 'W01', 0.9 -- Fall on same level from slipping, tripping and stumbling
    UNION ALL
    SELECT 'E05', 0.9 -- Thyrotoxicosis [hyperthyroidism]
    UNION ALL
    SELECT 'M41', 0.9 -- Scoliosis
    UNION ALL
    SELECT 'R13', 0.8 -- Dysphagia 
    UNION ALL
    SELECT 'Z99', 0.8 -- Dependence on enabling machines and devices
    UNION ALL
    SELECT 'U80', 0.8 -- Agent resistant to penicillin and related antibiotics
    UNION ALL
    SELECT 'M80', 0.8 -- Osteoporosis with pathological fracture
    UNION ALL
    SELECT 'K92', 0.8 -- Other diseases of digestive system 
    UNION ALL
    SELECT 'I63', 0.8 -- Cerebral Infarction 
    UNION ALL
    SELECT 'N20', 0.7 -- Calculus of kidney and ureter
    UNION ALL
    SELECT 'F10', 0.7 -- Mental and behavioural disorders due to use of alcohol
    UNION ALL
    SELECT 'Y84', 0.7 -- Other medical procedures as the cause of abnormal reaction of the patient
    UNION ALL
    SELECT 'R00', 0.7 -- Abnormalities of heart beat
    UNION ALL
-- PAGE 5 --
    SELECT 'J22', 0.7 -- Unspecified acute lower respiratory infection
    UNION ALL
    SELECT 'Z73', 0.6 -- Problems related to life-management difficulty
    UNION ALL
    SELECT 'R79', 0.6 -- Other abnormal findings of blood chemistry
    UNION ALL
    SELECT 'Z91', 0.5 -- Personal history of risk-factors, not elsewhere classified
    UNION ALL
    SELECT 'S51', 0.5 -- Open wound of forearm
    UNION ALL
    SELECT 'F32', 0.5 -- Depressive episode
    UNION ALL
    SELECT 'M48', 0.5 -- Spinal stenosis (secondary code only)
    UNION ALL
    SELECT 'E83', 0.4 -- Disorders of mineral metabolism 
    UNION ALL
    SELECT 'M15', 0.4 -- Polyarthrosis
    UNION ALL
    SELECT 'D64', 0.4 -- Other anaemias 
    UNION ALL
    SELECT 'L08', 0.4 -- Other local infections of skin and subcutaneous tissue
    UNION ALL
    SELECT 'R11', 0.3 -- Nausea and vomiting 
    UNION ALL
    SELECT 'K52', 0.3 -- Other noninfective gastroenteritis and colitis
    UNION ALL
    SELECT 'R50', 0.1 -- Fever of unknown origin
)
SELECT * FROM frailty_scores;