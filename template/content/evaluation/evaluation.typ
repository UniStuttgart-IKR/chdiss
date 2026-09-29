#import "@local/chdiss:0.1.0": *

#lorem(50)

== Simulation Settings and Performance Metrics <sec_simulationsettings>
#lorem(45)

#lorem(30) @tbl:tab_simulationparameters.

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

#lorem(25) @alg_hyperlinks. #lorem(20) #baselineref() #rkpi("M1") and #rkpi("M2").
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

#FUNCS.lorempages(0.25)
