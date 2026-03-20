# Menova — Tier Comparison Analysis

## Summary

Testing across 35 queries in 4 risk categories demonstrates that each RAG tier solves failure modes the previous tier cannot. The tier progression is justified by evidence, not complexity preference.

## Key Findings

### Finding 1: Simple RAG fails on conversational queries (vocabulary mismatch)

**Test:** "I'm 47 and having hot flashes, brain fog and anxiety — is this normal?"

- **Simple RAG response:** "I don't have enough information to answer that accurately."
- **Agentic RAG response:** "At 47, experiencing hot flashes, brain fog, and anxiety can be common. These are listed as common symptoms of menopause, including vasomotor symptoms like hot flashes, brain fog and difficulty concentrating, and mood changes like anxiety. Perimenopause typically begins in a woman's 40s..."

**Root cause:** The user's conversational language ("brain fog," "is this normal") has insufficient semantic similarity to the clinical document language ("cognitive changes associated with menopause," "common symptoms include vasomotor symptoms"). The embedding distance is too large for accurate retrieval.

**Resolution:** Agentic RAG's query rewriter transforms the conversational input into clinical terminology before retrieval, dramatically improving semantic match quality.

### Finding 2: Agentic RAG gives incomplete answers for multi-constraint safety queries

**Test:** "My mother had breast cancer and I'm on blood pressure medication — what are my safest options for managing hot flashes?"

- **Agentic RAG response:** "HRT might not be suitable for you, as it is generally contraindicated in women with a history of breast cancer. For personalized medical advice, please consult with your healthcare provider." (3 lines, no alternatives listed)
- **Graph RAG response:** Detailed answer covering breast cancer contraindication for both estradiol and conjugated estrogens, 4 specific safe alternatives (venlafaxine, gabapentin, fezolinetant, CBT) with effectiveness data, tamoxifen interaction considerations, blood pressure medication acknowledgment, and specialist referral. (Full structured response)

**Root cause:** Agentic RAG correctly retrieved the contraindication information but could not simultaneously traverse: (1) breast cancer → HRT contraindication, (2) blood pressure medication → interaction considerations, (3) contraindicated treatments → safe alternatives with effectiveness data. This requires traversing multiple relationship paths in a knowledge graph.

**Resolution:** Graph RAG's structured knowledge representation enables multi-hop relational reasoning across contraindications, interactions, and alternatives in a single query.

### Finding 3: Safety checker catches clinically relevant omissions

**Test:** Same symptom query ("I'm 47, hot flashes, brain fog, anxiety")

- **Agentic RAG synthesizer output:** Response describing these as common menopause symptoms
- **Safety checker verdict:** UNSAFE — "The response misses explicitly mentioning that the user's symptoms could indicate conditions other than menopause."
- **Safety checker modified response:** Added that "these symptoms can also be indicative of other health conditions" and recommended "a proper diagnosis and personalized medical" evaluation.

**Significance:** The original response was factually correct but clinically incomplete. Hot flashes + brain fog + anxiety could also indicate thyroid disorders. The safety checker caught this differential diagnosis gap — a real clinical concern that demonstrates the value of the safety layer.

### Finding 4: Confidence router correctly triages query risk

Three test queries were classified with 100% accuracy:

| Query | Expected | Actual | Correct? |
|-------|----------|--------|----------|
| "What is perimenopause?" | LOW | LOW | ✅ |
| "I'm 47 and having hot flashes, brain fog and anxiety" | MEDIUM | MEDIUM | ✅ |
| "I'm on sertraline — can I also take HRT?" | HIGH | HIGH | ✅ |

## Failure Mode Classification

| Failure Mode | Count | Example | Resolution |
|---|---|---|---|
| VOCABULARY_MISMATCH | 3 | "brain fog" vs "cognitive changes" | Agentic RAG (query rewriter) |
| RETRIEVAL_MISS | 1 | "triggers hot flashes" not found despite existing in KB | Needs chunking/embedding investigation |
| RELATIONAL_REASONING | 2 | Multi-constraint safety queries | Graph RAG |

## Tier Recommendation Matrix

| Query Type | Recommended Tier | Justification |
|---|---|---|
| Factual/educational | Simple RAG | Fast, cheap, sufficient for well-formed queries |
| Conversational symptom questions | Agentic RAG | Rewriter bridges vocabulary gap |
| Drug interaction checks | Graph RAG | Requires relational traversal |
| Contraindication assessment | Graph RAG | Requires entity-relationship reasoning |
| Treatment alternatives with constraints | Graph RAG | Requires multi-hop traversal |
| Emergency/urgent symptoms | Human fallback | Too high-stakes for AI-only response |
