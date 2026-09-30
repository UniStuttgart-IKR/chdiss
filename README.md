# `chdiss`: Typst PhD Dissertation Template

A comprehensive PhD dissertation template for engineering and computer science, styled according to the requirements of the Universität Stuttgart (IKR).

## Features

- **Document Configuration (`chdiss`)**:
  - Frontmatter: University cover page, dedication, abstract, kurzfassung, table of contents, list of figures, list of tables, and list of algorithms.
  - Typographic setup: Customizable typography (`DejaVu Serif`, `Latin Modern Sans`, `TeX Gyre Heros`), chapter numbering styles, custom page headers/footers with odd/even page differentiation.
- **Two-Tier Bibliography (Pergamon)**:
  - Separate listings for **Own Publications** and **External Literature**, filtered via BibTeX keywords (`keyword: "own"`).
  - Alphanumeric citation style with hyperlinked references.
- **Acronyms, Glossary & Symbols (Glossy)**:
  - Automated acronym expansions on first use.
  - Three distinct reference tables: Acronyms, Glossary, and Mathematical Symbols.
- **Algorithms Support (`clean-algorithmic`)**:
  - Pre-exported algorithm styling primitives: `CleanProcedure`, `Assign`, `For`, `If`, `Else`, `Return`, etc.
- **Vector Graphics & CeTZ Integration**:
  - Re-exported CeTZ canvas wrappers for network diagrams and mathematical illustrations.
- **Subfigures & Multi-Column Layouts**:
  - Pre-configured single-column, multi-column, and multi-row subfigures with proper `i-figured` numbering and list of figures inclusion.

---

## Quick Start

### 1. Initialize a new project with Typst CLI

If installed locally:
```bash
typst init @local/chdiss:0.1.0 my-dissertation
cd my-dissertation
typst watch main.typ
```

### 2. Manual Installation into Local Packages

From this repository root:
```bash
make install-local
```
This symlinks this repository to:
```
~/.local/share/typst/packages/local/chdiss/0.1.0
```

To verify the installation:
```bash
make test-init
```

---

## Template Project Structure

When initialized, the project directory contains:

```
my-dissertation/
├── main.typ               # Main document entry point
├── Makefile               # Convenient build rules
├── content/               # Chapter and frontmatter Typst files
│   ├── abstract.typ
│   ├── dedication.typ
│   ├── kurzfassung.typ
│   ├── 01_introduction.typ
│   ├── 02_background.typ
│   ├── 03_methodology.typ
│   ├── 04_evaluation.typ
│   ├── 05_conclusion.typ
│   └── 06_appendix.typ
├── figures/               # Images and diagrams
└── helperfiles/           # Metadata, bibliography, and glossaries
    ├── glossary.yaml      # Definitions for Acronyms, Glossary, Symbols
    ├── references.bib     # BibTeX references (tagged with keywords)
    └── details.toml       # Optional metadata configuration
```

---

## Basic Usage

In `main.typ`:

```typst
#import "@local/chdiss:0.1.0": *

#show: chdiss.with(
  title: [Your Dissertation Title],
  author: "Author Name",
  birthplace: "City, Country",
  first_examiner: "Prof. Dr.-Ing. First Examiner",
  second_examiner: "Prof. Dr.-Ing. Second Examiner",
  faculty: "Faculty of Computer Science, Electrical Engineering and Information Technology",
  university: "Universität Stuttgart",
  institute: "Institute of Communication Networks and Computer Engineering (IKR)",
  year: "2026",

  // Typography & Font Configuration (optional overrides; defaults shown)
  // font_text: "DejaVu Serif",
  // font_size: 13pt,
  // font_prog: "New Computer Modern",
  // font_header: "Latin Modern Sans",
  // font_headings: "Latin Modern Sans",
  // font_figure: "Latin Modern Sans",
  // font_algo: "TeX Gyre Heros",

  abstract: include "content/abstract.typ",
  kurzfassung: include "content/kurzfassung.typ",
  dedication: include "content/dedication.typ",
  glossary: yaml("helperfiles/glossary.yaml"),
  bib: read("helperfiles/references.bib"),
)

#include "content/01_introduction.typ"
#include "content/02_background.typ"
#include "content/03_methodology.typ"
#include "content/04_evaluation.typ"
#include "content/05_conclusion.typ"
#include "content/06_appendix.typ"
```

---

## Makefile Commands

### In the package repository:
- `make generate` — Compile the template example (`template/main.pdf`).
- `make watch` — Watch mode with change detection (`dev="true"`).
- `make thumbnail` — Regenerate the package preview thumbnail (`thumbnail.png`).
- `make test-init` — Run automated end-to-end initialization test in `/tmp`.
- `make queryrefs` — Check for unresolved citations or missing references.
- `make querychaplen` — Query page counts per chapter.
- `make install-local` — Link package to Typst local packages directory.
- `make uninstall-local` — Remove local package symlink.
- `make clean` — Remove generated build outputs.

### In the user's initialized project (`template/`):
- `make generate` — Compile `main.pdf`.
- `make watch` — Watch mode with live updates.
- `make queryrefs` — Check document for unresolved citations.
- `make querychaplen` — Check chapter page statistics.
- `make clean` — Remove generated PDF files.

---

## License

MIT License. See [LICENSE](LICENSE) for details.
