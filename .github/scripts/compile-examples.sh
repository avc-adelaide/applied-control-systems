#!/bin/bash
# Compile all worked example LaTeX files to PDFs
# Usage: ./compile-examples.sh <output_directory>

set -e

OUTPUT_DIR="${1:-./_site}"

echo "Compiling worked examples to $OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

for texfile in worked-examples/we-*.tex; do
  echo "Compiling $texfile"
  filename=$(basename "$texfile" .tex)
  
  # Create temporary build directory
  mkdir -p _build_temp
  cd _build_temp
  
  # Copy necessary files
  cp ../"$texfile" .
  cp ../worked-examples-template.sty .
  cp ../beamer-control-maths.sty .
  
  # Copy resource directories if they exist
  if [ -d ../figures ]; then cp -r ../figures .; fi
  for i in {1..9}; do
    if [ -d ../topic$i ]; then cp -r ../topic$i .; fi
  done
  if [ -d ../pracs ]; then cp -r ../pracs .; fi
  
  # Compile twice for TOC
  xelatex -interaction=nonstopmode "$filename.tex" || true
  xelatex -interaction=nonstopmode "$filename.tex" || true
  
  # Copy PDF to output directory if it was created
  if [ -f "$filename.pdf" ]; then
    cp "$filename.pdf" "../$OUTPUT_DIR/"
    echo "✓ Successfully compiled $filename.pdf"
  else
    echo "✗ Failed to compile $filename.pdf"
  fi
  
  cd ..
  rm -rf _build_temp
done

echo "Compilation complete"
