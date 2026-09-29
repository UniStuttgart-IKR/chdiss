#import "@local/chdiss:0.1.0": *

#show: chdiss.with(
  // Document & Author Metadata
  title: [Availability-Aware Multi-Domain Intent-Driven \ IP-Optical Networking Using Bayesian Modeling],
  author: "Filippos Christou",
  birthplace: "Larissa, Griechenland",
  first_examiner: "Prof. Dr.-Ing. Andreas Kirstädter",
  second_examiner: "Prof.’in Dr.-Ing. Carmen Mas Machuca",
  faculty: "Fakultät für Informatik, Elektrotechnik und Informationstechnik",
  university: "Universität Stuttgart",
  degree: "Doktor-Ingenieurs (Dr.-Ing.)",
  institute: [Institut für Kommunikationsnetze und Rechnersysteme\ der Universität Stuttgart],
  submission_date: "19. Juni 2026",
  defense_date: none,
  year: "2026",
  version: none,

  // Bibliography filter: differentiates "Author's Publications" from general "References"
  own_bib_keyword: "own",

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
#include("content/parodos/parodos.typ")

= Background and Related Work <sec_groundrelatedwork>
#include("content/background/background.typ")

= Methodology and Modeling <sec_contribution>
#include("content/contribution/contribution.typ")

= Evaluation <sec_evaluation>
#include("content/evaluation/evaluation.typ")

= Conclusion <sec_exodos>
#include("content/exodos/exodos.typ")
