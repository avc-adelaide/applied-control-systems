# Worked Examples

This directory contains worked examples for the Applied Control Systems course (ENGM X304).

## Structure

Each LaTeX file corresponds to one **concept** in the course and follows the naming pattern:
- `we-M-T-C-descr.tex` where:
  - `M` is the module number (1, 2, or 3)
  - `T` is the topic number within the module
  - `C` is the concept number within the topic
  - `descr` is a short descriptor matching the slide file naming

This matches the slide naming convention exactly (e.g., `acs-1-1-1-intro.tex` → `we-1-1-1-intro.tex`).

The files are organized by modules and topics:

### Module 1: Dynamical Systems

**Topic 1.1: Introduction and System Modelling**
- `we-1-1-1-intro.tex` - Introduction
- `we-1-1-2-concepts.tex` - Modeling Concepts
- `we-1-1-3-statespace.tex` - State Space Models
- `we-1-1-4-modelling.tex` - Modelling Methodology

**Topic 1.2: Dynamic Behaviour**
- `we-1-2-1-diffeq.tex` - Solving Differential Equations
- `we-1-2-2-qual.tex` - Qualitative Analysis
- `we-1-2-3-stability.tex` - Stability
- `we-1-2-4-examples.tex` - Examples

**Topic 1.3: Linear Systems**
- `we-1-3-1-linear.tex` - Basic Definitions
- `we-1-3-2-matrix.tex` - The Matrix Exponential
- `we-1-3-3-response.tex` - Input/Output Response
- `we-1-3-4-linearisation.tex` - Linearisation

### Module 2: Control System Concepts

**Topic 2.4: State Feedback**
- `we-2-4-1-reachability.tex` - Reachability
- `we-2-4-2-stabilisation.tex` - Stabilisation by State Feedback
- `we-2-4-3-statedesign.tex` - Design Considerations
- `we-2-4-4-integral.tex` - Integral Action
- `we-2-4-5-observer.tex` - Output Feedback Basics

**Topic 2.5: Transfer Functions**
- `we-2-5-1-freq.tex` - Frequency Domain Modeling
- `we-2-5-2-tf.tex` - Determining the Transfer Function
- `we-2-5-3-laplace.tex` - Laplace Transforms
- `we-2-5-4-blockdiag.tex` - Block Diagrams and Transfer Functions
- `we-2-5-5-dc.tex` - Zero Frequency Gain, Poles, and Zeros
- `we-2-5-6-bode.tex` - The Bode Plot

**Topic 2.6: Frequency Domain Analysis**
- `we-2-6-1-loop.tex` - The Loop Transfer Function
- `we-2-6-2-nyq.tex` - The Nyquist Criterion
- `we-2-6-3-stabmarg.tex` - Stability Margins
- `we-2-6-4-minphase.tex` - Bode's Relations and Minimum Phase Systems

### Module 3: Control System Design

**Topic 3.7: PID Control**
- `we-3-7-1-control.tex` - Basic Control Functions
- `we-3-7-2-simple.tex` - Simple Controllers for Complex Systems
- `we-3-7-3-pid.tex` - PID Tuning
- `we-3-7-4-windup.tex` - Integrator Windup
- `we-3-7-5-implement.tex` - Implementation

**Topic 3.8: Frequency Domain Design**
- `we-3-8-1-sensitivity.tex` - Sensitivity Functions
- `we-3-8-2-performance.tex` - Performance Specifications
- `we-3-8-3-loopshape.tex` - Feedback Design via Loop Shaping
- `we-3-8-4-rootlocus.tex` - The Root-Locus Method

**Topic 3.9: Robust Performance & Fundamental Limits**
- `we-3-9-1-uncertainmod.tex` - Modeling Uncertainty
- `we-3-9-2-uncertainty.tex` - Stability and Performance in the Presence of Uncertainty
- `we-3-9-3-sysdesign.tex` - System Design Considerations
- `we-3-9-4-robust.tex` - Robust Pole Placement
- `we-3-9-5-nonlinear.tex` - Nonlinear Effects

## Building

To compile all worked examples:
```bash
make examples
```

The PDFs will be generated in the `_build/worked-examples/` directory.

Each file compiles independently and cleanly.

## Template

All worked examples use the `worked-examples-template.sty` style file which:
- Sets up the article document class with appropriate formatting
- Loads standard packages including TikZ for diagrams
- Automatically loads `beamer-control-maths.sty` for consistent mathematical notation
- Configures paths to access figures from the main repository
- Provides professional formatting with headers and footers

## File Structure

Each worked example file includes:
1. A title page with the concept name and number
2. A table of contents
3. The concept section with worked examples
4. Consistent mathematical notation from `beamer-control-maths.sty`

## Adding Content

To add examples to a worked example:
1. Navigate to the appropriate `we-M-T-C-*.tex` file
2. Add new subsections with descriptive titles
3. Include the problem statement and detailed solution
4. Use TikZ for diagrams if needed
5. Use the consistent mathematical notation from `beamer-control-maths.sty`

## GitHub Pages

The worked examples are automatically compiled and published to GitHub Pages via GitHub Actions. The workflow is triggered on:
- Pushes to the main branch that modify files in this directory
- Manual workflow dispatch

View the published examples at the course website.
