#import "@local/chdiss:0.1.0": *

#heading([Supplementary Mathematical Derivations], level: 2, numbering: CONSTS.APPENDIXNUMBERING, outlined: true) <seca_derivations>

#lorem(50)

In this section, we derive the asymptotic variance for the hierarchical prior specifications.
Consider a continuous Gaussian likelihood with parameters #im($(mu, sigma)$):

$ f(x | mu, sigma) = frac(1, sigma sqrt(2 pi)) exp lr(- frac((x - mu)^2, 2 sigma^2)) $ <eq_app_gaussian>

Equation #eqref(<eq_app_gaussian>) defines the distribution used for noise addition.
#lorem(40)

#heading([Supplementary Figures and Algorithms], level: 2, numbering: CONSTS.APPENDIXNUMBERING, outlined: true) <seca_supplementary>

#lorem(35)

#figure(
  image("../../figures/inkscape/contr_hyperlinks.pdf", width: 65%),
  caption: [Supplementary multi-domain interconnection diagram in appendix.],
) <fig_app_hyperlinks>

@fig_app_hyperlinks illustrates the physical fiber routing of external border links.
Furthermore, @alg_app_priority formalizes the secondary path prioritization heuristic.

#figure(
  FUNCS.algo-block(
    refer: "PrioritizePaths",
    inputs: (
      ([$P$], [Candidate paths set]),
    ),
    output: ([$P^*$], [Prioritized path sequence]),
    {
      import algorithmic: *
      FUNCS.CleanProcedure(smallcaps[PrioritizePaths], {
        Assign[$P^*$][sort $P$ descending by availability]
        Return([$P^*$])
      })
    }
  ),
  caption: [Supplementary path prioritization algorithm.],
  kind: "algorithm",
) <alg_app_priority>

#lorem(30)
