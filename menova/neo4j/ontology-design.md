# MenoWise Knowledge Graph — Ontology Design

## Overview

The MenoWise knowledge graph models the menopause domain as a structured network of entities and relationships. It is designed to answer questions that require relational reasoning — drug interactions, contraindications, treatment alternatives, and risk assessment — that vector-based text search cannot address.

## Entity Types (Nodes)

### Condition (12 nodes)
Represents medical conditions and menopause stages.
- **Properties:** name, category, description
- **Examples:** perimenopause, menopause, postmenopause, osteoporosis, breast_cancer, hypothyroidism

### Symptom (16 nodes)
Represents symptoms experienced during menopause transition.
- **Properties:** name, category, severity, description
- **Categories:** vasomotor, psychological, cognitive, musculoskeletal, genitourinary, cardiovascular, metabolic, dermatological, sleep
- **Examples:** hot_flashes, brain_fog, joint_pain, vaginal_dryness, heart_palpitations

### Treatment (21 nodes)
Represents medications, therapies, and supplements used in menopause management.
- **Properties:** name, type, route, typical_dose, description
- **Types:** hormonal, hormonal_local, ssri, snri, anticonvulsant, nk3_antagonist, antihypertensive, therapy, supplement, otc, serm
- **Examples:** estradiol, venlafaxine, paroxetine, gabapentin, fezolinetant, cbt_menopause, black_cohosh

### RiskFactor (10 nodes)
Represents factors that modify treatment safety and recommendations.
- **Properties:** name, category, severity, description
- **Examples:** family_history_breast_cancer, personal_history_blood_clots, factor_v_leiden, age_over_60

## Relationship Types (Edges)

### ASSOCIATED_WITH (Symptom → Condition)
Links symptoms to the conditions they commonly indicate.
- **Property:** strength (strong, moderate, mild)
- **Example:** hot_flashes -[ASSOCIATED_WITH {strength: 'strong'}]→ perimenopause

### ALSO_INDICATES (Symptom → Condition)
Critical safety relationship. Links symptoms to non-menopause conditions that present similarly.
- **Property:** note (differential diagnosis guidance)
- **Example:** brain_fog -[ALSO_INDICATES {note: 'Thyroid disorders mimic menopause cognitive symptoms'}]→ hypothyroidism

### TREATS (Treatment → Symptom)
Links treatments to the symptoms they address.
- **Properties:** evidence (strong, moderate, weak), effectiveness (high, moderate, low), note
- **Example:** venlafaxine -[TREATS {evidence: 'strong', effectiveness: 'moderate', note: '40-60% reduction'}]→ hot_flashes

### CONTRAINDICATED_BY (Treatment → RiskFactor)
Critical safety relationship. Links treatments to risk factors that make them unsafe.
- **Properties:** severity (absolute, absolute_for_oral, relative), recommendation
- **Example:** estradiol -[CONTRAINDICATED_BY {severity: 'relative', recommendation: 'Requires specialist consultation'}]→ family_history_breast_cancer

### INTERACTS_WITH (Treatment → Treatment)
Drug interaction relationship.
- **Properties:** severity (severe, moderate, low), mechanism, recommendation
- **Example:** paroxetine -[INTERACTS_WITH {severity: 'severe', mechanism: 'CYP2D6 inhibition', recommendation: 'DO NOT combine'}]→ tamoxifen

### ALTERNATIVE_TO (Treatment → Treatment)
Links safer alternatives when primary treatments are contraindicated.
- **Property:** context (when this alternative applies)
- **Example:** venlafaxine -[ALTERNATIVE_TO {context: 'When HRT is contraindicated due to breast cancer risk'}]→ estradiol

### INCREASES_RISK_OF (Condition → Condition)
Links conditions to downstream health risks.
- **Property:** mechanism
- **Example:** menopause -[INCREASES_RISK_OF {mechanism: 'Estrogen decline accelerates bone loss'}]→ osteoporosis

## Design Decisions

### Why these entity types?
The four entity types (Condition, Symptom, Treatment, RiskFactor) were chosen because they map directly to the questions menopause patients actually ask:
- "What's causing my symptoms?" → Symptom → Condition
- "What can I take for this?" → Treatment → Symptom
- "Is this safe for me?" → Treatment → RiskFactor
- "What are the alternatives?" → Treatment → Treatment

### Why ALSO_INDICATES matters
This relationship type is the safety differentiator. Hot flashes are usually menopause — but heart palpitations could be cardiac. Brain fog could be thyroid. Weight gain could be metabolic. The ALSO_INDICATES edges ensure the system flags when symptoms might indicate something other than menopause, preventing dangerous assumptions.

### What we chose NOT to model
- Dosage protocols (too individualized, requires prescriber)
- Patient history (privacy concerns, requires EHR integration)
- Insurance/cost data (changes frequently, region-specific)
- Specific brand names beyond common ones (too many to maintain)

These were deliberate PM scoping decisions to keep the ontology maintainable while covering the questions that matter most.
