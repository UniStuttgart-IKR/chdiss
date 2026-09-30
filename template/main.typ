#import "@local/chdiss:0.1.0": *

#show: chdiss.with(
  // Document & Author Metadata
  title: [Doctoral Dissertation Title Doctoral \ Dissertation Title Doctoral Dissertation Title],
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
  version: none,

  // Bibliography filter: differentiates "Author's Publications" from general "References"
  own_bib_keyword: "own",

  // Typography & Font Configuration (optional overrides; defaults shown)
  // font_text: "DejaVu Serif",
  // font_size: 13pt,
  // font_prog: "New Computer Modern",
  // font_header: "Latin Modern Sans",
  // font_headings: "Latin Modern Sans",
  // font_figure: "Latin Modern Sans",
  // font_algo: "TeX Gyre Heros",

  // Bibliography & Glossary resources
  glossary: yaml("helperfiles/glossary.yaml"),
  bib: read("helperfiles/references.bib"),

  // Frontmatter & Backmatter content
  abstract: include("content/abstract.typ"),
  dedication: include("content/dedication.typ"),
  kurzfassung: include("content/kurzfassung.typ"),
  appendix: include("content/appendix/appendix.typ"),
)

// =============================================================================
// Main Body Chapters
// =============================================================================

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
