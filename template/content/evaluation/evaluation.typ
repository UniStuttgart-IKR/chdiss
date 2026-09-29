#import "@local/chdiss:0.1.0": *

#lorem(50)

== Simulation Settings and Performance Metrics <sec_simulationsettings>
#lorem(45)

#text(fill: navy)[*Function `#myqty(val, unit, space: 0.16667em, per: "/", math-mode: true)`:* Typesets numbers with scientific units adhering to typesetting conventions (proper non-breaking thin spaces in math mode), such as #myqty(1, "yr"), #myqty(48, "h"), or #myqty(150, "km").]

#htmlplace(center, [
#figure(
  block[
    #set par(leading: 0.4em) 
    #set text(font: CONSTS.FIGUREFONT, size: CONSTS.FIGUREFONTSIZE)
    
    #table(
      columns: 3,
      align: (left+horizon, center+horizon, left+horizon),
      stroke: none,
      table.hline(y: 0, stroke: 1pt),
      table.hline(y: 1, stroke: 0.5pt),
      table.header(
        [*Setting*], [*Abbr.*], [*Values*]
      ),
      [Topology], [TP <TP>], [Network Alpha, Network Beta],
      [Inter-domain links], [IL <IL>], [3, 6],
      [Simulation horizon], [SH <SH>], [#myqty(1, "yr"), #myqty(5, "yr")],
      [Inter-arrival time], [IAT <IAT>], [#myqty(48, "h"), #myqty(96, "h")],
      [Service duration], [ST <ST>], [#myqty(2160, "h"), #myqty(4320, "h")],
      [Link distance], [LD <LD>], [#myqty(150, "km"), #myqty(600, "km")],
      table.hline(stroke: 1pt)
    )
  ],
  caption: [Simulation benchmark parameters and settings.],
  kind: table,
) <tab_simulationparameters>
])

=== Metric Taxonomy
The performance evaluation uses structured metric definitions demonstrated below:
#list(
  [*M1* <KPI_M1>: #lorem(12)],
  [*M2* <KPI_M2>: #lorem(12)],
  [*M3* <KPI_M3>: #lorem(12)],
  [*M4* <KPI_M4>: #lorem(12)]
)

== Algorithmic Formulations and Numerical Results <sec_eval_results>
#lorem(50)

#text(fill: navy)[*Functions `#algo-block(...)`, `#CleanProcedure(...)`, `#FadedComment(...)`, and `#FadedLineComment(...)`:* An algorithm authoring suite built on top of `typst-algorithmic`. `#algo-block` creates a structured container with listed inputs and outputs; `#CleanProcedure` specifies the procedure signature cleanly; and `#FadedComment` / `#FadedLineComment` format subdued explanatory annotations.]

#figure(
  FUNCS.algo-block(
    refer: "DiscoverHyperlinks",
    inputs: (
      ([$G$], [Multi-domain network graph]),
      ([$C$], [Set of active cross-domain connectivity requests]),
    ),
    output: ([$H$], [Set of resolved hyperlinks]),
    {
      import algorithmic: *
      FUNCS.CleanProcedure(smallcaps[DiscoverHyperlinks], {
        FUNCS.FadedComment([Initialize empty hyperlinks accumulator])
        Assign[$H$][${}$]
        For([$c in C$], {
          FUNCS.FadedLineComment(
            Assign[$h$][new hyperlink for connection $c$],
            [Track observable endpoint states]
          )
          Assign[$H$][$H union {h}$]
        })
        Return([$H$])
      })
    }
  ),
  caption: [DiscoverHyperlinks procedure example.],
  kind: "algorithm",
) <alg_hyperlinks>

#lorem(25) @alg_hyperlinks.

#text(fill: navy)[*Function `#kpi(..args)`:* A variadic metric linking function. Each metric key links directly to its taxonomy definition anchor (`<KPI_...>`). Supplying multiple arguments joins them with optical em-dashes (`—`), while passing an array argument (e.g. `("M3", "M4")`) groups multiple variant metrics in brackets `[M3, M4]`.]

#lorem(20) #kpi("M1") and #kpi("M2").
#lorem(20) #kpi("M1", "M2", "M3") #lorem(15) #myqty(40, "%").
#lorem(20) @fig_eval_subfigures.

#htmlplace(top+center, [
#counter(figure.where(kind: "subfigure")).update(0)
#figure(
  table(
    columns: (1fr, 1fr),
    column-gutter: 0.1em,
    row-gutter: -0.6em,
    align: horizon,
    stroke: none,

    table.cell(
      colspan: 2,
      align: center,
      image("../../figures/allflatsimfigs/triplegend_estimtrue.pdf"),
    ),

    [#figure(
      image("../../figures/allflatsimfigs/mass__SD_ikpi_estim-true.pdf"),
      caption: [#kpi("M1", "M2", "M3")],
      kind: "subfigure",
      supplement: none,
      numbering: "a",
      outlined: false,
    ) <fig_eval_scenario_a>],

    [#figure(
      image("../../figures/allflatsimfigs/mass__MD_ikpi_estim-true.pdf"),
      caption: [#kpi("M1", "M2", "M4")],
      kind: "subfigure",
      supplement: none,
      numbering: "a",
      outlined: false,
    ) <fig_eval_scenario_b>],


  ),
  caption: [#kpi("M1", "M2", ("M3", "M4")).],
  kind: image,
) <fig_eval_subfigures>
])

#text(fill: navy)[*Function `#table-figure(caption: [...], columns: (...), header: (...), ..cells)`:* Generates formal publication tables with standardized horizontal rules (top rule, mid rule below header, bottom rule) and custom column alignments.]

#FUNCS.table-figure(
  caption: [Performance comparison between baseline and proposed models using the `table-figure` helper function.],
  columns: (2fr, 1fr, 1fr, 1.2fr),
  align: (left + horizon, center + horizon, center + horizon, center + horizon),
  header: ([*Evaluation Metric*], [*Baseline (BL)*], [*Proposed (BY)*], [*Relative Gain*]),
  [Metric Alpha], [0.082], [0.049], [-40.2 %],
  [Metric Beta], [0.115], [0.086], [-25.2 %],
  [SLA Violations / Year], [14.2], [4.1], [-71.1 %],
) <tab_benchmark_summary>

#lorem(20) @tbl:tab_benchmark_summary.

#text(fill: navy)[*Function `#lorempages(fraction)`:* Generates Latin placeholder text calibrated to approximately fill a specified fraction of a page (e.g., `#lorempages(0.25)`).]

#FUNCS.lorempages(0.25)
