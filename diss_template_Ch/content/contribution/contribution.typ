#import "../../peripherals/myfunctions.typ" as FUNCS: im, todo, r, roitc, rkpi, kpi, wr, htmlplace, subfigures, subfig

This chapter introduces our intent-driven framework and formulates the underlying availability models.
We first detail the lifecycle state machine and then provide the rigorous mathematical specification using our hierarchical Bayesian model.

== Multi-domain Intent Architecture <sec_intentdrivenarchitecture>
#lorem(50)

An intent lifecycle transitions through several states from initialization to successful installation.
A lightpath can be categorized as a #roitc("starting") <oitc_starting> or #roitc("ending") <oitc_ending> segment across administrative boundaries.
@fig_contr_arch_statemachineexample illustrates four distinct phases of the intent state machine using our 2x2 subfigure template helper.

#FUNCS.subfigures(
  columns: (1fr, 1fr),
  gutter: 0.6em,
  caption: [Intent lifecycle state machine transitions using the template subfigures helper.],
  [#FUNCS.subfig(image("../../figures/inkscape/contr_arch_statemachine1.pdf"), caption: [Installed intent]) <fig_statemachine1>],
  [#FUNCS.subfig(image("../../figures/inkscape/contr_arch_statemachine2.pdf"), caption: [Failure signal propagates]) <fig_statemachine2>],
  [#FUNCS.subfig(image("../../figures/inkscape/contr_arch_statemachine3.pdf"), caption: [Partial recompilation]) <fig_statemachine3>],
  [#FUNCS.subfig(image("../../figures/inkscape/contr_arch_statemachine4.pdf"), caption: [Installation signal propagates]) <fig_statemachine4>],
) <fig_contr_arch_statemachineexample>

Referencing specific stages is straightforward, e.g., viewing phase #r("fig_statemachine1") during normal operation.

== Hierarchical Bayesian Model Specification <sec_bayesianmodels>
#lorem(45)

We formulate the system of equations for intra-domain link availability below in #wr(<eq_internal_bayesian_model>).
This complex multi-equation structure is typeset using our custom `gridequations` function, generating aligned relations, horizontal centering, display math, and subequation anchors.

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

As seen in #wr(<eq_ibm_downtimeigam>) and #wr(<eq_ibm_uptimeigam>), downtime and uptime follow hierarchical InverseGamma distributions.
The parameters are linked through link length @sle and scale hyperpriors @sk, @ss.
When evaluating prediction quality, metrics such as #rkpi("path-rmse") or the composite key indicator #kpi("BL", "ID", "path-rmse") demonstrate the precision of the model.
