#!/bin/bash

# Create the CORPUS directory if it doesn't exist
CORPUS_DIR="./CORPUS"
mkdir -p "$CORPUS_DIR"

# Loop through all markdown files in the current directory and its subdirectories
find . -name "*.md" | while read -r file; do
  # Extract the base name of the file without the extension
  base=$(basename "$file" .md)
  
  # Convert the markdown file to plain text and save it in the CORPUS directory
  pandoc --wrap=none "$file" -o "$CORPUS_DIR/$base.txt"
done
