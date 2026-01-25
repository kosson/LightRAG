#!/usr/bin/env node
/**
 * Interactive LightRAG Query Client
 * Allows continuous querying with a simple CLI interface
 */

import { createInterface } from 'readline';
import { queryLightRAG, displayResults } from './query.js';

const LIGHTRAG_URL = process.env.LIGHTRAG_URL || 'http://localhost:9621';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  prompt: 'LightRAG> ',
});

let currentMode = 'mix';

console.log('=== LightRAG Interactive Query Client ===');
console.log(`Connected to: ${LIGHTRAG_URL}`);
console.log(`Current mode: ${currentMode}`);
console.log('\nCommands:');
console.log('  /mode <local|global|hybrid|mix|naive> - Change query mode');
console.log('  /help - Show this help message');
console.log('  /exit or /quit - Exit the application');
console.log('  Any other text - Query the knowledgebase\n');

rl.prompt();

rl.on('line', async (line) => {
  const input = line.trim();

  if (!input) {
    rl.prompt();
    return;
  }

  // Handle commands
  if (input.startsWith('/')) {
    const [command, ...args] = input.slice(1).split(' ');

    switch (command.toLowerCase()) {
      case 'exit':
      case 'quit':
        console.log('Goodbye!');
        process.exit(0);
        break;

      case 'mode':
        if (args.length === 0) {
          console.log(`Current mode: ${currentMode}`);
          console.log('Available modes: local, global, hybrid, mix, naive');
        } else {
          const newMode = args[0].toLowerCase();
          if (['local', 'global', 'hybrid', 'mix', 'naive'].includes(newMode)) {
            currentMode = newMode;
            console.log(`Mode changed to: ${currentMode}`);
          } else {
            console.log(`Invalid mode: ${newMode}`);
            console.log('Available modes: local, global, hybrid, mix, naive');
          }
        }
        break;

      case 'help':
        console.log('\nCommands:');
        console.log('  /mode <local|global|hybrid|mix|naive> - Change query mode');
        console.log('  /help - Show this help message');
        console.log('  /exit or /quit - Exit the application');
        console.log('  Any other text - Query the knowledgebase');
        console.log('\nQuery Modes:');
        console.log('  local  - Focuses on specific entities');
        console.log('  global - Analyzes patterns across knowledge graph');
        console.log('  hybrid - Combines local and global');
        console.log('  mix    - Combines knowledge graph and vector search (default)');
        console.log('  naive  - Simple vector similarity search\n');
        break;

      default:
        console.log(`Unknown command: /${command}`);
        console.log('Type /help for available commands');
    }

    rl.prompt();
    return;
  }

  // Handle query
  try {
    console.log(`\n[Querying in ${currentMode} mode...]`);
    const result = await queryLightRAG(input, {
      mode: currentMode,
      includeReferences: true,
    });

    displayResults(result);
    console.log(''); // Empty line for readability
  } catch (error) {
    console.error('Error:', error.message);
  }

  rl.prompt();
});

rl.on('close', () => {
  console.log('\nGoodbye!');
  process.exit(0);
});
