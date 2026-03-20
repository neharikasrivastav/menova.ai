// ============================================================
// MENOWISE KNOWLEDGE GRAPH - Neo4j Cypher Scripts
// Run these in Neo4j Browser (the Query tab in Aura)
// Run each section one at a time
// ============================================================

// ============================================================
// SECTION 1: CREATE CONDITION NODES
// Copy and paste this entire block, then click Run
// ============================================================

CREATE (c1:Condition {name: 'perimenopause', category: 'menopause_stage', description: 'Transition period before menopause, typically starting in mid-40s, lasting 4-8 years'})
CREATE (c2:Condition {name: 'menopause', category: 'menopause_stage', description: 'Diagnosed after 12 consecutive months without a period, average age 51'})
CREATE (c3:Condition {name: 'postmenopause', category: 'menopause_stage', description: 'Years after menopause, increased risk of osteoporosis and cardiovascular disease'})
CREATE (c4:Condition {name: 'osteoporosis', category: 'bone', description: 'Loss of bone density, women can lose up to 20% in 5-7 years post menopause'})
CREATE (c5:Condition {name: 'cardiovascular_disease', category: 'cardiovascular', description: 'Leading cause of death in postmenopausal women'})
CREATE (c6:Condition {name: 'breast_cancer', category: 'cancer', description: 'Estrogen-sensitive cancer, key contraindication for systemic HRT'})
CREATE (c7:Condition {name: 'hypothyroidism', category: 'endocrine', description: 'Can mimic menopause symptoms including fatigue, mood changes, weight changes'})
CREATE (c8:Condition {name: 'anxiety_disorder', category: 'mental_health', description: 'Clinical anxiety that may overlap with perimenopause mood changes'})
CREATE (c9:Condition {name: 'depression', category: 'mental_health', description: '2-4x greater risk during perimenopause compared to premenopausal years'})
CREATE (c10:Condition {name: 'venous_thromboembolism', category: 'cardiovascular', description: 'Blood clots including DVT and pulmonary embolism'})
CREATE (c11:Condition {name: 'genitourinary_syndrome', category: 'genitourinary', description: 'Vaginal dryness, urinary issues, worsens over time without treatment'})
CREATE (c12:Condition {name: 'metabolic_syndrome', category: 'metabolic', description: 'Cluster of conditions increasing heart disease, stroke, and diabetes risk'});

// ============================================================
// SECTION 2: CREATE SYMPTOM NODES
// ============================================================

CREATE (s1:Symptom {name: 'hot_flashes', category: 'vasomotor', severity: 'moderate_to_severe', description: 'Sudden intense warmth in upper body, lasting 30 seconds to 10 minutes'})
CREATE (s2:Symptom {name: 'night_sweats', category: 'vasomotor', severity: 'moderate_to_severe', description: 'Hot flashes during sleep causing sleep disruption'})
CREATE (s3:Symptom {name: 'insomnia', category: 'sleep', severity: 'moderate', description: 'Difficulty falling or staying asleep, affects 40-60% of menopausal women'})
CREATE (s4:Symptom {name: 'anxiety', category: 'psychological', severity: 'mild_to_severe', description: 'Generalized worry, panic attacks, persistent unease'})
CREATE (s5:Symptom {name: 'depression_symptoms', category: 'psychological', severity: 'mild_to_severe', description: 'Persistent sadness, hopelessness, loss of interest'})
CREATE (s6:Symptom {name: 'brain_fog', category: 'cognitive', severity: 'mild_to_moderate', description: 'Difficulty concentrating, memory lapses, reduced mental clarity'})
CREATE (s7:Symptom {name: 'mood_swings', category: 'psychological', severity: 'mild_to_moderate', description: 'Rapid changes in mood, irritability'})
CREATE (s8:Symptom {name: 'joint_pain', category: 'musculoskeletal', severity: 'mild_to_moderate', description: 'Stiffness especially in morning, pain in hands, knees, hips'})
CREATE (s9:Symptom {name: 'weight_gain', category: 'metabolic', severity: 'mild_to_moderate', description: 'Especially around the midsection due to metabolic changes'})
CREATE (s10:Symptom {name: 'vaginal_dryness', category: 'genitourinary', severity: 'mild_to_severe', description: 'Thinning of vaginal tissues due to estrogen decline'})
CREATE (s11:Symptom {name: 'heart_palpitations', category: 'cardiovascular', severity: 'mild_to_moderate', description: 'Usually benign, caused by hormonal fluctuations'})
CREATE (s12:Symptom {name: 'painful_intercourse', category: 'genitourinary', severity: 'moderate', description: 'Dyspareunia due to vaginal dryness and tissue thinning'})
CREATE (s13:Symptom {name: 'urinary_issues', category: 'genitourinary', severity: 'mild_to_moderate', description: 'Urgency, frequency, recurrent UTIs'})
CREATE (s14:Symptom {name: 'bone_density_loss', category: 'musculoskeletal', severity: 'severe', description: 'Progressive loss of bone density increasing fracture risk'})
CREATE (s15:Symptom {name: 'hair_thinning', category: 'dermatological', severity: 'mild', description: 'Changes in hair thickness and texture'})
CREATE (s16:Symptom {name: 'skin_dryness', category: 'dermatological', severity: 'mild', description: 'Decreased skin elasticity and moisture'});

// ============================================================
// SECTION 3: CREATE TREATMENT NODES
// ============================================================

CREATE (t1:Treatment {name: 'estradiol', type: 'hormonal', route: 'oral_or_transdermal', description: 'Most common form of estrogen replacement'})
CREATE (t2:Treatment {name: 'progesterone', type: 'hormonal', route: 'oral', description: 'Combined with estrogen for women with intact uterus'})
CREATE (t3:Treatment {name: 'conjugated_estrogens', type: 'hormonal', route: 'oral', description: 'Premarin, derived estrogen formulation'})
CREATE (t4:Treatment {name: 'transdermal_estrogen', type: 'hormonal', route: 'patch_gel_spray', description: 'Preferred for women with clotting risk, bypasses liver'})
CREATE (t5:Treatment {name: 'vaginal_estrogen', type: 'hormonal_local', route: 'vaginal', description: 'Low-dose cream, ring, or tablet for local genitourinary symptoms'})
CREATE (t6:Treatment {name: 'venlafaxine', type: 'snri', route: 'oral', typical_dose: '37.5-75mg daily', description: 'Strongest evidence for hot flash reduction, 40-60% reduction'})
CREATE (t7:Treatment {name: 'paroxetine', type: 'ssri', route: 'oral', typical_dose: '7.5mg daily', description: 'Only FDA-approved SSRI for vasomotor symptoms (Brisdelle)'})
CREATE (t8:Treatment {name: 'escitalopram', type: 'ssri', route: 'oral', typical_dose: '10-20mg daily', description: 'Shown benefit in clinical trials for hot flashes'})
CREATE (t9:Treatment {name: 'sertraline', type: 'ssri', route: 'oral', typical_dose: '50-200mg daily', description: 'Commonly prescribed for depression and anxiety in menopause, modest hot flash benefit'})
CREATE (t10:Treatment {name: 'gabapentin', type: 'anticonvulsant', route: 'oral', typical_dose: '300-900mg daily', description: 'Reduces hot flashes 30-50%, sedating effect helps sleep'})
CREATE (t11:Treatment {name: 'fezolinetant', type: 'nk3_antagonist', route: 'oral', description: 'Veozah, FDA approved 2023, targets thermoregulatory center directly'})
CREATE (t12:Treatment {name: 'clonidine', type: 'antihypertensive', route: 'oral', typical_dose: '0.1mg daily', description: 'Modest effectiveness for hot flashes, limited by side effects'})
CREATE (t13:Treatment {name: 'cbt_menopause', type: 'therapy', route: 'non_pharmacological', description: 'Reduces impact of hot flashes by ~50%, NICE recommended'})
CREATE (t14:Treatment {name: 'black_cohosh', type: 'supplement', route: 'oral', description: 'Popular supplement, mixed evidence, rare liver toxicity reports'})
CREATE (t15:Treatment {name: 'evening_primrose_oil', type: 'supplement', route: 'oral', description: 'Used for hot flashes, limited evidence'})
CREATE (t16:Treatment {name: 'soy_isoflavones', type: 'supplement', route: 'oral', description: 'Phytoestrogens, may modestly reduce hot flash frequency'})
CREATE (t17:Treatment {name: 'st_johns_wort', type: 'supplement', route: 'oral', description: 'Used for mood, DANGEROUS drug interactions with many medications'})
CREATE (t18:Treatment {name: 'vitamin_d_calcium', type: 'supplement', route: 'oral', description: '1200mg calcium + 800-1000 IU vitamin D daily for bone health'})
CREATE (t19:Treatment {name: 'vaginal_moisturizers', type: 'otc', route: 'vaginal', description: 'Regular use for ongoing comfort, non-hormonal'})
CREATE (t20:Treatment {name: 'ospemifene', type: 'serm', route: 'oral', description: 'Non-estrogen oral medication for painful intercourse'})
CREATE (t21:Treatment {name: 'tamoxifen', type: 'serm', route: 'oral', description: 'Breast cancer prevention/treatment, important drug interactions with some SSRIs'});

// ============================================================
// SECTION 4: CREATE RISK FACTOR NODES
// ============================================================

CREATE (r1:RiskFactor {name: 'family_history_breast_cancer', category: 'genetic', severity: 'high', description: 'First-degree relative with breast cancer'})
CREATE (r2:RiskFactor {name: 'personal_history_blood_clots', category: 'cardiovascular', severity: 'high', description: 'History of DVT, PE, or clotting disorder'})
CREATE (r3:RiskFactor {name: 'active_liver_disease', category: 'hepatic', severity: 'high', description: 'Current liver disease or dysfunction'})
CREATE (r4:RiskFactor {name: 'smoking', category: 'lifestyle', severity: 'moderate', description: 'Increases cardiovascular and clotting risk'})
CREATE (r5:RiskFactor {name: 'age_over_60', category: 'demographic', severity: 'moderate', description: 'HRT initiation after 60 or 10+ years post menopause carries higher risk'})
CREATE (r6:RiskFactor {name: 'hypertension', category: 'cardiovascular', severity: 'moderate', description: 'High blood pressure, requires monitoring with HRT'})
CREATE (r7:RiskFactor {name: 'obesity', category: 'metabolic', severity: 'moderate', description: 'Increases risk of breast cancer and cardiovascular disease'})
CREATE (r8:RiskFactor {name: 'factor_v_leiden', category: 'genetic', severity: 'high', description: 'Genetic clotting disorder, absolute contraindication for oral HRT'})
CREATE (r9:RiskFactor {name: 'migraine_with_aura', category: 'neurological', severity: 'moderate', description: 'Relative contraindication for HRT, requires specialist consultation'})
CREATE (r10:RiskFactor {name: 'undiagnosed_vaginal_bleeding', category: 'gynecological', severity: 'high', description: 'Must be investigated before starting HRT'});

// ============================================================
// SECTION 5: SYMPTOM - CONDITION RELATIONSHIPS
// ============================================================

MATCH (s:Symptom {name: 'hot_flashes'}), (c:Condition {name: 'perimenopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'strong'}]->(c);
MATCH (s:Symptom {name: 'hot_flashes'}), (c:Condition {name: 'menopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'strong'}]->(c);
MATCH (s:Symptom {name: 'night_sweats'}), (c:Condition {name: 'perimenopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'strong'}]->(c);
MATCH (s:Symptom {name: 'night_sweats'}), (c:Condition {name: 'menopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'strong'}]->(c);
MATCH (s:Symptom {name: 'anxiety'}), (c:Condition {name: 'perimenopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'moderate'}]->(c);
MATCH (s:Symptom {name: 'anxiety'}), (c:Condition {name: 'anxiety_disorder'}) CREATE (s)-[:ALSO_INDICATES {note: 'Must differentiate from clinical anxiety'}]->(c);
MATCH (s:Symptom {name: 'depression_symptoms'}), (c:Condition {name: 'perimenopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'moderate'}]->(c);
MATCH (s:Symptom {name: 'depression_symptoms'}), (c:Condition {name: 'depression'}) CREATE (s)-[:ALSO_INDICATES {note: 'Must differentiate from clinical depression'}]->(c);
MATCH (s:Symptom {name: 'brain_fog'}), (c:Condition {name: 'perimenopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'moderate'}]->(c);
MATCH (s:Symptom {name: 'brain_fog'}), (c:Condition {name: 'hypothyroidism'}) CREATE (s)-[:ALSO_INDICATES {note: 'Thyroid disorders mimic menopause cognitive symptoms'}]->(c);
MATCH (s:Symptom {name: 'mood_swings'}), (c:Condition {name: 'perimenopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'strong'}]->(c);
MATCH (s:Symptom {name: 'joint_pain'}), (c:Condition {name: 'menopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'moderate'}]->(c);
MATCH (s:Symptom {name: 'weight_gain'}), (c:Condition {name: 'menopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'moderate'}]->(c);
MATCH (s:Symptom {name: 'weight_gain'}), (c:Condition {name: 'hypothyroidism'}) CREATE (s)-[:ALSO_INDICATES {note: 'Thyroid disorders cause similar weight changes'}]->(c);
MATCH (s:Symptom {name: 'vaginal_dryness'}), (c:Condition {name: 'genitourinary_syndrome'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'strong'}]->(c);
MATCH (s:Symptom {name: 'heart_palpitations'}), (c:Condition {name: 'perimenopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'mild'}]->(c);
MATCH (s:Symptom {name: 'heart_palpitations'}), (c:Condition {name: 'cardiovascular_disease'}) CREATE (s)-[:ALSO_INDICATES {note: 'Must rule out cardiac causes'}]->(c);
MATCH (s:Symptom {name: 'heart_palpitations'}), (c:Condition {name: 'hypothyroidism'}) CREATE (s)-[:ALSO_INDICATES {note: 'Thyroid disorders can cause palpitations'}]->(c);
MATCH (s:Symptom {name: 'bone_density_loss'}), (c:Condition {name: 'osteoporosis'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'strong'}]->(c);
MATCH (s:Symptom {name: 'bone_density_loss'}), (c:Condition {name: 'postmenopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'strong'}]->(c);
MATCH (s:Symptom {name: 'insomnia'}), (c:Condition {name: 'perimenopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'strong'}]->(c);
MATCH (s:Symptom {name: 'insomnia'}), (c:Condition {name: 'menopause'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'strong'}]->(c);
MATCH (s:Symptom {name: 'painful_intercourse'}), (c:Condition {name: 'genitourinary_syndrome'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'strong'}]->(c);
MATCH (s:Symptom {name: 'urinary_issues'}), (c:Condition {name: 'genitourinary_syndrome'}) CREATE (s)-[:ASSOCIATED_WITH {strength: 'strong'}]->(c);

// ============================================================
// SECTION 6: TREATMENT - SYMPTOM RELATIONSHIPS (TREATS)
// ============================================================

MATCH (t:Treatment {name: 'estradiol'}), (s:Symptom {name: 'hot_flashes'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high'}]->(s);
MATCH (t:Treatment {name: 'estradiol'}), (s:Symptom {name: 'night_sweats'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high'}]->(s);
MATCH (t:Treatment {name: 'estradiol'}), (s:Symptom {name: 'insomnia'}) CREATE (t)-[:TREATS {evidence: 'moderate', effectiveness: 'moderate'}]->(s);
MATCH (t:Treatment {name: 'estradiol'}), (s:Symptom {name: 'mood_swings'}) CREATE (t)-[:TREATS {evidence: 'moderate', effectiveness: 'moderate'}]->(s);
MATCH (t:Treatment {name: 'estradiol'}), (s:Symptom {name: 'bone_density_loss'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high'}]->(s);
MATCH (t:Treatment {name: 'transdermal_estrogen'}), (s:Symptom {name: 'hot_flashes'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high', note: 'Preferred for women with clotting risk'}]->(s);
MATCH (t:Treatment {name: 'vaginal_estrogen'}), (s:Symptom {name: 'vaginal_dryness'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high', note: 'Minimal systemic absorption'}]->(s);
MATCH (t:Treatment {name: 'vaginal_estrogen'}), (s:Symptom {name: 'painful_intercourse'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high'}]->(s);
MATCH (t:Treatment {name: 'vaginal_estrogen'}), (s:Symptom {name: 'urinary_issues'}) CREATE (t)-[:TREATS {evidence: 'moderate', effectiveness: 'moderate'}]->(s);
MATCH (t:Treatment {name: 'venlafaxine'}), (s:Symptom {name: 'hot_flashes'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'moderate', note: '40-60% reduction'}]->(s);
MATCH (t:Treatment {name: 'venlafaxine'}), (s:Symptom {name: 'anxiety'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high'}]->(s);
MATCH (t:Treatment {name: 'venlafaxine'}), (s:Symptom {name: 'depression_symptoms'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high'}]->(s);
MATCH (t:Treatment {name: 'paroxetine'}), (s:Symptom {name: 'hot_flashes'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'moderate', note: 'Only FDA-approved SSRI for VMS'}]->(s);
MATCH (t:Treatment {name: 'paroxetine'}), (s:Symptom {name: 'anxiety'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high'}]->(s);
MATCH (t:Treatment {name: 'escitalopram'}), (s:Symptom {name: 'hot_flashes'}) CREATE (t)-[:TREATS {evidence: 'moderate', effectiveness: 'moderate'}]->(s);
MATCH (t:Treatment {name: 'escitalopram'}), (s:Symptom {name: 'anxiety'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high'}]->(s);
MATCH (t:Treatment {name: 'sertraline'}), (s:Symptom {name: 'anxiety'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high'}]->(s);
MATCH (t:Treatment {name: 'sertraline'}), (s:Symptom {name: 'depression_symptoms'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high'}]->(s);
MATCH (t:Treatment {name: 'sertraline'}), (s:Symptom {name: 'hot_flashes'}) CREATE (t)-[:TREATS {evidence: 'weak', effectiveness: 'low', note: 'Modest benefit, not primary indication'}]->(s);
MATCH (t:Treatment {name: 'gabapentin'}), (s:Symptom {name: 'hot_flashes'}) CREATE (t)-[:TREATS {evidence: 'moderate', effectiveness: 'moderate', note: '30-50% reduction'}]->(s);
MATCH (t:Treatment {name: 'gabapentin'}), (s:Symptom {name: 'insomnia'}) CREATE (t)-[:TREATS {evidence: 'moderate', effectiveness: 'moderate', note: 'Sedating effect beneficial at bedtime'}]->(s);
MATCH (t:Treatment {name: 'fezolinetant'}), (s:Symptom {name: 'hot_flashes'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high', note: 'NK3 antagonist, FDA approved 2023'}]->(s);
MATCH (t:Treatment {name: 'cbt_menopause'}), (s:Symptom {name: 'hot_flashes'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'moderate', note: 'Reduces impact by ~50%'}]->(s);
MATCH (t:Treatment {name: 'cbt_menopause'}), (s:Symptom {name: 'insomnia'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high'}]->(s);
MATCH (t:Treatment {name: 'cbt_menopause'}), (s:Symptom {name: 'anxiety'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'high'}]->(s);
MATCH (t:Treatment {name: 'vaginal_moisturizers'}), (s:Symptom {name: 'vaginal_dryness'}) CREATE (t)-[:TREATS {evidence: 'moderate', effectiveness: 'mild'}]->(s);
MATCH (t:Treatment {name: 'ospemifene'}), (s:Symptom {name: 'painful_intercourse'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'moderate'}]->(s);
MATCH (t:Treatment {name: 'vitamin_d_calcium'}), (s:Symptom {name: 'bone_density_loss'}) CREATE (t)-[:TREATS {evidence: 'strong', effectiveness: 'moderate'}]->(s);
MATCH (t:Treatment {name: 'clonidine'}), (s:Symptom {name: 'hot_flashes'}) CREATE (t)-[:TREATS {evidence: 'weak', effectiveness: 'low', note: 'Limited by side effects'}]->(s);

// ============================================================
// SECTION 7: TREATMENT - RISK FACTOR RELATIONSHIPS (CONTRAINDICATED_BY)
// ============================================================

MATCH (t:Treatment {name: 'estradiol'}), (r:RiskFactor {name: 'family_history_breast_cancer'}) CREATE (t)-[:CONTRAINDICATED_BY {severity: 'relative', recommendation: 'Requires specialist consultation, consider non-hormonal alternatives'}]->(r);
MATCH (t:Treatment {name: 'estradiol'}), (r:RiskFactor {name: 'personal_history_blood_clots'}) CREATE (t)-[:CONTRAINDICATED_BY {severity: 'absolute_for_oral', recommendation: 'Oral estrogen contraindicated. Transdermal may be considered with specialist guidance'}]->(r);
MATCH (t:Treatment {name: 'estradiol'}), (r:RiskFactor {name: 'active_liver_disease'}) CREATE (t)-[:CONTRAINDICATED_BY {severity: 'absolute', recommendation: 'Do not use oral estrogen'}]->(r);
MATCH (t:Treatment {name: 'estradiol'}), (r:RiskFactor {name: 'age_over_60'}) CREATE (t)-[:CONTRAINDICATED_BY {severity: 'relative', recommendation: 'Initiation not recommended after age 60 or 10+ years post menopause'}]->(r);
MATCH (t:Treatment {name: 'estradiol'}), (r:RiskFactor {name: 'undiagnosed_vaginal_bleeding'}) CREATE (t)-[:CONTRAINDICATED_BY {severity: 'absolute', recommendation: 'Must investigate bleeding before starting HRT'}]->(r);
MATCH (t:Treatment {name: 'conjugated_estrogens'}), (r:RiskFactor {name: 'family_history_breast_cancer'}) CREATE (t)-[:CONTRAINDICATED_BY {severity: 'relative', recommendation: 'Higher risk than estradiol, consider alternatives'}]->(r);
MATCH (t:Treatment {name: 'conjugated_estrogens'}), (r:RiskFactor {name: 'personal_history_blood_clots'}) CREATE (t)-[:CONTRAINDICATED_BY {severity: 'absolute', recommendation: 'Do not use'}]->(r);
MATCH (t:Treatment {name: 'conjugated_estrogens'}), (r:RiskFactor {name: 'factor_v_leiden'}) CREATE (t)-[:CONTRAINDICATED_BY {severity: 'absolute', recommendation: 'Do not use any oral estrogen'}]->(r);
MATCH (t:Treatment {name: 'black_cohosh'}), (r:RiskFactor {name: 'active_liver_disease'}) CREATE (t)-[:CONTRAINDICATED_BY {severity: 'absolute', recommendation: 'Rare liver toxicity reports, avoid with liver conditions'}]->(r);

// ============================================================
// SECTION 8: TREATMENT - TREATMENT RELATIONSHIPS (INTERACTS_WITH)
// ============================================================

MATCH (t1:Treatment {name: 'paroxetine'}), (t2:Treatment {name: 'tamoxifen'}) CREATE (t1)-[:INTERACTS_WITH {severity: 'severe', mechanism: 'CYP2D6 inhibition reduces tamoxifen effectiveness', recommendation: 'DO NOT combine. Use venlafaxine, escitalopram, or sertraline instead'}]->(t2);
MATCH (t1:Treatment {name: 'sertraline'}), (t2:Treatment {name: 'tamoxifen'}) CREATE (t1)-[:INTERACTS_WITH {severity: 'low', mechanism: 'Minimal CYP2D6 inhibition', recommendation: 'Safe to combine, sertraline is a preferred SSRI with tamoxifen'}]->(t2);
MATCH (t1:Treatment {name: 'sertraline'}), (t2:Treatment {name: 'estradiol'}) CREATE (t1)-[:INTERACTS_WITH {severity: 'low', mechanism: 'No major direct interaction, both affect serotonin pathways', recommendation: 'Safe to combine. Start one first, stabilize, then add the other'}]->(t2);
MATCH (t1:Treatment {name: 'venlafaxine'}), (t2:Treatment {name: 'tamoxifen'}) CREATE (t1)-[:INTERACTS_WITH {severity: 'low', mechanism: 'Minimal CYP2D6 inhibition', recommendation: 'Safe to combine, venlafaxine is a preferred choice with tamoxifen'}]->(t2);
MATCH (t1:Treatment {name: 'st_johns_wort'}), (t2:Treatment {name: 'estradiol'}) CREATE (t1)-[:INTERACTS_WITH {severity: 'severe', mechanism: 'Potent enzyme inducer reduces HRT effectiveness', recommendation: 'DO NOT combine'}]->(t2);
MATCH (t1:Treatment {name: 'st_johns_wort'}), (t2:Treatment {name: 'sertraline'}) CREATE (t1)-[:INTERACTS_WITH {severity: 'severe', mechanism: 'Risk of serotonin syndrome', recommendation: 'DO NOT combine with any SSRI'}]->(t2);
MATCH (t1:Treatment {name: 'gabapentin'}), (t2:Treatment {name: 'venlafaxine'}) CREATE (t1)-[:INTERACTS_WITH {severity: 'moderate', mechanism: 'Both can cause dizziness, combined sedation risk', recommendation: 'Can be used together with caution, monitor for excessive sedation'}]->(t2);

// ============================================================
// SECTION 9: TREATMENT ALTERNATIVES
// ============================================================

MATCH (t1:Treatment {name: 'venlafaxine'}), (t2:Treatment {name: 'estradiol'}) CREATE (t1)-[:ALTERNATIVE_TO {context: 'When HRT is contraindicated due to breast cancer risk or blood clots'}]->(t2);
MATCH (t1:Treatment {name: 'paroxetine'}), (t2:Treatment {name: 'estradiol'}) CREATE (t1)-[:ALTERNATIVE_TO {context: 'When HRT is contraindicated, but NOT for women on tamoxifen'}]->(t2);
MATCH (t1:Treatment {name: 'gabapentin'}), (t2:Treatment {name: 'estradiol'}) CREATE (t1)-[:ALTERNATIVE_TO {context: 'When HRT is contraindicated, especially good for sleep'}]->(t2);
MATCH (t1:Treatment {name: 'fezolinetant'}), (t2:Treatment {name: 'estradiol'}) CREATE (t1)-[:ALTERNATIVE_TO {context: 'When HRT is contraindicated, directly targets thermoregulation'}]->(t2);
MATCH (t1:Treatment {name: 'cbt_menopause'}), (t2:Treatment {name: 'estradiol'}) CREATE (t1)-[:ALTERNATIVE_TO {context: 'Non-pharmacological option, no drug interactions'}]->(t2);
MATCH (t1:Treatment {name: 'transdermal_estrogen'}), (t2:Treatment {name: 'estradiol'}) CREATE (t1)-[:ALTERNATIVE_TO {context: 'When oral estrogen is contraindicated due to clotting risk'}]->(t2);

// ============================================================
// SECTION 10: CONDITION RELATIONSHIPS
// ============================================================

MATCH (c1:Condition {name: 'menopause'}), (c2:Condition {name: 'osteoporosis'}) CREATE (c1)-[:INCREASES_RISK_OF {mechanism: 'Estrogen decline accelerates bone loss'}]->(c2);
MATCH (c1:Condition {name: 'menopause'}), (c2:Condition {name: 'cardiovascular_disease'}) CREATE (c1)-[:INCREASES_RISK_OF {mechanism: 'Loss of estrogen protective effects on blood vessels'}]->(c2);
MATCH (c1:Condition {name: 'menopause'}), (c2:Condition {name: 'genitourinary_syndrome'}) CREATE (c1)-[:INCREASES_RISK_OF {mechanism: 'Estrogen decline causes tissue thinning'}]->(c2);
MATCH (c1:Condition {name: 'menopause'}), (c2:Condition {name: 'metabolic_syndrome'}) CREATE (c1)-[:INCREASES_RISK_OF {mechanism: 'Hormonal changes affect metabolism and fat distribution'}]->(c2);
MATCH (c1:Condition {name: 'perimenopause'}), (c2:Condition {name: 'depression'}) CREATE (c1)-[:INCREASES_RISK_OF {mechanism: '2-4x greater risk due to hormonal fluctuations'}]->(c2);

// ============================================================
// VERIFICATION: Check your graph
// Run this to see a summary of what was created
// ============================================================

// Count all nodes
// MATCH (n) RETURN labels(n)[0] AS type, count(n) AS count ORDER BY count DESC;

// Count all relationships  
// MATCH ()-[r]->() RETURN type(r) AS relationship, count(r) AS count ORDER BY count DESC;

// Visualize the full graph (may be slow if graph is large)
// MATCH (n)-[r]->(m) RETURN n, r, m LIMIT 100;
