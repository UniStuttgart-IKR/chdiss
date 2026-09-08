#import "../../peripherals/cetzfigures.typ" as CETZFIGS
#import "../../peripherals/myfunctions.typ" as FUNCS: r, kpi, rkpi, ffont, eqref, wr, im, todo, htmlplace, baselineref, myqty, lorempages, callout
#import "../../peripherals/myconstants.typ" as CONSTS

This chapter presents the empirical evaluation and benchmarking of our proposed mechanism.
We evaluate availability prediction accuracy, algorithm execution runtime, and operational metrics across synthetic and realistic network topologies.

== Simulation Settings and Performance Metrics <sec_simulationsettings>
#lorem(45)

We conduct extensive event-driven simulations under varied topological conditions.
Key simulation settings are summarized in @tab_simulationparameters.

#htmlplace(top+center, [
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
      [Topology], [TP <TP>], [Germany-France (GF), Abilene-Canada (AC)],
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

#FUNCS.callout(
  title: "Simulation Benchmark",
  [All scenarios are executed on an isolated multi-core workstation. Path computation timeout is set to #myqty(500, "ms").]
)

=== Metric Taxonomy
The performance evaluation focuses on the following key metrics:
#list(
  [*BL* <KPI_BL>: Baseline model. Calculates availability based on empirical @experiencedavailability, representing common industry practice.],
  [*BY* <KPI_BY>: Bayesian model. Proposed hierarchical Bayesian models.],
  [*RW* <KPI_RW>: Relative win metric ($"BY" - "BL"$).],
  [*ID* <KPI_ID>: Internal domain. Refers to metrics evaluated exclusively within the internal, operator-controlled network.],
  [*CD* <KPI_CD>: Cross domain. Refers to metrics evaluated on connections that traverse both the internal domain and the external domain.],
  [*path-rmse* <KPI_PATH-RMSE>: Root-mean-square error of end-to-end path availability.],
  [*path-std* <KPI_PATH-STD>: Standard deviation of path availability estimates.],
  [*estimation-accuracy* <KPI_ESTIMATION-ACCURACY>: Proportion of accurate link classifications.],
  [*underfulfillment* <KPI_UNDERFULFILLMENT>: Rate of service instances falling below target @sla.],
  [*@sla violation* <KPI_SLA-VIOLATION>: Cumulative duration of availability underfulfillment.]
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
      import "/3rdparty/typst-algorithmic/algorithmic.typ": *
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
  caption: [DiscoverHyperlinks. Calculates hyperlinks of an external domain.],
  kind: "algorithm",
) <alg_hyperlinks>

@alg_hyperlinks specifies the hyperlink discovery algorithm used for cross-domain tomography.
Numerical results demonstrate that Bayesian inference consistently outperforms the #baselineref() heuristic in both #kpi("ID") and #kpi("CD") scenarios.
As shown by #kpi("RW", "ID", "path-rmse"), estimation error decreases by up to #myqty(40, "%") under scarce telemetry data.

#FUNCS.table-figure(
  caption: [Performance comparison between baseline and Bayesian models using the `table-figure` helper function.],
  columns: (2fr, 1fr, 1fr, 1.2fr),
  align: (left + horizon, center + horizon, center + horizon, center + horizon),
  header: ([*Evaluation Metric*], [*Baseline (BL)*], [*Bayesian (BY)*], [*Relative Gain*]),
  [Intra-Domain RMSE], [0.082], [0.049], [-40.2 %],
  [Cross-Domain RMSE], [0.115], [0.086], [-25.2 %],
  [SLA Violations / Year], [14.2], [4.1], [-71.1 %],
) <tab_benchmark_summary>

@tab_benchmark_summary highlights the key accuracy improvements achieved across all network topologies.

#FUNCS.lorempages(0.25)

