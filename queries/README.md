# LightRAG Query Client

A simple Node.js application for querying your local LightRAG knowledgebase.

## Installation

```bash
cd queries
npm install
```

## Usage

### Command-line Query

Query the knowledgebase with a single question:

```bash
node query.js "Which journals do you have articles for in the local knowledgebase?"
```

With options:

```bash
# Use global mode (best for broad questions)
node query.js --mode global "Which journals do you have articles for?"

# Include actual chunk content in results
node query.js --include-chunks "What is LightRAG?"

# Local mode (best for specific entities)
node query.js --mode local "Tell me about quantum computing"
```

### Interactive Mode

Start an interactive session for continuous querying:

```bash
node interactive.js
```

Interactive commands:
- `/mode <mode>` - Change query mode (local, global, hybrid, mix, naive)
- `/help` - Show help
- `/exit` or `/quit` - Exit
- Any other text - Query the knowledgebase

### Using npm scripts

```bash
# Single query
npm run query "Your question here"

# Interactive mode
npm run interactive
```

## Query Modes

- **local** - Focuses on specific entities and their direct relationships
- **global** - Analyzes patterns across the entire knowledge graph (best for broad questions like "which journals...")
- **hybrid** - Combines local and global approaches
- **mix** - Integrates knowledge graph and vector retrieval (default, good general-purpose)
- **naive** - Simple vector similarity search

## Configuration

### Environment Variables

Create a `.env` file in the `queries` folder (optional):

```bash
# LightRAG server URL
LIGHTRAG_URL=http://localhost:9621

# API Key (sent as X-API-Key header)
LIGHTRAG_API_KEY=your-api-key-here
```

Or set them directly:

```bash
export LIGHTRAG_URL=http://localhost:9621
export LIGHTRAG_API_KEY=your-api-key-here
node query.js "Your question"
```

### Authentication Methods

LightRAG supports two authentication methods:

1. **API Key** (Simple) - Set `LIGHTRAG_API_KEY` environment variable
   - Sent as `X-API-Key` header
   - Best for direct API access and automation

2. **JWT Token** (OAuth2) - For user-based authentication
   - Currently not implemented in this client
   - Used for web UI login with username/password

## Examples

```bash
# Broad corpus-wide question (use global mode)
node query.js --mode global "Which journals do you have articles for?"

# Finding specific terms/phrases (use naive mode with more chunks)
node query.js --mode naive --chunks 30 "digital curation"

# Show which files contain a term with chunk content
node query.js --mode naive --chunks 30 --include-chunks "digital curation"

# Specific factual question (use mix mode - default)
node query.js "What is retrieval-augmented generation?"

# Entity-focused question (use local mode)
node query.js --mode local "Tell me about the LightRAG framework"

# Get full chunk content for debugging
node query.js --include-chunks "How does LightRAG work?"
```

## Query Mode Selection Guide

**Choose the right mode for your question:**

- **`naive`** - Best for finding **specific terms or phrases**
  - Example: "articles about digital curation"
  - Example: "files containing quantum computing"
  - Tip: Use `--chunks 20-30` for better coverage
  
- **`global`** - Best for **broad questions** about the corpus
  - Example: "Which journals do you have?"
  - Example: "What topics are covered in this knowledgebase?"
  
- **`local`** - Best for **entity-specific** questions
  - Example: "Tell me about [specific person/concept]"
  
- **`mix`** - Good **general-purpose** mode (default)
  - Combines knowledge graph and vector search
  
- **`hybrid`** - Experimental combination of local and global

## API Reference

The module exports two functions that can be imported:

```javascript
import { queryLightRAG, displayResults } from './query.js';

// Query the knowledgebase
const result = await queryLightRAG("Your question", {
  mode: 'mix',              // Query mode
  includeReferences: true,  // Include source references
  includeChunkContent: false, // Include actual chunk text
  topK: null,              // Number of top items to retrieve
  enableRerank: null,      // Enable reranking
  responseType: null,      // Response format hint
});

// Display formatted results
displayResults(result);
```

## Requirements

- Node.js 16+ (uses ES modules)
- Running LightRAG server (default: http://localhost:9621)

## Troubleshooting

**Error: Cannot reach LightRAG server**
- Ensure the LightRAG server is running: `lightrag-server` or `uvicorn lightrag.api.lightrag_server:app`
- Check that the port matches (default: 9621)
- Verify the URL with `echo $LIGHTRAG_URL`

**Authentication errors**
- The API key must be sent as `X-API-Key` header (not Bearer token)
- Set your API key: `export LIGHTRAG_API_KEY=your-key`
- Or add it to `.env` file in the queries folder
- Check your LightRAG server's `.env` for the configured `LIGHTRAG_API_KEY` value
