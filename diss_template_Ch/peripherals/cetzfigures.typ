#import "@preview/cetz:0.5.0"
#import "../peripherals/myconstants.typ" as CONSTS
#let network_diagram() = {
  set text(font: CONSTS.FIGUREFONT, size: CONSTS.FIGUREFONTSIZE)
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- 0. FIX BOUNDS ---
    // Drastically reduced the vertical bounds to match the new compressed layout
    rect((-5, -2.5), (11, 2.0), stroke: none)

    // --- 1. STYLES ---
    // Reduced node radii to win vertical space
    let node-style = (fill: black, radius: 0.18) 
    let hub-style = (fill: black, radius: 0.18) 
    let link-style = (stroke: (paint: black, thickness: 1.5pt))
    let ray-style = (stroke: (paint: gray, thickness: 1.5pt))
    let label-style = (size: 14pt, weight: "regular")

    // --- 2. LAYERS & TEXT LABELS ---
    // Dotted separator lines (Moved closer together)
    line((-4.0, 0.15), (10.0, 0.15), stroke: (paint: black, dash: "dotted", thickness: 1.5pt))
    line((-4.0, -1.75), (10.0, -1.75), stroke: (paint: black, dash: "dotted", thickness: 1.5pt))

    // Layer Labels (Adjusted Y coordinates)
    content((-4.5, 1.0), anchor: "west")[#text(..label-style)[Backbone/Core]]
    content((-4.5, -0.8), anchor: "west")[#text(..label-style)[Metro]]
    content((-4.5, -2.2), anchor: "west")[#text(..label-style)[Access]]

    // --- 3. NODE COORDINATES ---
    // All Y-coordinates have been compressed to flatten the graph vertically
    let nodes = (
      // -- Backbone/Core (Top Mesh) --
      b1: (0.0, 1.5),    b2: (3.0, 1.6),   b3: (6.0, 1.1),
      b4: (1.0, 0.7),    b5: (3.5, 0.9),   b6: (5.5, 0.5),

      // -- Metro Layer (Ring & Mesh) --
      // Left Ring
      m1: (2.0, -0.2),   m2: (0.0, -0.5),  m3: (4.0, -0.5),
      m4: (1.0, -1.2),   m5: (3.0, -1.2),

      // Right Mesh (Square with diagonals)
      m6: (6.0, -0.4),   m7: (8.0, -0.4),
      m8: (5.3, -1.0),   m9: (8.0, -1.3),
      m10: (9.5, -0.8),

      // -- Access Layer (Hubs) --
      a1: (2.0, -2.2),   a2: (7.0, -2.2)
    )

    // --- 4. DRAW NODES ---
    for (id, pos) in nodes {
      let style = if id.starts-with("a") { hub-style } else { node-style }
      circle(pos, ..style, name: id)
    }

    // --- 5. DRAW CONNECTIONS ---
    let edges = (
      // Backbone Mesh
      ("b1", "b2"), ("b1", "b4"), ("b1", "b5"),
      ("b2", "b3"), ("b2", "b4"), ("b2", "b5"), 
      ("b3", "b5"), ("b3", "b6"),
      ("b4", "b5"), ("b5", "b6"),

      // Inter-layer: Backbone -> Metro
      ("b4", "m1"), // Backbone to Ring top
      ("b6", "m6"), // Backbone to Right Mesh top-left

      // Metro Left: Ring
      ("m1", "m2"), ("m1", "m3"),
      ("m2", "m4"), ("m3", "m5"),
      ("m4", "m5"),

      // Metro Right: Partial Mesh
      ("m6", "m7"), 
      ("m6", "m8"),
      ("m8", "m7"), 
      ("m8", "m9"), 
      ("m8", "m10"),
      ("m7", "m10"),
      ("m9", "m10"),
    )

    for (a, b) in edges {
      line(a, b, ..link-style)
    }

    // --- 6. DRAW ACCESS RAYS (Star Topology) ---
    let draw-rays(center-id, count, length, start-angle: 0deg, end-angle: 360deg) = {
      let spread = end-angle - start-angle
      let step = if count > 1 and spread < 360deg { spread / (count - 1) } else { spread / count }

      for i in range(count) {
        let angle = start-angle + i * step
        line(center-id, (rel: (angle, length)), ..ray-style, name: "ray")
      }
    }

    // Draw rays behind the nodes (layer: -1)
    on-layer(-1, {
      // Shortened ray lengths from 1.1 to 0.7 to save bottom space
      draw-rays("a1", 5, 0.7, start-angle: 200deg, end-angle: 340deg) 
      draw-rays("a2", 7, 0.7, start-angle: 190deg, end-angle: 350deg) 

      // Draw vertical connection lines from Access up to Metro
      line("a1", "m4", ..link-style) 
      line("a2", "m9", ..link-style) 
    })
  })
}

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

    // 2. Prior (Now on the left)
    content((0, 0), [prior], name: "prior", anchor: "west", ..standard-node)
    
    // Place math and text at absolute heights relative to the center of the 'prior' box
    content((rel: (0, text-y), to: "prior"), text("initial parameters", ..text-style), anchor: "base")
    content((rel: (0, math-y), to: "prior"), $p(theta)$, anchor: "base")

    // 3. Multiply Sign
    content((rel: (minor-gap, 0), to: "prior.east"), text(1.2em)[$times$], name: "times", anchor: "west")

    // 4. Likelihood (Now on the right of the multiply sign)
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

#let kpi_code_diagram() = {
  set text(font: CONSTS.FIGUREFONT, size: CONSTS.FIGUREFONTSIZE)
  set par(leading: CONSTS.FIGURELEADING)
  cetz.canvas({
    import cetz.draw: *

    // --- Styles ---
    // let top-text = (size: 1.3em)
    let top-text = ()
    // let bottom-text = (size: 1.1em)
    let bottom-text = ()
    let arrow-style = (mark: (end: ">", fill: black), stroke: 0.8pt + black)
    let gap = 10pt

    // --- 1. Top Row ---
    // Wrapped in a group so we can dynamically find its exact geometric center later
    group(name: "top", {
      content((0, 0), text(..top-text)[model], name: "model", anchor: "west")
      content((rel: (gap, 0), to: "model.east"), text(..top-text)[$-$], name: "d1", anchor: "west")
      content((rel: (gap, 0), to: "d1.east"), text(..top-text)[domain], name: "domain", anchor: "west")
      content((rel: (gap, 0), to: "domain.east"), text(..top-text)[$-$], name: "d2", anchor: "west")
      content((rel: (gap, 0), to: "d2.east"), text(..top-text)[metric type], name: "kpi", anchor: "west")
    })

    // --- 2. Bottom Row Content & Text Alignment ---
    let b1-content = text(..bottom-text, align(left)[
      *BL*: baseline  \
      *BY*: Bayesian  \
      *RW*: relative win 
    ])
    
    let b2-content = text(..bottom-text, align(left)[
      *ID:* internal domain  \
      *CD:* cross domain 
    ])

    // --- 3. Bottom Row Positioning ---
    let y-drop = -30pt
    let spread = 170pt // Adjusted outward spread for two blocks
    
    // Amount to shift the top row to the right relative to the bottom row
    let top-shift = -100pt 

    // NEW: Amount to shift the entire bottom row left (negative) or right (positive)
    let bottom-shift = -83pt 

    // Position b1 (under model) and b2 (under domain)
    // We add + bottom-shift to the relative X calculation to move both blocks uniformly
    content((rel: (-spread - top-shift + bottom-shift, y-drop), to: "top.center"), b1-content, name: "b1", anchor: "north-west")
    content((rel: (-top-shift + bottom-shift, y-drop), to: "top.center"), b2-content, name: "b2", anchor: "north")

    // --- 4. Arrows ---
    // Added a -4pt relative drop to the starting points to create breathing room below the top words
    line((rel: (0, -4pt), to: "top.model.south"), (rel: (0, 4pt), to: "b1.north"), ..arrow-style)
    line((rel: (0, -4pt), to: "top.domain.south"), (rel: (0, 4pt), to: "b2.north"), ..arrow-style)
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
    let label-gap = 6pt // NEW: Controls the distance of the bold labels from the boxes

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
    // (Pushed slightly higher to 25pt so it completely clears the new likelihood label)
    // content((rel: (0, 25pt), to: "inference.north"), [$y := cases(s "succeeded", f "failed")$], name: "data", anchor: "south", ..standard-node)
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
