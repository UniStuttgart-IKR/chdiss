
#import "peripherals/mytemplate.typ": chdiss
#import "peripherals/myconstants.typ" as CONSTS
#import "peripherals/myfunctions.typ" as FUNCS



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

  // Frontmatter & Backmatter content
  abstract: include(CONSTS.CONTENTDIR + "abstract.typ"),
  dedication: include(CONSTS.CONTENTDIR + "dedication.typ"),
  kurzfassung: include(CONSTS.CONTENTDIR + "kurzfassung.typ"),
  appendix: include(CONSTS.CONTENTDIR + "appendix/appendix.typ")
)

// =============================================================================
// Main Body Chapters
// =============================================================================

= Introduction <sec_intro>
#include(CONSTS.CONTENTDIR + "parodos/parodos.typ")

= Background and Related Work <sec_groundrelatedwork>
#include(CONSTS.CONTENTDIR + "background/background.typ")

= Methodology and Modeling <sec_contribution>
#include(CONSTS.CONTENTDIR + "contribution/contribution.typ")

= Evaluation <sec_evaluation>
#include(CONSTS.CONTENTDIR + "evaluation/evaluation.typ")

= Conclusion <sec_exodos>
#include(CONSTS.CONTENTDIR + "exodos/exodos.typ")


