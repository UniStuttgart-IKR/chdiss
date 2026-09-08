#import "/peripherals/myconstants.typ" as CONSTS
#import "/peripherals/myfunctions.typ" as FUNCS: kpi, baselineref, inline-terms, todo, fheading, arr, im
#import "@preview/pergamon:0.8.0": cite

#lorem(60)

== Motivation and Problem Statement
#lorem(70)

The rapid growth of @ipoptical networks and @multidomain environments introduces complex management challenges.
As established in earlier studies #cite("vasseur-2004"), traditional deterministic heuristics struggle in information-scarce scenarios.
Recent paradigms such as @ibn extending @sdn allow operators to express high-level intents.
Our previous work #cite("2022Christou") and #cite("christou-2023-mindful") laid foundational steps for decentralized intent management.

#FUNCS.todo([Optional: Add a brief overview of specific domain requirements here.])

#FUNCS.fheading([Core Architectural Assumptions])
#FUNCS.inline-terms(
  style: "bold",
  ([Confidentiality], [Domains do not disclose internal topology or operational telemetry.]),
  ([Coordination], [Inter-domain intent negotiation proceeds via peer-to-peer interfaces (e.g., Domain A #FUNCS.arr Domain B).]),
  ([Stochasticity], [Link failures follow stochastic processes with unknown parameters #im($theta$).])
)

#figure(
  image("../../figures/inkscape/contr_hyperlinks.pdf", width: 75%),
  caption: [Overview of multi-domain connectivity and intent orchestration.],
) <fig_network_overview>

== Research Objectives
#lorem(50)

In this thesis, we address these challenges by formulating a probabilistic framework to estimate @availability and enhance @grooming efficiency.
We model physical characteristics such as link length @sle and shape parameters @sar, incorporating @mcmc sampling for robust inference.
Key performance indicators, notably #kpi("BL", "ID", "path-rmse"), are thoroughly analyzed.

The remainder of this thesis is organized as follows:
@sec_groundrelatedwork provides theoretical background and literature review.
@sec_contribution presents the proposed methodology and model formulations.
@sec_evaluation details the empirical evaluation and performance comparisons.
@sec_exodos concludes the thesis with discussion and outlook.
Supplementary materials are compiled in @seca_all.
