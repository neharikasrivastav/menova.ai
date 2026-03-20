# Menova — Architecture Decision Record (ADR)

## ADR-001: Three-Tier RAG Architecture


### Context
We needed to build an AI health assistant for menopause that handles queries ranging from simple factual lookups to complex drug interaction safety checks. A single retrieval strategy cannot serve all query types effectively.

### Decision
Implement a three-tier RAG architecture where each tier addresses a specific failure mode:
- **Tier 1 (Simple RAG):** Direct embedding-based retrieval for factual queries
- **Tier 2 (Agentic RAG):** Query rewriting + multi-source retrieval for conversational queries
- **Tier 3 (Graph RAG):** Knowledge graph traversal for relational safety queries

### Rationale
Each tier was justified by documented failure modes:
- Simple RAG failed on conversational queries due to vocabulary mismatch between user language ("brain fog") and clinical documentation ("cognitive changes associated with menopause")
- Agentic RAG failed on multi-constraint safety queries because relational reasoning (breast cancer history → HRT contraindication → safe alternatives) cannot be accomplished through text search
- Starting with the simplest tier and upgrading based on evidence prevents over-engineering

### Consequences
- Higher architectural complexity (5 workflows instead of 1)
- Each tier adds latency (1 LLM call for Simple, 2 for Agentic, 2 for Graph)
- Maintenance of both vector database and graph database
- Clear separation of concerns makes debugging easier

---

## ADR-002: Confidence-Gated Query Routing


### Context
Not every query needs the most sophisticated (and expensive/slow) RAG tier. Simple educational questions shouldn't pay the latency cost of graph traversal, and high-risk drug interaction queries shouldn't be handled by simple retrieval.

### Decision
Implement a confidence router that classifies every query as LOW, MEDIUM, or HIGH risk before routing to the appropriate tier.

### Rationale
- LOW risk queries (educational) are well-served by Simple RAG — fast, cheap, accurate
- MEDIUM risk queries (symptom analysis) need Agentic RAG's vocabulary translation and multi-source synthesis
- HIGH risk queries (drug interactions, contraindications) need Graph RAG's relational reasoning
- Routing reduces average latency and cost while maintaining safety for high-risk queries

### Consequences
- One additional LLM call per query for classification
- Router accuracy becomes a critical metric
- Misclassification risk: HIGH query routed to Simple RAG could produce unsafe answers
- Router prompt requires careful design and ongoing evaluation

---

## ADR-003: Post-Response Safety Check Layer

### Context
In healthcare AI, a wrong answer isn't just unhelpful — it can be dangerous. Even with grounded RAG, the system could generate responses that recommend specific medications, make definitive diagnoses, or miss important safety caveats.

### Decision
Add a safety review LLM call after every generated response that evaluates the output against clinical safety criteria before showing it to the user.

### Rationale
- The safety checker caught a real issue in testing: a response that failed to mention symptoms could indicate conditions other than menopause
- Healthcare requires defense-in-depth — multiple layers of safety, not just one
- The safety checker can modify unsafe responses rather than just blocking them, maintaining user experience

### Consequences
- Additional LLM call increases latency and cost
- Rate limit pressure on free-tier API (mitigated by using flash-lite model)
- False positives (flagging safe responses as unsafe) need monitoring
- The safety checker itself could make errors — it's an additional layer of protection, not a guarantee

---

## ADR-004: Google Gemini Free Tier as LLM Provider

### Decision
Use Google Gemini API free tier for all LLM calls and embeddings.

### Rationale
- Free tier with no credit card required
- Both chat models (gemini-2.5-flash-lite) and embedding models (gemini-embedding-001) available
- n8n has built-in Gemini integration

### Consequences
- Rate limits (5-15 RPM) require careful workflow design and waiting between tests
- Service availability can be intermittent during high-demand periods
- Embedding dimensions (3072 for gemini-embedding-001) require matching Pinecone index configuration
- In production, would need paid tier or alternative provider for reliability

### Production Recommendation
For a production deployment, switch to a paid API tier or self-hosted model to eliminate rate limits and improve reliability. The architecture is provider-agnostic — swapping Gemini for OpenAI, Anthropic, or a self-hosted model requires only credential and model name changes in n8n.

---

## ADR-005: Knowledge Graph Data Embedded in Prompt (Graph RAG)


### Context
The Neo4j Aura HTTP API connection from n8n's self-hosted Docker environment encountered authentication issues that could not be resolved within the project timeline.

### Decision
Embed the knowledge graph data directly in the Graph RAG synthesizer prompt rather than querying Neo4j live at runtime.

### Rationale
- The graph data (contraindications, interactions, alternatives) is relatively static and fits within the context window
- The PM value of Graph RAG is in the ontology design and relational reasoning, not in the HTTP connection
- The same Cypher scripts that would power live queries are included in the repo for anyone who resolves the connection
- The response quality is identical whether data comes from a live query or an embedded prompt

### Consequences
- Graph data updates require prompt changes rather than database updates
- Cannot demonstrate dynamic Cypher query generation based on entity extraction
- Neo4j graph exists and is populated — the architecture is sound even if the live connection is a TODO

### Future Work
Resolve the Neo4j HTTP API authentication for live graph queries. This would enable dynamic Cypher generation where the entity extractor's output drives the specific graph traversal, rather than providing the full graph context in every prompt.
