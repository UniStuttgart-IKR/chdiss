#import "@local/chdiss:0.1.0": *

#heading([Supplementary Mathematical Derivations], level: 2, numbering: CONSTS.APPENDIXNUMBERING, outlined: true) <seca_derivations>

#lorem(50)

#lorem(20) #im($(mu, sigma)$):

$ f(x | mu, sigma) = frac(1, sigma sqrt(2 pi)) exp lr(- frac((x - mu)^2, 2 sigma^2)) $ <eq_app_gaussian>

#lorem(15) #eqref(<eq_app_gaussian>).
#lorem(40)

#heading([Supplementary Figures and Algorithms], level: 2, numbering: CONSTS.APPENDIXNUMBERING, outlined: true) <seca_supplementary>

#lorem(35)

#figure(
  image("../../figures/inkscape/contr_hyperlinks.pdf", width: 100%),
  caption: [Supplementary diagram in appendix.],
) <fig_app_hyperlinks>

#lorem(20) @fig_app_hyperlinks.
#lorem(20) @alg_app_priority.

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
        Assign[$P^*$][sort $P$ descending by metric]
        Return([$P^*$])
      })
    }
  ),
  caption: [Supplementary prioritization algorithm.],
  kind: "algorithm",
) <alg_app_priority>

#lorem(30)
