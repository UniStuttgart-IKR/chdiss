#import "@local/chdiss:0.1.0": *

#lorem(45)

== Foundations and Related Work <sec_ipoptical>
#lorem(60)

#lorem(30) #link(<sec_baselineintegration>)[baseline integration] <sec_baselineintegration>.

#text(fill: navy)[*Functions `#ffont(text)` and `#pfont(text)`:* Font styling helpers that apply the template's designated figure font (#ffont("CONSTS.FIGUREFONT"), Liberation Sans) and programming/code font (#pfont("CONSTS.PROGFONT"), Liberation Mono).]
#lorem(20) #ffont("sans-serif figure font") and #pfont("TypewriterFont").

== Theoretical Framework <sec_bayes>
#lorem(50)

#lorem(30) #im($theta$), #im($p(theta)$), #im($y$):

$ p(theta | y) = frac(p(y | theta) med p(theta), p(y)) $ <eq_bayesrule>

#text(fill: navy)[*Function `#wr(target, fallback: "(1.2)", supplement: auto)`:* A "wrapped reference" helper designed for safe HTML compilation and export. In PDF export it produces normal clickable references with automatic supplements, while in HTML mode it provides robust fallback formatting without breaking references.]

#text(fill: navy)[*Function `#eqref(target)`:* A specialized equation reference wrapper that invokes `#wr(target, supplement: [Equation])`, formatting standardized citations like #eqref(<eq_bayesrule>).]

#lorem(25) #wr(<eq_bayesrule>) (referenced via #eqref(<eq_bayesrule>)).
@fig_bayes_inference depicts the workflow diagram.

#figure(
  CETZFIGS.bayes_diagram(),
  caption: [Flow diagram of the inference pipeline.],
) <fig_bayes_inference>

=== Illustrative Example
#lorem(40)

#lorem(30) @fig_bayes_example.

#figure(
  CETZFIGS.bayes_diagram_example(),
  caption: [Example diagram generated using CeTZ.],
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
  caption: [Two-column subfigure example: parameter distributions under observation.],
  kind: image,
) <fig_bayesianex>

#lorem(35) @fig_bayesianex1 and @fig_bayesianex2. #lorem(25) @mcmc.
