#import "@preview/cetz:0.5.0"
#import "@local/chdiss:0.1.0": CONSTS

#let bayes_diagram() = {
  set text(font: CONSTS.FIGUREFONT, size: CONSTS.FIGUREFONTSIZE)
  set par(leading: CONSTS.FIGURELEADING)
  cetz.canvas({
    import cetz.draw: *

    // 1. Professional styles
    let standard-node = (
      frame: "rect",
      stroke: 1pt + black,
      radius: 3pt,
      padding: (x: 8pt, y: 6pt) 
    )
    
    let process-node = (
      frame: "rect",
      stroke: 0pt,
      radius: 3pt,
      padding: (x: 10pt, y: 8pt)
    )
    
    let arrow-style = (mark: (end: ">", fill: black))

    // --- Uniform Spacing & Alignment Heights ---
    let major-gap = 20pt
    let minor-gap = 15pt
    
    // Fixed vertical distances from the center of the boxes
    let text-y = 20pt  // Baseline coordinate for the bold labels
    let math-y = 37pt  // Baseline coordinate for the math terms
    let text-style = (size: 0.85em, weight: "bold")

    // 2. Prior
    content((0, 0), [prior], name: "prior", anchor: "west", ..standard-node)
    
    content((rel: (0, text-y), to: "prior"), text("initial parameters", ..text-style), anchor: "base")
    content((rel: (0, math-y), to: "prior"), $p(theta)$, anchor: "base")

    // 3. Multiply Sign
    content((rel: (minor-gap, 0), to: "prior.east"), text(1.2em)[$times$], name: "times", anchor: "west")

    // 4. Likelihood
    content((rel: (minor-gap, 0), to: "times.east"), [likelihood], name: "likelihood", anchor: "west", ..standard-node)
    
    content((rel: (0, text-y), to: "likelihood"), text("data model", ..text-style), anchor: "base")
    content((rel: (0, math-y), to: "likelihood"), $p(y | theta)$, anchor: "base")

    // 5. Bayesian Inference
    content(
      (rel: (major-gap, 0), to: "likelihood.east"), 
      text(1.05em)[Bayesian inference], 
      name: "inference", 
      anchor: "west", 
      ..process-node
    )

    // 6. Data Input (with 'y' term above it)
    content((rel: (0, 20pt), to: "inference.north"), [data], name: "data", anchor: "south", ..standard-node)
    content((rel: (0, 6pt), to: "data.north"), align(center)[$y$], anchor: "south")

    // 7. Posterior
    content((rel: (major-gap, 0), to: "inference.east"), [posterior], name: "posterior", anchor: "west", ..standard-node)
    
    content((rel: (0, text-y), to: "posterior"), text("final parameters", ..text-style), anchor: "base")
    content((rel: (0, math-y), to: "posterior"), $p(theta | y)$, anchor: "base")

    // 8. Connect the nodes
    line("likelihood.east", "inference.west", ..arrow-style)
    line("data.south", "inference.north", ..arrow-style)
    line("inference.east", "posterior.west", ..arrow-style)
  })
}

#let bayes_diagram_example() = {
  set text(font: CONSTS.FIGUREFONT, size: CONSTS.FIGUREFONTSIZE)
  set par(leading: CONSTS.FIGURELEADING)
  cetz.canvas({
    import cetz.draw: *

    let standard-node = (
      frame: "rect",
      stroke: 1pt + black,
      padding: (top: 8pt, bottom: 4pt, left: 6pt, right: 6pt) 
    )

    let arrow-style = (mark: (end: ">", fill: black))
    let node-style = (padding: 2pt) 

    // --- Tuned Spacing ---
    let major-gap = 20pt     
    let minor-gap = 5pt      
    let vertical-gap = 25pt  
    let label-gap = 6pt

    // 1. Prior Equation & Label
    content((0, 0), $theta tilde "Beta"(alpha, beta)$, name: "prior", anchor: "west", ..standard-node)
    content((rel: (0, label-gap), to: "prior.north"), [*prior*], anchor: "south")

    // 2. Multiply Sign 
    content((rel: (minor-gap, 0), to: "prior.east"), text(1.2em)[$times$], name: "times", anchor: "west")

    // 3. Likelihood Equation & Label
    content((rel: (minor-gap, 0), to: "times.east"), $y | theta tilde "Binomial"(N, theta)$, name: "likelihood", anchor: "west", ..standard-node)
    content((rel: (0, label-gap), to: "likelihood.north"), [*likelihood*], anchor: "south")

    // 4. Inference Node 
    content(
      (rel: (major-gap, 0), to: "likelihood.east"), 
      [Bayesian inference], 
      name: "inference", 
      anchor: "west",
      ..node-style
    )

    // 5. Data Explanation & Label
    content((rel: (0, 25pt), to: "inference.north"), $y = display(cases(s "succeeded", f "failed"))med,med s+f = N$, name: "data", anchor: "south", ..standard-node)
    content((rel: (label-gap, 0), to: "data.east"), [*data*], anchor: "west")

    // 6. Posterior Equation & Label
    content((rel: (0, -vertical-gap), to: "inference.south"), $theta | y tilde "Beta"(alpha+s, beta+f)$, name: "posterior", anchor: "north", ..standard-node)
    content((rel: (-label-gap, 0), to: "posterior.west"), [*posterior*], anchor: "east")

    // 7. Connect the nodes with arrows
    line("likelihood.east", "inference.west", ..arrow-style)
    line("data.south", "inference.north", ..arrow-style)
    
    // 8. Vertical arrow pointing down to the posterior
    line("inference.south", "posterior.north", ..arrow-style)
  })
}
