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

  // Typography & Layout Configuration (optional overrides; defaults shown)
  // font_text: "DejaVu Serif",
  // font_size: 13pt,
  // font_prog: "New Computer Modern",
  // font_header: "Latin Modern Sans",
  // font_headings: "Latin Modern Sans",
  // font_figure: "Latin Modern Sans",
  // font_algo: "TeX Gyre Heros",
  // font_chapternumber: ("Liberation Sans", "Roboto"),
  // par_leading: 0.975em,
  // par_spacing: 1.2em,
  // figure_vspace: 1.1em,
  // figure_vclearance: 0.975em,
  // caption_leading: 0.6em,
  // header_font_size: 13pt,
  // figure_font_size: 13pt,
  // algo_font_size: 12.0pt,
  // chapter_font_size: 150pt,
  // chapter_font_color: gray,
  // header_abstain_from_page: 1cm,
  // appendix_numbering: "A.1",
  // constants: (:), // Or pass dictionary of CONSTS overrides: (TEXTFONT: "...", myleading: ...)

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
