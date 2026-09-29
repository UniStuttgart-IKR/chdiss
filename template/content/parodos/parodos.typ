#import "@local/chdiss:0.1.0": *
#import "@preview/pergamon:0.8.0": cite

#lorem(60)

== Motivation and Problem Statement
#lorem(70)

#lorem(35) #cite("vasseur-2004"). #lorem(25) #cite("doe-2022") and #cite("doe-2023").

#FUNCS.todo([Optional: Add a brief overview of specific domain requirements here.])

#FUNCS.fheading([Core Architectural Assumptions])
#FUNCS.inline-terms(
  style: "bold",
  ([Confidentiality], [#lorem(12)]),
  ([Coordination], [#lorem(12) (e.g., Domain A #FUNCS.arr Domain B).]),
  ([Stochasticity], [#lorem(12) #im($theta$).])
)

#figure(
  image("../../figures/inkscape/contr_hyperlinks.pdf", width: 75%),
  caption: [Overview of system architecture and network topology.],
) <fig_network_overview>

== Research Objectives
#lorem(50)

#lorem(35) @ipoptical, @zerodisclosure, @sle, @sar, @mcmc. #lorem(20) #kpi("BL", "ID", "path-rmse").

The remainder of this thesis is organized as follows:
@sec_groundrelatedwork provides theoretical background and literature review.
@sec_contribution presents the proposed methodology and model formulations.
@sec_evaluation details the empirical evaluation and performance comparisons.
@sec_exodos concludes the thesis with discussion and outlook.
Supplementary materials are compiled in @seca_all.
