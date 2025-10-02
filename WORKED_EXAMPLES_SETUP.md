# Worked Examples Setup

This document describes the worked examples system that has been set up for the Applied Control Systems course.

## What Was Created

### 1. Folder Structure
- **`worked-examples/`** - Contains all worked example LaTeX files
- **`worked-examples-template.sty`** - Template style file for consistent formatting

### 2. LaTeX Template (`worked-examples-template.sty`)
The template file provides:
- Article document class configuration with appropriate geometry
- Standard packages including:
  - TikZ and CircuiTikZ for diagrams
  - AMS math packages for mathematical typesetting
  - Hyperref for cross-references and links
- **Automatic loading of `beamer-control-maths.sty`** for consistent mathematical notation
- Path setup to access figures from the repository directories
- Professional formatting with headers and footers

### 3. Worked Example Files (9 files)
One LaTeX file per topic, following the M-T naming pattern:

**Module 1: Dynamical Systems**
- `we-1-1-intro-modelling.tex` - 4 concepts (Introduction, Concepts, State Space, Modelling)
- `we-1-2-dynamic-behaviour.tex` - 4 concepts (Differential Equations, Qualitative Analysis, Stability, Examples)
- `we-1-3-linear-systems.tex` - 4 concepts (Linear Systems, Matrix Exponentials, System Response, Linearisation)

**Module 2: Control System Concepts**
- `we-2-4-state-feedback.tex` - 5 concepts (Reachability, Stabilisation, State Design, Integral Action, Observer Design)
- `we-2-5-transfer-functions.tex` - 6 concepts (Frequency Domain, Transfer Functions, Laplace Transform, Block Diagrams, DC Gain, Bode Plots)
- `we-2-6-frequency-domain-analysis.tex` - 4 concepts (Loop Analysis, Nyquist Criterion, Stability Margins, Minimum Phase Systems)

**Module 3: Control System Design**
- `we-3-7-pid-control.tex` - 5 concepts (Feedback Control, Simple Controllers, PID Control, Anti-Windup, Implementation)
- `we-3-8-frequency-domain-design.tex` - 4 concepts (Sensitivity Functions, Performance Specifications, Loop Shaping, Root Locus)
- `we-3-9-robust-performance.tex` - 5 concepts (Uncertainty Modelling, Robust Stability, System Design, Robust Control, Nonlinear Systems)

Each file includes:
- Title page with topic information
- Table of contents
- Sections for each concept following the M-T-C-* numbering pattern
- Placeholder examples ready to be populated with actual content

### 4. Makefile Updates
Added support for building worked examples:
- `make examples` - Builds all worked example PDFs
- Output goes to `_build/worked-examples/`
- Automatically copies necessary style files and resources

### 5. GitHub Actions Workflow (`.github/workflows/compile-examples.yml`)
Automated compilation and deployment:
- **Trigger**: Pushes to main branch affecting worked-examples files or manual dispatch
- **Process**:
  1. Installs TeX Live with XeLaTeX support
  2. Compiles each worked example twice (for table of contents)
  3. Generates a professional index page for browsing
  4. Deploys PDFs and index to GitHub Pages
- **Output**: A browsable website with all worked examples as PDFs

### 6. Index Page
An attractive HTML index page is automatically generated with:
- Organized listing by module and topic
- Direct links to each PDF
- Professional styling matching the course theme
- Mobile-responsive design

## Next Steps

### For the Repository Owner

1. **Enable GitHub Pages**:
   - Go to repository Settings → Pages
   - Under "Build and deployment", set Source to "GitHub Actions"
   - The URL will be: `https://avc-adelaide.github.io/applied-control-systems/`

2. **Handle Conflicting Workflows** (if needed):
   - The repository has a `jekyll-gh-pages.yml` workflow
   - If both workflows are active, they may conflict (both try to deploy to Pages)
   - Options:
     - **Option A**: Disable `jekyll-gh-pages.yml` if only examples are needed
     - **Option B**: Modify workflows to work together (examples in a subfolder)
     - **Option C**: Keep only one workflow based on needs

3. **Populate Examples**:
   - Open subsequent issues with specific content for each topic
   - Contributors can add examples to the placeholder sections
   - Each push will automatically recompile and update the website

### Building Locally

```bash
# Build all worked examples
make examples

# PDFs will be in _build/worked-examples/
```

### Adding New Examples

To add content to a worked example:

1. Open the relevant `worked-examples/we-*.tex` file
2. Navigate to the appropriate section
3. Replace placeholder content with:
   - Problem statement
   - Detailed solution with steps
   - Diagrams using TikZ if needed
4. Use mathematical notation from `beamer-control-maths.sty`
5. Commit changes - the workflow will automatically rebuild

## File Compilation Status

All 9 worked example files are structured and ready to compile. They contain:
- ✅ Proper LaTeX structure
- ✅ Title and table of contents
- ✅ Sections for all concepts in each topic
- ✅ Placeholder content
- ⏳ Actual worked examples (to be added per future issues)

## Technical Details

- **LaTeX Engine**: XeLaTeX (for font support)
- **Compilation**: Two passes for TOC generation
- **Math Symbols**: Shared with slides via `beamer-control-maths.sty`
- **Figures**: Accessible from topic directories and central figures folder
- **Document Class**: Article (not Beamer)
- **Fonts**: Latin Modern with OpenType math support
