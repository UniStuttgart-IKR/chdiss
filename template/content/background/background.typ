#import "@local/chdiss:0.1.0": *

This chapter reviews foundational principles and literature relevant to this thesis.
We introduce core networking paradigms, describe availability-aware routing, and formulate the statistical foundations of Bayesian modeling.

== Foundations of Multi-Domain Networking <sec_ipoptical>
#lorem(60)

Multi-domain networks require coordinated control across @ipoptical layers.
With the introduction of @sdn, control planes decouple from forwarding devices, offering enhanced programmability.
Operators configure optical transceivers such as @bvt to adjust bandwidth dynamically.
In contrast to deterministic heuristics, often denoted as the #baselineref() <sec_baselineintegration> approach, stochastic estimation offers superior robustness against telemetry fluctuations.
We denote physical properties in #ffont("sans-serif figure font") and software components using #pfont("TypewriterFont").

== Bayesian Modeling and Inference <sec_bayes>
#lorem(50)

Bayesian statistics models uncertainty directly by treating parameters #im($theta$) as random variables.
Given prior domain beliefs #im($p(theta)$) and observed data #im($y$), Bayes' theorem updates the distribution:

$ p(theta | y) = frac(p(y | theta) med p(theta), p(y)) $ <eq_bayesrule>

As shown in #wr(<eq_bayesrule>) (referenced via #eqref(<eq_bayesrule>)), the posterior distribution #im($p(theta | y)$) balances empirical evidence with prior knowledge.
@fig_bayes_inference depicts the three stages of Bayesian analysis.

#figure(
  CETZFIGS.bayes_diagram(),
  caption: [Flow diagram of Bayesian inference pipeline.],
) <fig_bayes_inference>

=== Conjugate Beta-Binomial Model
#lorem(40)

To illustrate the mechanics, consider binary success-failure network events.
Pairing a Beta prior with a Binomial likelihood yields a conjugate model, illustrated in @fig_bayes_example.

#figure(
  CETZFIGS.bayes_diagram_example(),
  caption: [Beta-Binomial Bayesian conjugate model with CeTZ.],
) <fig_bayes_example>

#counter(figure.where(kind: "subfigure")).update(0)
#figure(
  table(
    columns: (1fr, 1fr),
    column-gutter: 0.5em,
    align: horizon,
    stroke: none,
    [#figure(
      image("../../figures/allflatsimfigs/bayesianexample1.pdf"),
      caption: [Prior, likelihood, and posterior distributions],
      kind: "subfigure",
      supplement: none,
      numbering: "a",
      outlined: false,
    ) <fig_bayesianex1>],
    [#figure(
      image("../../figures/allflatsimfigs/bayesianexample2.pdf"),
      caption: [Prior and posterior predictive distributions],
      kind: "subfigure",
      supplement: none,
      numbering: "a",
      outlined: false,
    ) <fig_bayesianex2>],
  ),
  caption: [Two-column subfigure example: Bayesian inference in the Beta-Binomial model.],
  kind: image,
) <fig_bayesianex>

@fig_bayesianex1 and @fig_bayesianex2 show how the posterior distribution narrows as additional observations arrive.
In complex scenarios with latent variables, analytical solutions are unavailable, motivating the use of @mcmc algorithms.


