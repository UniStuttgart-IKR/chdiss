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
│   ├── introduction/
│   │   └── introduction.typ
│   ├── background/
│   │   └── background.typ
│   ├── contribution/
│   │   └── contribution.typ
│   ├── evaluation/
│   │   └── evaluation.typ
│   ├── conclusion/
│   │   └── conclusion.typ
│   └── appendix/
│       └── appendix.typ
├── figures/               # Images, subfigures, and CeTZ diagrams
│   └── cetzfigures.typ
├── helperfiles/           # Metadata, bibliography, and glossaries
│   ├── glossary.yaml      # Definitions for Acronyms, Glossary, Symbols
│   ├── references.bib     # BibTeX references (tagged with keywords)
│   └── details.toml       # Optional metadata configuration
└── scripts/               # Quality assurance and publication scripts
    ├── check_typ_files.py       # Audits chapters for unreferenced glossary/acronym terms
    ├── generate_regexes.py      # Generates regexes from helperfiles/glossary.yaml
    ├── convert2blackNwhite.sh   # Converts main.pdf to grayscale for printing (mainbw.pdf)
    └── regexesthatshouldntexis.txt
```

---

## Basic Usage

In `main.typ`:

```typst
#import "@local/chdiss:0.1.0": *

#show: chdiss.with(
  title: [Doctoral Dissertation Title \ Subtitle or Secondary Title of the Work],
  author: "John Doe",
  birthplace: "Sample City, Sample Country",
  first_examiner: "Prof. Dr.-Ing. Jane Smith",
  second_examiner: "Prof. Dr.-Ing. Alex Johnson",
  faculty: "Fakultät für Informatik, Elektrotechnik und Informationstechnik",
  university: "Universität Stuttgart",
  degree: "Doktor-Ingenieurs (Dr.-Ing.)",
  institute: [Institut für Kommunikationsnetze und Rechnersysteme\ der Universität Stuttgart],
  submission_date: "1. Januar 2026",
  defense_date: none,
  year: "2026",

  // Differentiate "Author's Publications" from general "References"
  own_bib_keyword: "own",

  // Resources
  glossary: yaml("helperfiles/glossary.yaml"),
  bib: read("helperfiles/references.bib"),

  // Frontmatter & Backmatter
  abstract: include("content/abstract.typ"),
  dedication: include("content/dedication.typ"),
  kurzfassung: include("content/kurzfassung.typ"),
  appendix: include("content/appendix/appendix.typ"),
)

= Introduction <sec_intro>
#include("content/introduction/introduction.typ")

= Background and Related Work <sec_groundrelatedwork>
#include("content/background/background.typ")

= Methodology and Modeling <sec_contribution>
#include("content/contribution/contribution.typ")

= Evaluation <sec_evaluation>
#include("content/evaluation/evaluation.typ")

= Conclusion <sec_conclusion>
#include("content/conclusion/conclusion.typ")
```

---

## Template Configuration Reference (`chdiss`)

All arguments to `#show: chdiss.with(...)` are optional unless marked as required, and default to the standard IKR dissertation specifications.

### 1. Cover Page & University Metadata

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `content` | `[Doctoral Dissertation Title ...]` | Full dissertation title and optional subtitle. |
| `author` | `str` | `"John Doe"` | Full author name. |
| `birthplace` | `str` | `"Sample City, Sample Country"` | Author's birthplace (e.g., city and country). |
| `first_examiner` | `str` | `"Prof. Dr.-Ing. Jane Smith"` | Name and title of the primary supervisor (Hauptberichter). |
| `second_examiner` | `str` | `"Prof. Dr.-Ing. Alex Johnson"` | Name and title of the secondary examiner (Mitberichter). |
| `faculty` | `str` | `"Fakultät für Informatik, ..."` | Faculty conferring the doctoral degree. |
| `university` | `str` | `"Universität Stuttgart"` | University name. |
| `degree` | `str` | `"Doktor-Ingenieurs (Dr.-Ing.)"` | Academic degree sought. |
| `institute` | `content` | `[Institut für Kommunikationsnetze ...]` | Institute / department name. |
| `submission_date` | `str` | `"1. Januar 2026"` | Official submission date (Tag der Einreichung). |
| `defense_date` | `str` / `none` | `none` | Examination/defense date (Tag der mündlichen Prüfung). Shows placeholder dashes if `none`. |
| `year` | `str` | `"2026"` | Year printed on the title page. |
| `version` | `str` / `none` | `none` | Draft version string displayed on the cover page when `dev_mode: true` (defaults to `"1.0"`). |

### 2. Frontmatter, Backmatter & Document Body

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `abstract` | `content` | `[]` | English abstract content. |
| `kurzfassung` | `content` | `[]` | German Kurzfassung content. |
| `dedication` | `content` | `[]` | Optional dedication page content. |
| `appendix` | `content` | `[]` | Appendix content placed after the bibliography. |
| `doc` | `content` | *Required* | The document body content (supplied automatically by `#show: chdiss.with(...)`). |

### 3. Bibliography, Glossaries & Automatic Formatting

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `bib` | `str` / `bytes` / `none` | `none` | BibTeX bibliography content string (loaded via `read("helperfiles/references.bib")`). |
| `own_bib_keyword` | `str` | `"own"` | BibTeX keyword used to separate author publications from general literature into two distinct reference lists. |
| `glossary` | `dict` / `str` / `none` | `none` | Glossary / acronym data (loaded via `yaml("helperfiles/glossary.yaml")` or passed as a dictionary). |
| `progterms` | `array` of `str` | `(...)` | List of programming identifiers to automatically style using `font_prog`. |
| `algorithms` | `array` of `str` | `(...)` | List of algorithm names to automatically format in smallcaps and link to their pseudocode blocks. |

### 4. Typography & Font Configuration

Every font family and size can be customized individually or via the `constants` dictionary:

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `font_text` | `str` / `array` | `"DejaVu Serif"` | Primary body text font family. |
| `font_size` | `length` | `13pt` | Base body text font size. |
| `font_prog` | `str` / `array` | `"New Computer Modern"` | Font family for code terms and programming keywords. |
| `font_header` | `str` / `array` | `"Latin Modern Sans"` | Running page header and footer font family. |
| `font_headings` | `str` / `array` | `"Latin Modern Sans"` | Heading font family (chapters, sections, subsections). |
| `font_figure` | `str` / `array` | `"Latin Modern Sans"` | Figure/table caption font family. |
| `font_algo` | `str` / `array` | `"TeX Gyre Heros"` | Font family for algorithm pseudocode blocks. |
| `font_chapternumber` | `str` / `array` | `("Liberation Sans", "Roboto")` | Large decorative background chapter number font. |

### 5. Sizing & Spacing Options

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `header_font_size` | `length` | `13pt` | Running page header font size. |
| `figure_font_size` | `length` | `13pt` | Figure caption font size. |
| `algo_font_size` | `length` | `12.0pt` | Algorithm pseudocode font size. |
| `title_font_size` | `length` | `15pt` | Cover page title font size. |
| `myname_font_size` | `length` | `14pt` | Cover page author name font size. |
| `chapter_font_size` | `length` | `150pt` | Large decorative chapter number font size. |
| `chapter_font_color` | `color` | `gray` | Color of the large decorative chapter number. |
| `par_leading` | `length` | `0.975em` | Line spacing (`leading`) for body paragraphs. |
| `par_spacing` | `length` | `1.2em` | Paragraph block spacing (`spacing`). |
| `figure_vspace` | `length` | `1.1em` | Vertical spacing above and below figures. |
| `figure_vclearance` | `length` | `0.975em` | Floating figure clearance. |
| `caption_leading` | `length` | `0.6em` | Line spacing within figure captions. |
| `header_abstain_from_page` | `length` | `1cm` | Horizontal spacing between page number and title in running headers. |

### 6. Numbering, Diagnostics & Mode Flags

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `appendix_numbering` | `str` | `"A.1"` | Numbering format string for appendix figures, tables, and algorithms. |
| `dev_mode` | `bool` | `sys.inputs.dev == "TRUE"` | Enables draft annotations, missing citation highlights, and length metadata. |
| `dev_color` | `color` | `color.red` | Accent color for draft badges and missing citation warnings. |
| `html_mode` | `bool` | `sys.inputs.htmlmode == "TRUE"` | Switches figure and algorithm links to HTML-compatible inline formats. |
| `constants` | `dict` | `(:)` | Key-value dictionary override for any constant in `src/myconstants.typ` (case-insensitive keys, e.g. `constants: (TEXTFONT: "...", myleading: 1em)`). |

---

## Authoring & Quality Assurance Scripts

The template includes specialized utility scripts in `scripts/` to help maintain document quality and prepare the dissertation for physical submission:

### 1. Glossary & Acronym Auditor (`check_typ_files.py`)

Ensures that all domain acronyms and technical terms in your dissertation chapters (`content/**/*.typ`) are properly referenced through the Glossy package (e.g. `@BGP`, `@DWDM[...]`) rather than written in raw, unlinked plain text.

- **Bulk Audit**:
  ```bash
  make check-terms
  # or: python3 scripts/check_typ_files.py
  ```
  Scans all `.typ` files in `content/`, stripping comments (`//`), math blocks (`$ ... $`), headings, and valid references, then flags any raw matches against `regexesthatshouldntexis.txt`. Results are logged to `scripts/unreferenced_terms_report.txt`.

- **Targeted Custom Regex Search**:
  ```bash
  python3 scripts/check_typ_files.py "(?i)\bmyterm\b"
  ```
  Searches for a specific pattern across all chapters while still ignoring comments, math blocks, and labels. Results are logged to `scripts/custom_search_report.txt`.

### 2. Glossary Regex Pattern Generator (`generate_regexes.py`)

Automatically parses `helperfiles/glossary.yaml` and extracts all acronyms (case-sensitive) and glossary terms/descriptions (case-insensitive) into regex patterns saved in `scripts/regexesthatshouldntexis.txt`.

- **Run command**:
  ```bash
  make update-regexes
  # or: python3 scripts/generate_regexes.py
  ```
- **Configuration options**:
  - `IGNORE_LIST`: Common words you want to exclude from checking (e.g. `'availability'`).
  - `FORBIDDEN_LIST`: Deprecated terms or phrases that must never appear in the dissertation (e.g. `'MTBF'`, `'security'`).

### 3. Print Grayscale Converter (`convert2blackNwhite.sh`)

University libraries and dissertation print shops often require a dedicated grayscale PDF edition for physical printing and archival bookbinding to prevent color artifacting or unwanted halftone banding.

- **Run command**:
  ```bash
  make grayscale
  # or: ./scripts/convert2blackNwhite.sh main.pdf mainbw.pdf
  ```
  Uses Ghostscript (`gs`) to convert `main.pdf` into a true grayscale PDF: `mainbw.pdf`.

---

## Makefile Commands

### In the user's initialized project (`template/` or newly created dissertation):
- `make generate` — Compile `main.pdf`.
- `make watch` — Watch mode with live updates (development mode).
- `make watchnodev` — Watch mode in production mode.
- `make grayscale` — Convert `main.pdf` to grayscale `mainbw.pdf` for physical printing.
- `make check-terms` — Audit chapter files for unreferenced acronyms and glossary terms.
- `make update-regexes` — Regenerate regex pattern database from `helperfiles/glossary.yaml`.
- `make queryrefs` — Check document for unresolved citations or missing references.
- `make querychaplen` — Check chapter page count statistics.
- `make populate` — Compile with filler text.
- `make html` — Compile experimental HTML version.
- `make clean` — Remove generated PDF and HTML files.

### In the package repository (maintainer commands):
- `make install-local` — Link package to Typst local packages directory (`~/.local/share/typst/packages/local/chdiss/0.1.0`).
- `make uninstall-local` — Remove local package symlink.
- `make install-fonts` — Install bundled fonts into `~/.local/share/fonts/chdiss`.
- `make test-init` — Run automated end-to-end initialization test in `/tmp`.
- `make thumbnail` — Regenerate the package preview thumbnail (`thumbnail.png`).
- All document and script targets above are also forwarded directly to the template.

---

## License

MIT License. See [LICENSE](LICENSE) for details.
