#import "@local/chdiss:0.1.0": *

#lorem(45)

== Foundations and Related Work <sec_ipoptical>
#lorem(60)

#lorem(30) #link(<sec_baselineintegration>)[baseline integration] <sec_baselineintegration>.

#text(fill: blue)[*Functions `#ffont(text)` and `#pfont(text)`:* Font styling helpers that apply the template's designated figure font (#ffont("CONSTS.FIGUREFONT"), Liberation Sans) and programming/code font (#pfont("CONSTS.PROGFONT"), Liberation Mono).]
#lorem(20) #ffont("sans-serif figure font") and #pfont("TypewriterFont").

== Theoretical Framework <sec_bayes>
#lorem(50)

#lorem(30) #im($theta$), #im($p(theta)$), #im($y$):

$ p(theta | y) = frac(p(y | theta) med p(theta), p(y)) $ <eq_bayesrule>

#text(fill: blue)[*Function `#wr(target, fallback: "(1.2)", supplement: auto)`:* A "wrapped reference" helper designed for safe HTML compilation and export. In PDF export it produces normal clickable references with automatic supplements, while in HTML mode it provides robust fallback formatting without breaking references.]

#text(fill: blue)[*Function `#eqref(target)`:* A specialized equation reference wrapper that invokes `#wr(target, supplement: [Equation])`, formatting standardized citations like #eqref(<eq_bayesrule>).]

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

#lorem(40)

#text(fill: blue)[*Functions `#subfigures(..cells, columns: 2, caption: [...])` and `#subfig(body, caption: [...])`:* Construct multi-column subfigure grids with automatic sub-figure lettering `(a)`, `(b)`, individual sub-captions, and an integrated main figure caption.]

#FUNCS.subfigures(
  columns: (1fr, 1fr),
  gutter: 0.5em,
  caption: [Two-column subfigure example: parameter distributions under observation.],
  [#FUNCS.subfig(
    image("../../figures/allflatsimfigs/bayesianexample1.pdf"),
    caption: [Prior, likelihood, and posterior distributions],
  ) <fig_bayesianex1>],
  [#FUNCS.subfig(
    image("../../figures/allflatsimfigs/bayesianexample2.pdf"),
    caption: [Prior and posterior predictive distributions],
  ) <fig_bayesianex2>],
) <fig_bayesianex>

#lorem(35) @fig_bayesianex1 and @fig_bayesianex2. #lorem(25) @mcmc.
