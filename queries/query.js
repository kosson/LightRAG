#!/usr/bin/env node
/**
 * LightRAG Query Client
 * Simple Node.js client for querying local LightRAG knowledgebase
 */

import axios from 'axios';

const LIGHTRAG_URL = process.env.LIGHTRAG_URL || 'http://localhost:9621';
const API_KEY = process.env.LIGHTRAG_API_KEY || '';

/**
 * Query the LightRAG knowledgebase
 * @param {string} query - The question to ask
 * @param {Object} options - Query options
 * @returns {Promise<Object>} Query response
 */
async function queryLightRAG(query, options = {}) {
  const {
    mode = 'mix',
    includeReferences = true,
    includeChunkContent = false,
    topK = null,
    chunkTopK = null,
    enableRerank = null,
    responseType = null,
    onlyNeedContext = null,
  } = options;

  const headers = {
    'Content-Type': 'application/json',
  };

  if (API_KEY) {
    headers['X-API-Key'] = API_KEY;
  }

  const payload = {
    query,
    mode,
    include_references: includeReferences,
    include_chunk_content: includeChunkContent,
  };

  // Add optional parameters only if provided
  if (topK !== null) payload.top_k = topK;
  if (chunkTopK !== null) payload.chunk_top_k = chunkTopK;
  if (enableRerank !== null) payload.enable_rerank = enableRerank;
  if (responseType !== null) payload.response_type = responseType;
  if (onlyNeedContext !== null) payload.only_need_context = onlyNeedContext;

  try {
    const response = await axios.post(`${LIGHTRAG_URL}/query`, payload, {
      headers,
      timeout: 60000, // 60 second timeout
    });

    return response.data;
  } catch (error) {
    if (error.response) {
      throw new Error(
        `LightRAG API error (${error.response.status}): ${
          error.response.data.detail || error.response.statusText
        }`
      );
    } else if (error.request) {
      throw new Error(
        `Cannot reach LightRAG server at ${LIGHTRAG_URL}. Is it running?`
      );
    } else {
      throw error;
    }
  }
}

/**
 * Format and display query results
 * @param {Object} result - Query result object
 * @param {Object} options - Display options
 */
function displayResults(result, options = {}) {
  const { contextOnly = false } = options;

  // If only context was requested, display retrieved chunks
  if (contextOnly && result.context) {
    console.log('\n=== RETRIEVED CONTEXT ===');
    console.log(result.context);
    return;
  }

  if (result.response) {
    console.log('\n=== ANSWER ===');
    console.log(result.response);
  }

  if (result.references && result.references.length > 0) {
    console.log('\n=== REFERENCES ===');
    result.references.forEach((ref) => {
      console.log(`[${ref.reference_id}] ${ref.file_path}`);
      if (ref.content && Array.isArray(ref.content)) {
        ref.content.forEach((chunk, idx) => {
          console.log(`  Chunk ${idx + 1}:`);
          console.log(`  ${chunk.substring(0, 150)}...`);
        });
      }
    });
  }
}

// Main execution
async function main() {
  const args = process.argv.slice(2);

  if (args.length === 0) {
    console.log('Usage: node query.js <your question> [options]');
    console.log('\nExamples:');
    console.log('  node query.js "Which journals do you have articles for?"');
    console.log('  node query.js --mode naive "articles about digital curation"');
    console.log('  node query.js --context-only "digital curation"');
    console.log('  node query.js --chunks 20 "digital curation"');
    console.log('\nEnvironment variables:');
    console.log('  LIGHTRAG_URL - LightRAG server URL (default: http://localhost:9621)');
    console.log('  LIGHTRAG_API_KEY - API key if authentication is enabled');
    console.log('\nQuery modes (--mode <mode>):');
    console.log('  naive  - Vector similarity search (BEST for finding specific terms/phrases)');
    console.log('  local  - Focuses on specific entities');
    console.log('  global - Analyzes patterns across knowledge graph');
    console.log('  hybrid - Combines local and global');
    console.log('  mix    - Combines knowledge graph and vector search (default)');
    console.log('\nOptions:');
    console.log('  --mode <mode>        Query mode (default: mix)');
    console.log('  --chunks <n>         Number of chunks to retrieve (default: auto)');
    console.log('  --top-k <n>          Number of top entities/relations (default: auto)');
    console.log('  --include-chunks     Include full chunk text in references');
    console.log('  --context-only       Show retrieved context without generating answer');
    console.log('  --no-rerank          Disable reranking of retrieved chunks');
    process.exit(1);
  }

  // Parse arguments
  let query = '';
  let mode = 'mix';
  let includeChunkContent = false;
  let chunkTopK = null;
  let topK = null;
  let contextOnly = false;
  let enableRerank = null;

  for (let i = 0; i < args.length; i++) {
    if (args[i] === '--mode' && i + 1 < args.length) {
      mode = args[i + 1];
      i++;
    } else if (args[i] === '--chunks' && i + 1 < args.length) {
      chunkTopK = parseInt(args[i + 1], 10);
      i++;
    } else if (args[i] === '--top-k' && i + 1 < args.length) {
      topK = parseInt(args[i + 1], 10);
      i++;
    } else if (args[i] === '--include-chunks') {
      includeChunkContent = true;
    } else if (args[i] === '--context-only') {
      contextOnly = true;
    } else if (args[i] === '--no-rerank') {
      enableRerank = false;
    } else {
      query += (query ? ' ' : '') + args[i];
    }
  }

  if (!query) {
    console.error('Error: No query provided');
    process.exit(1);
  }

  console.log(`Querying LightRAG at ${LIGHTRAG_URL}...`);
  console.log(`Mode: ${mode}`);
  if (chunkTopK) console.log(`Chunk retrieval: ${chunkTopK}`);
  if (topK) console.log(`Top-K: ${topK}`);
  if (contextOnly) console.log('Context-only mode: ON');
  console.log(`Query: "${query}"\n`);

  try {
    const result = await queryLightRAG(query, {
      mode,
      includeReferences: true,
      includeChunkContent,
      chunkTopK,
      topK,
      onlyNeedContext: contextOnly,
      enableRerank,
    });

    displayResults(result, { contextOnly });
  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
}

// Run if called directly
if (import.meta.url === `file://${process.argv[1]}`) {
  main();
}

export { queryLightRAG, displayResults };
