#import "@local/chdiss:0.1.0": *

#lorem(45)

== System Architecture and Workflow <sec_intentdrivenarchitecture>
#lorem(30) #cite("mckeown-2008") #lorem(20).

#lorem(35)
@fig_contr_arch_statemachineexample illustrates four distinct phases of the state machine using the 2x2 subfigure template helper.

#text(fill: blue)[*Functions `#subfigures(..cells, columns: 2, caption: [...])` and `#subfig(body, caption: [...])`:* Construct multi-column subfigure grids with automatic sub-lettering `(a)`, `(b)`, individual sub-captions, and an integrated main figure caption.]

#FUNCS.subfigures(
  columns: (1fr, 1fr),
  gutter: 0.6em,
  caption: [State machine transitions using the template subfigures helper.],
  [#FUNCS.subfig(image("../../figures/inkscape/contr_arch_statemachine1.pdf"), caption: [Phase 1: Initial state]) <fig_statemachine1>],
  [#FUNCS.subfig(image("../../figures/inkscape/contr_arch_statemachine2.pdf"), caption: [Phase 2: Signal propagation]) <fig_statemachine2>],
  [#FUNCS.subfig(image("../../figures/inkscape/contr_arch_statemachine3.pdf"), caption: [Phase 3: Reconfiguration]) <fig_statemachine3>],
  [#FUNCS.subfig(image("../../figures/inkscape/contr_arch_statemachine4.pdf"), caption: [Phase 4: Final state]) <fig_statemachine4>],
) <fig_contr_arch_statemachineexample>

#lorem(20) @fig_statemachine1 #lorem(15)

== Mathematical Model Specification <sec_bayesianmodels>
#lorem(45)

#text(fill: blue)[*Function `#htmlplace(position, clearance: ..., body)`:* Provides safe placement and floating of figures or tables in PDF export (e.g., `top+center`, `bottom+center`, or `center`) while falling back cleanly to standard inline document flow in HTML mode.]

#text(fill: blue)[*Function `#gridequations(main-label, ..cells)`:* Formats complex mathematical and hierarchical Bayesian models across 5 structured columns: Left-Hand Side (LHS), Relation, Right-Hand Side (RHS), Condition/Domain, and Sub-equation Label. Subequations automatically receive sub-lettered numbers (e.g., (3.1a), (3.1b)) and can be referenced individually.]

#lorem(25) #wr(<eq_internal_bayesian_model>). #lorem(20)

#htmlplace(bottom+center, [
#FUNCS.gridequations(
  <eq_internal_bayesian_model>, // The main model label
  
  // --- Downtimes ---
  $#[@srh]$,   $tilde$, $"InverseGamma"(#[@sar]=1.3, #[@sbr]=1.0)$, [], <eq_ibm_downtimeigam>,
  $d_e$,       $tilde$, $"Exponential"(#[@srh])$,          $forall med d_e in #[@sDpe] quad forall med e in #[@sE]$, <eq_ibm_downtimeexp>,
  $|#[@sDp]|$, $tilde$, $"Poisson" lr((frac(sum #[@sD], #[@srh])))$,  [], <eq_ibm_downtimepoisson>,
  // --- Uptimes ---
  $#[@sfhe]$,   $tilde$, $"InverseGamma"(#[@safe] = 1.5, #[@sbfe])$, $forall med e in #[@sE]$, <eq_ibm_uptimeigam>,
  $u_e$,        $tilde$, $"Exponential"(#[@sfhe])$,           $forall med u_e in #[@sUpe] quad forall med e in #[@sE]$, <eq_ibm_uptimeexp>,
  $|#[@sUpe]|$, $tilde$, $"Poisson" lr((frac(sum #[@sUe], #[@sfhe])))$,   $forall med e in #[@sE]$, <eq_ibm_uptimepoisson>,
  // --- Priors ---
  $#[@sfb] (#[@sle] ; #[@sk], #[@ss], h)$, $=$, $#[@sk] + frac(#[@ss], #[@sle] - h)$, [], <eq_ibm_recipr>, 
  $#[@sk]$,   $tilde$, $"Gamma"(#[@sak]=0.8, #[@sbk]=10.0)$, [], <eq_ibm_prior_k>,
  $#[@ss]$,   $tilde$, $"Gamma"(#[@sas]=2.0, #[@sbs]=300.0)$, [], <eq_ibm_prior_s>,
  $#[@sbfe]$, $=$,     $#[@sfb] (#[@sle] ; #[@sk], #[@ss], h=0) dot (#[@safe] - 1)$, [], <eq_ibm_priorigam>
)
])

#lorem(20) #wr(<eq_ibm_downtimeigam>) and #wr(<eq_ibm_uptimeigam>).
#lorem(20) @sle, @sk, @ss.
#lorem(25)
