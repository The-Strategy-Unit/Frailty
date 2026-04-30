WITH frailty_scores AS (
	SELECT * FROM (VALUES
-- PAGE 1 --



('F00', 7.1), -- Dementia in Alzheimer's disease
('G81', 4.4), -- Hemiplegia
('G30', 4.0), -- Alzheimer's disease
('I69', 3.7), -- Sequelae of cerebrovascular disease (secondary codes)
('R29', 3.6), -- Other symptoms and signs involving the nervous and musculoskeletal systems (R29·6 Tendency to fall)
('N39', 3.2), -- Other disorders of urinary system
('F05', 3.2), -- Delirium, not induced by alcohol and other psychoactive substances
('W19', 3.2), -- Unspecified fall
('S00', 3.2), -- Superficial injury of head
('R31', 3.0), -- Unspecified haematuria
('B96', 2.9), -- Other bacterial agents as the cause of diseases classified to other chapters (secondary code)
('R41', 2.7), -- Other symptoms and signs involving cognitive functions and awareness
('R26', 2.6), -- Abnormalities of gait and mobility
('I67', 2.6), -- Other cerebrovascular diseases 
('R56', 2.6), -- Convulsions, not elsewhere classified
('R40', 2.5), -- Somnolence, stupor and coma 
('T83', 2.4), -- Complications of genitourinary prosthetic devices, implants and grafts
('S06', 2.4), -- Intracranial injury 
-- PAGE 2 --
('S42', 2.3), -- Fracture of shoulder and upper arm 
('E87', 2.3), -- Other disorders of fluid, electrolyte and acidbase balance
('M25', 2.3), -- Other joint disorders, not elsewhere classified 
('E86', 2.3), -- Volume depletion 
('R54', 2.2), -- Senility 
('Z50', 2.1), -- Care involving use of rehabilitation procedures
('F03', 2.1), -- Unspecified dementia 
('W18', 2.1), -- Other fall on same level 
('Z75', 2.0), -- Problems related to medical facilities and other health care
('F01', 2.0), -- Vascular dementia
('S80', 2.0), -- Superficial injury of lower leg
('L03', 2.0), -- Cellulitis 
('H54', 1.9), -- Blindness and low vision
('E53', 1.9), -- Deficiency of other B group vitamins 
('Z60', 1.8), -- Problems related to social environment 
('G20', 1.8), -- Parkinson's disease
('R55', 1.8), -- Syncope and collapse
('S22', 1.8), -- Fracture of rib(s), sternum and thoracic spine
('K59', 1.8), -- Other functional intestinal disorders 
('N17', 1.8), -- Acute renal failure
('L89', 1.7), -- Decubitus ulcer
('Z22', 1.7), -- Carrier of infectious disease 
('B95', 1.7), -- Streptococcus and staphylococcus as the cause of diseases classified to other chapters
('L97', 1.6), -- Ulcer of lower limb, not elsewhere classified
('R44', 1.6), -- Other symptoms and signs involving general sensations and perceptions
('K26', 1.6), -- Duodenal ulcer
('I95', 1.6), -- Hypotension 
-- PAGE 3 --
('N19', 1.6), -- Unspecified renal failure
('A41', 1.6), -- Other septicaemia
('Z87', 1.5), -- Personal history of other diseases and conditions
('J96', 1.5), -- Respiratory failure, not elsewhere classified 
('X59', 1.5), -- Exposure to unspecified factor
('M19', 1.5), -- Other arthrosis 
('G40', 1.5), -- Epilepsy
('M81', 1.4), -- Osteoporosis without pathological fracture
('S72', 1.4), -- Fracture of femur
('S32', 1.4), -- Fracture of lumbar spine and pelvis
('E16', 1.4), -- Other disorders of pancreatic internal secretion
('R94', 1.4), -- Abnormal results of function studies
('N18', 1.4), -- Chronic renal failure 
('R33', 1.3), -- Retention of urine 
('R69', 1.3), -- Unknown and unspecified causes of morbidity
('N28', 1.3), -- Other disorders of kidney and ureter, not elsewhere classified
('R32', 1.2), -- Unspecified urinary incontinence
('G31', 1.2), -- Other degenerative diseases of nervous system, not elsewhere classified
('Y95', 1.2), -- Nosocomial condition 
('S09', 1.2), -- Other and unspecified injuries of head 
('R45', 1.2), -- Symptoms and signs involving emotional state
('G45', 1.2), -- Transient cerebral ischaemic attacks and related syndromes
('Z74', 1.1), -- Problems related to care-provider dependency
('M79', 1.1), -- Other soft tissue disorders, not elsewhere classified
('W06', 1.1), -- Fall involving bed 
-- PAGE 4 --
('S01', 1.1), -- Open wound of head
('A04', 1.1), -- Other bacterial intestinal infections
('A09', 1.1), -- Diarrhoea and gastroenteritis of presumed infectious origin
('J18', 1.1), -- Pneumonia, organism unspecified
('J69', 1.0), -- Pneumonitis due to solids and liquids
('R47', 1.0), -- Speech disturbances, not elsewhere classified
('E55', 1.0), -- Vitamin D deficiency
('Z93', 1.0), -- Artificial opening status 
('R02', 1.0), -- Gangrene, not elsewhere classified 
('R63', 0.9), -- Symptoms and signs concerning food and fluid intake
('H91', 0.9), -- Other hearing loss
('W10', 0.9), -- Fall on and from stairs and steps 
('W01', 0.9), -- Fall on same level from slipping, tripping and stumbling
('E05', 0.9), -- Thyrotoxicosis [hyperthyroidism]
('M41', 0.9), -- Scoliosis
('R13', 0.8), -- Dysphagia 
('Z99', 0.8), -- Dependence on enabling machines and devices
('U80', 0.8), -- Agent resistant to penicillin and related antibiotics
('M80', 0.8), -- Osteoporosis with pathological fracture
('K92', 0.8), -- Other diseases of digestive system 
('I63', 0.8), -- Cerebral Infarction 
('N20', 0.7), -- Calculus of kidney and ureter
('F10', 0.7), -- Mental and behavioural disorders due to use of alcohol
('Y84', 0.7), -- Other medical procedures as the cause of abnormal reaction of the patient
('R00', 0.7), -- Abnormalities of heart beat
-- PAGE 5 --
('J22', 0.7), -- Unspecified acute lower respiratory infection
('Z73', 0.6), -- Problems related to life-management difficulty
('R79', 0.6), -- Other abnormal findings of blood chemistry
('Z91', 0.5), -- Personal history of risk-factors, not elsewhere classified
('S51', 0.5), -- Open wound of forearm
('F32', 0.5), -- Depressive episode
('M48', 0.5), -- Spinal stenosis (secondary code only)
('E83', 0.4), -- Disorders of mineral metabolism 
('M15', 0.4), -- Polyarthrosis
('D64', 0.4), -- Other anaemias 
('L08', 0.4), -- Other local infections of skin and subcutaneous tissue
('R11', 0.3), -- Nausea and vomiting 
('K52', 0.3), -- Other noninfective gastroenteritis and colitis
('R50', 0.1)  -- Fever of unknown origin
) AS frailty_icd_score(icd_code, score)
)
SELECT * FROM frailty_scores;