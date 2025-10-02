# Worked Examples

This directory contains worked examples for the Applied Control Systems course (ENGM X304).

## Structure

Each LaTeX file corresponds to one topic in the course and follows the naming pattern:
- `we-M-T-topic-name.tex` where M is the module number and T is the topic number

The files are organized by modules:

### Module 1: Dynamical Systems
- `we-1-1-intro-modelling.tex` - Introduction and System Modelling
- `we-1-2-dynamic-behaviour.tex` - Dynamic Behaviour
- `we-1-3-linear-systems.tex` - Linear Systems

### Module 2: Control System Concepts
- `we-2-4-state-feedback.tex` - State Feedback
- `we-2-5-transfer-functions.tex` - Transfer Functions
- `we-2-6-frequency-domain-analysis.tex` - Frequency Domain Analysis

### Module 3: Control System Design
- `we-3-7-pid-control.tex` - PID Control
- `we-3-8-frequency-domain-design.tex` - Frequency Domain Design
- `we-3-9-robust-performance.tex` - Robust Performance & Fundamental Limits

## Building

To compile all worked examples:
```bash
make examples
```

The PDFs will be generated in the `_build/worked-examples/` directory.

## Template

All worked examples use the `worked-examples-template.sty` style file which:
- Sets up the article document class with appropriate formatting
- Loads standard packages including TikZ for diagrams
- Automatically loads `beamer-control-maths.sty` for consistent mathematical notation
- Configures paths to access figures from the main repository

## Adding Content

Each worked example file includes:
1. A title page with the topic name
2. A table of contents
3. Sections for each concept following the M-T-C-* numbering pattern
4. Placeholder examples that should be replaced with actual worked problems

To add a new example:
1. Navigate to the appropriate section in the relevant `.tex` file
2. Add a new subsection with a descriptive title
3. Include the problem statement and detailed solution
4. Use the consistent mathematical notation from `beamer-control-maths.sty`

## GitHub Pages

The worked examples are automatically compiled and published to GitHub Pages via GitHub Actions. The workflow is triggered on:
- Pushes to the main branch that modify files in this directory
- Manual workflow dispatch

View the published examples at: [GitHub Pages URL will be available after first deployment]

**Note:** The `compile-examples.yml` workflow will compile all LaTeX files and deploy them to GitHub Pages. If the repository has Jekyll enabled, you may need to disable the `jekyll-gh-pages.yml` workflow or configure it to work alongside the examples workflow.
