# menova.ai — Agentic AI Health Assistant for Menopause

> A 3-tier RAG system with confidence-gated routing and clinical safety guardrails, built as an AI Product Management portfolio project.

## The Problem

Women approaching or going through menopause are drowning in fragmented, contradictory health information. They Google symptoms and get either terrifying worst-case scenarios or dismissive "it's just menopause" responses. When they turn to AI assistants, they get generic, ungrounded answers — or worse, confident hallucinations about treatments and drug interactions.

menova solves this by applying progressively sophisticated RAG (Retrieval Augmented Generation) to menopause health knowledge, giving women grounded, personalized, safety-conscious answers.

## Architecture

Menova uses a **3-tier RAG architecture** where each tier exists because the previous one fails in a specific, predictable way:

```
User Question
      ↓
┌─────────────────┐
│ Confidence      │ ← Classifies query risk: LOW / MEDIUM / HIGH
│ Router          │
└────┬───┬───┬────┘
     │   │   │
     ↓   ↓   ↓
┌────┐ ┌────┐ ┌────┐
│Tier│ │Tier│ │Tier│
│ 1  │ │ 2  │ │ 3  │
│    │ │    │ │    │
│Simple│Agen-│Graph│
│ RAG ││tic ││ RAG │
│    │ │RAG │ │    │
└────┘ └────┘ └────┘
     │   │   │
     ↓   ↓   ↓
┌─────────────────┐
│ Safety Check    │ ← Reviews response before showing to user
│ Layer           │
└─────────────────┘
      ↓
  User Response
```

### Tier 1: Simple RAG — Educational Queries
For straightforward factual questions ("What is perimenopause?"). Embeds the query, retrieves from Pinecone, generates a grounded answer.

**Where it breaks:** Conversational queries with vocabulary mismatch. User says "brain fog" but docs say "cognitive changes associated with menopause." Retrieval fails silently.

### Tier 2: Agentic RAG — Symptom Analysis
Adds a query rewriter that transforms conversational language into medical terminology before retrieval. Decomposes multi-symptom queries into focused sub-queries.

**Where it breaks:** Relational reasoning. "My mother had breast cancer — what are my safest options?" requires traversing contraindications, drug interactions, and alternatives simultaneously.

### Tier 3: Graph RAG — Drug Interactions & Safety
Uses a knowledge graph (Neo4j) modeling symptoms, conditions, treatments, risk factors, and the relationships between them. Traverses contraindication and interaction paths to provide safety-aware, personalized answers.

### Confidence Router
Classifies every incoming query as LOW, MEDIUM, or HIGH risk before routing to the appropriate tier. Ensures simple queries don't pay the latency cost of complex pipelines, and high-risk queries always get the most thorough treatment.

### Safety Check Layer
Reviews every AI-generated response against clinical safety criteria before showing it to the user. Flags responses that recommend starting/stopping medication, make definitive diagnoses, or miss important differential diagnoses.

## Key Results

| Metric | Simple RAG | Agentic RAG | Graph RAG |
|--------|-----------|-------------|-----------|
| Educational queries | ✅ Pass | ✅ Pass | N/A |
| Conversational symptom queries | ❌ Fail | ✅ Pass | N/A |
| Multi-constraint safety queries | ❌ Fail | ⚠️ Partial | ✅ Comprehensive |
| Confidence routing accuracy | 3/3 correct | — | — |
| Safety check | — | Caught unsafe response | — |

### The Tier Progression Story

**Same question, three different answers:**

> "I'm 47 and having hot flashes, brain fog and anxiety — is this normal?"

- **Simple RAG:** "I don't have enough information to answer that accurately." ❌
- **Agentic RAG:** "At 47, experiencing hot flashes, brain fog, and anxiety can be common. These are listed as common symptoms of menopause..." ✅

> "My mother had breast cancer and I'm on blood pressure medication — what are my safest options for hot flashes?"

- **Agentic RAG:** "HRT might not be suitable... consult your healthcare provider." (Safe but thin — 3 lines)
- **Graph RAG:** Detailed answer listing contraindications, 4 specific alternatives with effectiveness data, tamoxifen considerations, and specialist referral recommendation. ✅

## Tech Stack

| Component | Tool | Cost |
|-----------|------|------|
| Workflow orchestration | n8n (self-hosted Docker) | Free |
| LLM & Embeddings | Google Gemini API (free tier) | Free |
| Vector database | Pinecone (free tier) | Free |
| Graph database | Neo4j Aura (free tier) | Free |
| **Total** | | **$0** |

## Knowledge Base

- **20 curated documents** covering clinical guidelines, drug information, symptoms, and lifestyle
- **41 vector chunks** in Pinecone (768-dimension embeddings)
- **59 graph nodes** in Neo4j (Conditions, Symptoms, Treatments, Risk Factors)
- **80 graph relationships** (TREATS, CONTRAINDICATED_BY, INTERACTS_WITH, ALTERNATIVE_TO, ASSOCIATED_WITH, ALSO_INDICATES, INCREASES_RISK_OF)

## Repo Structure

```
menova/
├── README.md                          ← You are here
├── workflows/
│   ├── ingestion-pipeline.json        ← n8n workflow: document ingestion into Pinecone
│   ├── simple-rag-query.json          ← n8n workflow: Tier 1 Simple RAG
│   ├── agentic-rag-query.json         ← n8n workflow: Tier 2 Agentic RAG with rewriter
│   ├── graph-rag-query.json           ← n8n workflow: Tier 3 Graph RAG
│   ├── confidence-router.json         ← n8n workflow: risk classification + routing
│   └── safety-checker.json            ← n8n workflow: post-response safety review
├── knowledge-base/
│   └── menova-knowledge-base.txt    ← All 20 documents for ingestion
├── neo4j/
│   ├── ontology-design.md             ← Knowledge graph schema documentation
│   └── cypher-scripts.cql             ← Cypher scripts to populate the graph
├── evaluation/
│   ├── evaluation-framework.md        ← Test queries, rubrics, and methodology
│   ├── evaluation-results.csv         ← Scored results across all tiers
│   └── tier-comparison-analysis.md    ← Written analysis of tier progression
├── docs/
│   ├── prd.md                         ← Product Requirements Document
│   └── architecture-decisions.md      ← Architecture Decision Record
└── assets/
    └── screenshots/                   ← Workflow screenshots and demo images
```

## How to Run

### Prerequisites
- Docker Desktop installed
- Google Gemini API key (free, no credit card: [ai.google.dev](https://ai.google.dev))
- Pinecone account (free tier: [pinecone.io](https://pinecone.io))
- Neo4j Aura account (free tier: [neo4j.com/cloud/aura](https://neo4j.com/cloud/aura))

### Setup
1. **Start n8n:**
   ```bash
   docker run -it --rm --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n n8nio/n8n
   ```
2. **Open n8n:** Go to `localhost:5678` in your browser
3. **Add credentials:** Gemini API key, Pinecone API key in n8n Credentials
4. **Create Pinecone index:** Name: `menova`, Dimensions: `3072`, Metric: `cosine`
5. **Import workflows:** In n8n, import the JSON files from the `workflows/` folder
6. **Ingest knowledge base:** Run the ingestion pipeline workflow with each document
7. **Populate Neo4j:** Run the Cypher scripts from `neo4j/cypher-scripts.cql` in Neo4j Browser
8. **Test:** Open any query workflow and use the built-in chat to ask questions

## PM Decision Framework

### When to use each tier:

**Start with Simple RAG when:**
- Queries are specific and well-formed
- Knowledge base is structured and consistently written
- Speed matters more than retrieval precision

**Upgrade to Agentic RAG when:**
- Users ask conversational, ambiguous questions
- Retrieval misses are caused by vocabulary mismatch, not knowledge gaps
- Multi-source synthesis is needed

**Invest in Graph RAG when:**
- Queries require relational reasoning (drug interactions, contraindications)
- Answers depend on connections between entities, not just document content
- Safety-critical decisions require structured knowledge traversal

### The upgrade signal:
Don't guess which tier you need. Start simple, instrument retrieval, and let failure modes tell you when to upgrade.

## About This Project

This project was built as an AI Product Management portfolio piece, inspired by [Sara Soleymani's RAG series](https://www.linkedin.com/pulse/rag-revenue-teams-from-simple-retrieval-agentic-graph-sara-soleymani-cjuec/) which demonstrated the same tier progression for sales/GTM use cases. menova applies the framework to healthcare — a domain where RAG quality isn't just a product metric, it's a safety requirement.

**Built by:** Neharika Srivastava

## License

MIT
