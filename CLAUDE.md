# CLAUDE.md

Guidance for Claude Code (and other AI assistants) working in this repository.

## Repository Overview

This repository contains course materials for **Applied Control Systems** (ENGM X304) at
Adelaide University. It is a LaTeX-based document system that produces:

- Lecture slides (Beamer)
- Topic notes / combined lecture notes
- Practical exercises and workshops
- Worked examples (article-style PDFs, published via GitHub Pages)
- Canvas LMS content (assignments, pages, discussions, rubrics via Lua scripts)

The notes supplement (not replace) the freely-available textbook *Feedback Systems: An
Introduction for Scientists and Engineers* by Åström and Murray ("AM" — see `\astrom{}` and
`\AMref{}` macros in the `.tex` sources).

This is a content/documentation repository, not software — there is no application code to
run, test, or deploy in the traditional sense. "Correctness" means the LaTeX compiles cleanly
and the content is accurate.

## Repository Structure

### Core build files
- `applied-control-systems.tex` — main document combining all topic content into one set of notes
- `Makefile` — build system (see below)
- `beamer-control.cls` — custom Beamer document class used by all slide decks
- `beamer-control-*.sty` — style files:
  - `beamer-control-maths.sty` — shared math macros/notation (used by slides AND worked examples)
  - `beamer-control-singlefile.sty` — for compiling a single topic file standalone
  - `beamer-control-workshop.sty`, `beamer-control-prac.sty` — workshop/practical styles
- `worked-examples-template.sty` — article-class template for worked examples
- `control.bib` — shared bibliography (BibTeX/Biber)

### Content naming convention
Slide content follows:
```
acs-[MODULE]-[TOPIC]-[CONCEPT]-[name].tex
```
- **Module 1** (`acs-1-*`): Dynamical Systems
  - Topic 1.1: Introduction & System Modelling
  - Topic 1.2: Dynamic Behaviour
  - Topic 1.3: Linear Systems
- **Module 2** (`acs-2-*`): Control System Concepts
  - Topic 2.4: State Feedback and Observers
  - Topic 2.5: Frequency Domain Analysis (Transfer Functions)
  - Topic 2.6: Stability Analysis (Frequency Domain)
- **Module 3** (`acs-3-*`): Control System Design
  - Topic 3.7: PID / Controller Design
  - Topic 3.8: Performance and Robustness (Frequency Domain Design)
  - Topic 3.9: Advanced/Robust Topics

Other top-level content:
- `acs-0-0-0-welcome.tex` — welcome/intro slides
- `acs-prac[1-6].tex` — laboratory practicals
- `acs-prac-project.tex` — course project
- `acs-workshop[1-9].tex` — workshop activities (some are stubs/placeholders)
- `acs-nup.tex` — n-up handout helper

### Worked examples (`worked-examples/`)
- Article-class PDFs, one file per **concept**, mirroring the slide naming convention exactly:
  `we-M-T-C-descr.tex` <-> `acs-M-T-C-descr.tex` (e.g. `we-1-1-1-intro.tex` ↔ `acs-1-1-1-intro.tex`)
- All use `worked-examples-template.sty`, which auto-loads `beamer-control-maths.sty` for
  consistent notation and configures figure paths back to the main repo directories.
- Each file compiles independently (two XeLaTeX passes for the TOC).
- Published to GitHub Pages via `.github/workflows/compile-examples.yml` and
  `.github/scripts/compile-examples.sh` (triggered on pushes to `main` touching
  `worked-examples/**`, the templates, `index.md`, or `_config.yml`).
- See `worked-examples/README.md` for the full concept list per topic, and
  `WORKED_EXAMPLES_SETUP.md` for background on how this subsystem was set up.

### Supporting directories
- `figures/` — shared images/logos
- `topic1/` … `topic9/` — per-topic figures, MATLAB/Simulink files, and source data
- `pracs/` — images and MATLAB files referenced by the practicals
- `extra/` — files uploaded as-is to Canvas (via `make extra`)
- `canvas/` — Canvas LMS integration: Lua scripts to create assignments, discussions, rubrics,
  pages, and to upload built files; `canvas-config.lua` holds shared config
- `_build/`, `_upload/`, `_extra/` — generated output (gitignored, safe to delete; recreated by `make`)

## Build System (Makefile)

Run `make help` for a summary. Key targets:
- `make topics` — PDFs for each topic (`acs-0-*`, `acs-1-*`, `acs-2-*`, `acs-3-*`)
- `make pracs` — PDFs for each practical
- `make workshops` — PDFs for each workshop
- `make notes` — combined lecture notes (`applied-control-systems.pdf`)
- `make examples` — PDFs for all worked examples → `_build/worked-examples/`
- `make all` — all of the above (this is what CI runs)
- `make clean` — remove LaTeX cruft and `_build/` contents
- `make upload<type>` / `make uploadall` — build and push to Canvas (requires `CANVAS_API_TOKEN`)
- `make extra` — upload everything in `extra/` to Canvas as-is

### Compilation details
- Engine: **XeLaTeX** (for font support — Latin Modern + OpenType math), with **BibTeX** for
  references. Slide/notes targets run xelatex → bibtex → xelatex. Worked examples run xelatex
  twice (no bibliography step).
- Required TeX Live packages are listed in `.github/tl_packages`.

## Development Workflow

1. Edit the relevant `.tex` (or `.sty`/`.cls`) file.
2. Build the affected target locally, e.g. `make topics`, `make examples`, or `make all`.
3. Review the generated PDF(s) in `_build/`.
4. `make clean` to reset build artifacts if needed.

### Conventions
- Use existing macros/environments from `beamer-control.cls` and `beamer-control-maths.sty`
  (e.g. `\CONCEPT{}`, `\SUMMARY`, `\AMref{}`, `\astrom{}`, `\INCLUDEONLY{}`) rather than
  reinventing formatting.
- Keep the slide ↔ worked-example naming convention in sync — if you add/rename a topic file
  `acs-M-T-C-name.tex`, add/rename the matching `we-M-T-C-name.tex` too (and update
  `worked-examples/README.md`'s concept list).
- New figures go in the appropriate `topic*/` directory (or `figures/` if shared/global);
  prefer PDF/SVG.
- Add new references to `control.bib`.
- Update `CHANGELOG.md` for notable content additions.

## CI/CD

- **`.github/workflows/main.yaml`** — runs on every push/PR to any branch: installs TeX Live
  (`.github/tl_packages`) and runs `make all`, uploading resulting PDFs as build artifacts.
  This is the main correctness check — **a passing `make all` is the bar for any `.tex` change**.
- **`.github/workflows/compile-examples.yml`** — on pushes to `main` affecting worked examples
  (or manual dispatch), compiles worked examples and deploys them + `index.md` via Jekyll to
  GitHub Pages.
- **`.github/workflows/jekyll-gh-pages.yml`** — separate Jekyll/Pages workflow (predates the
  worked-examples one; be mindful of overlap if touching Pages deployment).
- **`.github/workflows/deploy.yaml`** — on tagged releases or manual dispatch: builds and
  uploads everything to Canvas (`make uploadall`, requires `CANVAS_API_TOKEN` secret) and
  creates a GitHub Release with a zip of `_upload/`.

## Licensing

- Source is provided under a permissive licence, but **Adelaide University retains copyright**
  to the course content (see `README.md`, `LICENSE`).
- The repo itself carries a CC BY-NC-SA 4.0 badge — do not introduce content that conflicts
  with non-commercial/share-alike terms without checking with the maintainer.
- Do not redistribute compiled PDFs without clear provenance.

## Working with this repo as an AI assistant

- Make minimal, surgical changes — this is curriculum content reviewed by a human instructor.
- After editing `.tex` files, try to compile the relevant `make` target to catch LaTeX errors
  before handing back. If XeLaTeX/TeX Live isn't available in the environment, say so explicitly
  rather than claiming the build passes.
- Don't touch `_build/`, `_upload/`, `_extra/` — they're generated and gitignored.
- Be careful with Canvas-related Lua scripts (`canvas/*.lua`, `canvas-config.lua`,
  `canvas-acs-upload-file.lua`) — these can push live changes to the course LMS
  (`make upload*`, `make uploadall`, `make extra`). Treat these as side-effecting/production
  operations; don't run them unless explicitly asked, and never commit Canvas API tokens.
