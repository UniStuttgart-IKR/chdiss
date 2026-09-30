#import "@local/chdiss:0.1.0": *
#import "@preview/pergamon:0.8.0": cite

#lorem(60)

== Motivation and Problem Statement
#lorem(70)

#lorem(35) #cite("vasseur-2004"). #lorem(25) #cite("doe-2022") and #cite("doe-2023").

#text(fill: blue)[*Function `#todo(body)`:* Inserts a colored callout reminder in the text, useful for tracking pending draft items during thesis writing.]

#FUNCS.todo([Optional: Add a brief overview of specific domain requirements here.])

#text(fill: blue)[*Function `#fheading(body)`:* Formats an unnumbered, styled inline heading block with custom spacing to cleanly separate thematic sub-sections without creating clutter in the table of contents.]

#FUNCS.fheading([Core Architectural Assumptions])

#text(fill: blue)[*Function `#inline-terms(..items, style: "bold", delim: ":")`:* Formats a list of `([Term], [Definition])` tuples into a compact, inline list such that it does not indent and save space.]

#text(fill: blue)[*Function `#im(eq, alt: none)`:* Wraps inline math expressions (such as #im($theta$) or directional flows #im($-->$)) to ensure clean rendering across both PDF and HTML exports.]

#FUNCS.inline-terms(
  style: "bold",
  ([Confidentiality], [#lorem(12)]),
  ([Coordination], [#lorem(12) (e.g., Domain A #im($-->$) Domain B).]),
  ([Stochasticity], [#lorem(12) #im($theta$).])
)

#figure(
  image("../../figures/inkscape/contr_hyperlinks.pdf", width: 100%),
  caption: [Overview of system architecture and network topology.],
) <fig_network_overview>

== Research Objectives
#lorem(50)

#lorem(35) @ipoptical, @zerodisclosure, @sle, @sar, @mcmc, @experiencedavailability. #lorem(20)

The remainder of this thesis is organized as follows:
@sec_groundrelatedwork provides theoretical background and literature review.
@sec_contribution presents the proposed methodology and model formulations.
@sec_evaluation details the empirical evaluation and performance comparisons.
@sec_exodos concludes the thesis with discussion and outlook.
Supplementary materials are compiled in @seca_all.
