#import "myconstants.typ" as CONSTS
#import "../3rdparty/typst-algorithmic/algorithmic.typ" as algorithmic
#import algorithmic: algorithm, Comment, LineComment
#import "@preview/i-figured:0.2.4"

#let myoddpagebreak() = {
  state("content.switch").update(false)
  pagebreak(weak: true, to: "odd")
  state("content.switch").update(true)
}
// populate
// Element function for sequences
#let sequence = [].func()

// Convert content to an array of its children
#let to-children(cnt) = {
  let inner(content) = {
    if type(content) in (str, symbol) {
      str(content).clusters().map(char => [#char])
    } else if content.func() == sequence {
      content.children.map(inner)
    } else if content.func() == text {
      inner(content.text)
    } else if content.func() == math.equation {
      inner(content.body)
    } else {
      (content,)
    }
  }
  return inner(cnt).flatten()
}

#let defaultnumbering(num) = {
  if num.numbering == none {
    "1"
  } else {
    num.numbering
  }
}

#let get-first-page-link(entry-label) = {
  let children = to-children(entry-label)
  let key = none
  for child in children {
    if child.func() == metadata {
      key = child.value
      break
    }
  }

  if key != none {
    let term-label = label("__gloss:" + key)
    let occurrences = query(term-label)
    if occurrences.len() > 0 {
      let loc = occurrences.first().location()
      let p-num = numbering(
        if loc.page-numbering() != none { loc.page-numbering() } else { "1" },
        ..counter(page).at(loc)
      )
      link(loc, p-num)
    }
  }
}

#let get-first-sentence(c) = {
  if type(c) == str {
    let idx = c.position(".")
    if idx != none {
      // Slices off the period and trims any trailing spaces
      return (c.slice(0, idx).trim(), true)
    } else {
      return (c, false)
    }
  } else if type(c) == content {
    if c.func() == math.equation {
      return (c, false)
    }
    if c.has("text") {
      return get-first-sentence(c.text)
    } else if c.has("children") {
      let new-children = ()
      let found = false
      for child in c.children {
        let (ch, f) = get-first-sentence(child)
        new-children.push(ch)
        if f {
          found = true
          break
        }
      }
      return (new-children.join(), found)
    } else if c.has("body") {
      let (b, f) = get-first-sentence(c.body)
      let f-name = repr(c.func())
      if f-name in ("strong", "emph", "underline", "strike") {
        return (c.func()(b), f)
      } else {
        return (b, f)
      }
    }
  }
  return (c, false)
}

#let short-caption-outline-entry(entry) = {
  if entry.element.func() != figure or entry.element.caption == none { 
    return entry 
  }

  let (short-cap, _) = get-first-sentence(entry.element.caption.body)

  let supp = entry.element.supplement
  if supp == auto {
    let kind-str = str(entry.element.kind)
    if "table" in kind-str { supp = [Table] }
    else if "algorithm" in kind-str { supp = [Algorithm] }
    else { supp = [Figure] }
  }

  let num = numbering(entry.element.numbering, ..entry.element.counter.at(entry.element.location()))
  let prefix = if supp != none { [#supp #num] } else { [#num] }
  let fill-style = entry.at("fill", default: repeat[.])

  block(width: 100%)[
    #link(entry.element.location())[
      // 3-Column Grid guarantees the page number is structurally isolated and right-aligned
      #grid(
        columns: (auto, 1fr, auto),
        // First gap is after the prefix, second gap is right before the page number
        column-gutter: (0.65em, 0.25em),
        // Forces the page number to sit on the bottom line if the middle column wraps
        align: (x, y) => if x == 2 { bottom } else { top },
        
        prefix,                                    // Col 1
        [#short-cap #box(width: 1fr, fill-style)], // Col 2
        entry.page()                               // Col 3
      )
    ]
  ]
}

// Your new drop-in replacement
#let myshortoutline(..args) = {
  show outline.entry: short-caption-outline-entry
  i-figured.outline(..args)
}


#let ifiguredoutlineoutlinedfigure() = {
  show outline: set heading(outlined: true)
  // i-figured.outline()
  myshortoutline()
}
#let ifiguredoutlineoutlinedtable() = {
  show outline: set heading(outlined: true)
  // i-figured.outline(target-kind: table, title: [List of Tables])
  myshortoutline(target-kind: table, title: [List of Tables])
}
#let ifiguredoutlineoutlinedalgorithm() = {
  show outline: set heading(outlined: true)
  // i-figured.outline(target-kind: "algorithm", title: [List of Algorithms])
  myshortoutline(target-kind: "algorithm", title: [List of Algorithms])
}

#let my-acronym-theme = (
  // Main glossary section
  section: (title, body) => {
    heading(level: 1, numbering: none, title)
    body
  },

  // Group of related terms
  group: (name, index, total, body) => {
    // index = group index, total = total groups
    if name != "" and total > 1 {
      heading(level: 2, name)
    }
    body
  },

  // Individual glossary entry
  entry: (entry, index, total) => {
    // index = entry index, total = total entries in group
    let term = [#entry.short#entry.label :]
    let desc = []
    if entry.long != none {
      desc = [#entry.long]
    }
    if entry.description != none {
      if desc != [] { desc = [#desc: ] }
      desc = [#desc#entry.description]
    }
    let page = get-first-page-link(entry.label)
    
    block(
      grid(
        columns: (auto, 1fr, auto),
        gutter: 5pt,
        term,
        [#desc #box(width: 1fr, repeat([.],gap:0.1em))],
        align(bottom, page)
      )
    )
  }
)

#let my-symbol-theme = (
  // Main glossary section
  section: (title, body) => {
    heading(level: 1, numbering: none, title)
    body
  },

  // Group of related terms
  group: (name, index, total, body) => {
    // index = group index, total = total groups
    if name != "" and total > 1 {
      heading(level: 2, name)
    }
    body
  },

  // Individual glossary entry
  entry: (entry, index, total) => {
    // index = entry index, total = total entries in group
    let term = [#eval(entry.short, mode:"markup") #entry.label :]
    let desc = if entry.description != none { [#eval(entry.description, mode:"markup")] } else { [] }
    let page = get-first-page-link(entry.label)

    block(
      grid(
        columns: (auto, 1fr, auto),
        gutter: 5pt,
        term,
        [#desc #box(width: 1fr, repeat([.],gap:0.1em))],
        align(bottom, page)
      )
    )
  }
)

#let my-glossary-theme = (
  // Main glossary section
  section: (title, body) => {
    heading(level: 1, numbering: none, title)
    body
  },

  // Group of related terms
  group: (name, index, total, body) => {
    // index = group index, total = total groups
    if name != "" and total > 1 {
      heading(level: 2, name)
    }
    body
  },

  // Individual glossary entry
  entry: (entry, index, total) => {
    // index = entry index, total = total entries in group
    let term = [#eval(entry.short, mode:"markup") #entry.label]
    let page = get-first-page-link(entry.label)
    let desc = []
    if entry.long != none {
      desc = [#entry.long]
    }
    if entry.description != none {
      if desc != [] { desc = [#desc: ] }
      desc = [: #desc#eval(entry.description, mode:"markup")]
    }
    
    block(
      grid(
        columns: (auto, 1fr, auto),
        gutter: 5pt,
        term,
        [#desc #box(width: 1fr, repeat([.],gap:0.1em))],
        align(bottom, page)
      )
    )
  }
)

#let lorempages(pages) = {
  lorem(calc.floor(370 * pages))
}

#let todo(body) = {
  text(fill: red.darken(40%), body)
}

#let FadedComment(body) = Comment(text(size: 0.9em, fill: luma(130))[#body])
#let FadedLineComment(code, body) = LineComment(code, text(size: 0.9em, fill: luma(140))[#body])

// 1. Create a native custom block that skips the arguments
// Natively mimics the iflike-terminated AST without the call() parentheses
#let CleanProcedure(name, ..body) = (
  (strong("procedure") + " " + name),
  (change-indent: 2, body: body.pos()),
)

#let algo-block(
  title: [*Context*],
  refer: none,
  inputs: (),
  output: (),
  insetin: 0.2em,
  dynum: 0.0em,
  algo-code
) = block(width: 100%, {



  if refer != none {
    align(left)[#title #label("refer_alg_"+refer)]
  } else{
    align(left)[#title]
  }
  
  set par(leading: 0.45em) 
  
  let grid-items = ()
  for (variable, description) in inputs {
    grid-items.push([- #variable #box(width: 1fr, repeat(gap: 0.4em)[.])])
    grid-items.push(description)
  }
  
  pad(left: 1em, top: -0.65em, bottom: -0.65em,
    grid(
      columns: (1fr, 70%), 
      align: (top, left+top), 
      column-gutter: 0.5em,
      row-gutter: 0.65em, 
      ..grid-items
    )
  )
  
  align(left, algorithm(
    inset: insetin,
    vstroke: .5pt + luma(150),
    line-numbers-format: x => move(dy: dynum, text(size: 0.7em, fill: luma(120))[#x:]),
    algo-code
  ))

  if output != () {
    let (symbol, desc) = output
    v(-0.7em) 
    align(left)[*Output*]
    align(left, pad(left: 1em, top: -0.65em)[#symbol : #desc])
  }
})

// #let regular-inline-terms(..items) = {
//   // This rule only applies INSIDE this function
//   show terms.item: it => block[
//     #text(weight: "regular")[#it.term] // Force term to be regular weight
//     #h(0.8em)                          // Your custom gap
//     #it.description                    // The description text
//   ]
//
//   // Invoke the native terms function with the provided items
//   terms(..items)
// }

#let inline-terms(
  style: "bullet",
  separator: [ ], 
  ..items
) = {
  set par(spacing: CONSTS.myleading)
  for item in items.pos() {
    block(width: 100%, breakable: true)[
      #{
        // By using #{ }, we are strictly in Code Mode here. 
        // Blank lines and comments are perfectly safe!
        
        if type(item) == array and item.len() == 2 {
          let (term, desc) = item
          
          if style == "bullet" {
            [#sym.bullet #term#separator#desc]
          } else if style == "bold" {
            [*#term*#separator#desc]
          } else {
            [#term#separator#desc]
          }
        } 
        else {
          if style == "bullet" {
            [#sym.bullet #item]
          } else {
            [#item]
          }
        }
      } // End of Code Mode
    ]
  }
}

// --- New Template Helper Functions ---

#let subfig(body, caption: none) = {
  figure(
    body,
    caption: caption,
    kind: "subfigure",
    supplement: none,
    numbering: "a",
    outlined: false,
  )
}

#let subfigures(
  columns: (1fr, 1fr),
  gutter: 0.5em,
  caption: none,
  ..items
) = figure(
  {
    counter(figure.where(kind: "subfigure")).update(0)
    table(
      columns: columns,
      column-gutter: gutter,
      row-gutter: gutter,
      align: horizon,
      stroke: none,
      ..items.pos()
    )
  },
  caption: caption,
  kind: image,
)

#let table-figure(
  caption: none,
  columns: auto,
  align: auto,
  header: (),
  ..rows
) = {
  figure(
    block[
      #set par(leading: CONSTS.CAPTIONLEADING)
      #set text(font: CONSTS.FIGUREFONT, size: CONSTS.FIGUREFONTSIZE)
      #table(
        columns: columns,
        align: align,
        stroke: none,
        table.hline(y: 0, stroke: 1pt),
        table.hline(y: 1, stroke: 0.5pt),
        if header.len() > 0 { table.header(..header) },
        ..rows.pos(),
        table.hline(stroke: 1pt)
      )
    ],
    caption: caption,
    kind: table
  )
}

#let callout(title: "Note", body, fill: luma(245), stroke: 0.5pt + luma(180)) = {
  rect(
    width: 100%,
    fill: fill,
    stroke: stroke,
    radius: 4pt,
    inset: (x: 1em, y: 0.8em),
    [
      #if title != none [*#title:* ]
      #body
    ]
  )
}


#let gridequations(main-label, ..cells) = block[
  #counter(math.equation).step()
  #counter("subeq").update(0)

  // 1. Drop the main invisible anchor for "Model X.Y"
  #context {
    let h = counter(heading).get()
    let c = if h.len() > 0 { h.first() } else { 1 }
    let e = counter(math.equation).get().first()
    let num-str = numbering("1.1", c, e)
    
    place(hide([
      #figure(
        kind: "bayesian_model", 
        supplement: [Model],    
        numbering: _ => [(#num-str)],
        outlined: false,
        [] 
      )#main-label
    ]))
  }

  // 2. Force display mode
  #show math.equation: math.display

  // 3. Process the cells to intercept labels
  #let processed-cells = cells.pos().map(c => {
    if type(c) == label {
      [
        #counter("subeq").step()
        #context {
          let h = counter(heading).get()
          let ch = if h.len() > 0 { h.first() } else { 1 }
          let eq = counter(math.equation).get().first()
          let sub = counter("subeq").get().first()
          let num-str = numbering("(1.1a)", ch, eq, sub) 
          
          math.equation(num-str)
          place(hide([
            #figure(
              kind: "subequation",
              supplement: none,
              numbering: _ => num-str,
              outlined: false,
              [] 
            )#c
          ]))
        }
      ]
    } else {
      c 
    }
  })
  
  // 4. The SAFE Baseline Strut Hack (No hallucinations this time)
  #let final-cells = processed-cells.chunks(5).map(row => {
    
    // The inner box gives it 1000pt of room so it never word-wraps.
    // The outer box forces it to 0pt width and clips the rest, taking up 0 layout space!
    let strut = box(
      width: 0pt, 
      clip: true, 
      box(
        width: 1000pt, 
        hide($#row.at(0) #row.at(1) #row.at(2) #row.at(3)$)
      )
    )
    
    return (
      [], // The invisible left spring
      [#strut #row.at(0)],
      [#strut #row.at(1)],
      [#strut #row.at(2)],
      [#strut #row.at(3)],
      row.at(4) // The label
    )
  }).flatten()

  // 5. The High-Performance Grid
  #grid(
    columns: (1fr, auto, auto, auto, auto, 1fr),
    align: (right, right, center, left, left, right + horizon),
    row-gutter: 1.5em, 
    
    column-gutter: (0pt, 0.28em, 0.28em, 1.5em, 2em),
    
    ..final-cells
  )
]


#let myqty(
  value,
  unit,
  rawunit: true, // We force rawunit to true so it skips unit parsing!
  space: "#h(0.166667em)",
  multiplier: "dot",
  thousandsep: "#h(0.166667em)",
  per: "symbol",
) = {
  import "../3rdparty/unify/format.typ": _re-num, _format-num
  
  let val = str(value).replace("−", "-").replace(" ", "")
  let match-value = val.match(_re-num)
  assert.ne(match-value, none, message: "invalid number: " + val)
  let captures-value = match-value.captures

  let upper = none
  let lower = none
  if captures-value.at(14) != none {
    upper = captures-value.at(14)
    lower = none
  } else {
    upper = captures-value.at(5)
    lower = captures-value.at(7)
  }

  let formatted-value = _format-num(
    captures-value.at(0),
    exponent: captures-value.at(18),
    upper: upper,
    lower: lower,
    multiplier: multiplier,
    thousandsep: thousandsep,
  )

  let formatted-unit = space + " upright(\"" + str(unit) + "\")"
  let formatted = "$" + formatted-value + formatted-unit + "$"
  eval(formatted)
}

#let ffont(x) = text(font:CONSTS.FIGUREFONT,)[#x]
#let pfont(x) = text(font:CONSTS.PROGFONT,)[#x]

#let wr(target, fallback: "(1.2)", supplement: auto) = {
  if CONSTS.HTMLMODE {
    // Return the safe text to avoid compilation errors
    fallback
  } else {
    // Convert strings to labels safely, otherwise use the label directly
    let lbl = if type(target) == str { label(target) } else { target }
    
    // Resolve the real reference
    ref(lbl, supplement: supplement)
  }
}

#let eqref(x) = wr(x, supplement: [Equation])

// The arrow wrapper function
#let arr = {
  if CONSTS.HTMLMODE {
    // In HTML mode, output a plain text arrow (uses Typst's text ligature)
    [->] 
  } else {
    // In PDF mode, output the math-engine arrow
    [$->$] 
  }
}

#let extract-text(it) = {
  if type(it) == str {
    return it
  } else if type(it) == symbol {
    return str(it) 
  } else if type(it) == content {
    
    let fname = repr(it.func())
    if fname == "space" or fname == "h" {
      return " "
    } else if it.has("text") {
      return it.text
    } else if it.has("children") {
      return it.children.map(extract-text).join(" ")
    } else if it.has("body") {
      return extract-text(it.body)
    } else if it.has("base") {
      let base = extract-text(it.base)
      let sub = if it.has("b") { "_" + extract-text(it.b) } else { "" }
      let sup = if it.has("t") { "^" + extract-text(it.t) } else { "" }
      return base + sub + sup
    } else {
      // THE ULTIMATE FALLBACK:
      // If we reach this point, it's a content node with no text or children.
      // It is a layout node or a math spacer (like $thin$ or $quad$).
      // Returning a space keeps the sentence structure intact and prevents the "f(x)" trigger!
      return " "
    }
    
  }
  return ""
}

#let im(eq, alt: none) = {
  if CONSTS.HTMLMODE {
    if alt != none { 
      alt 
    } else { 
      // Run the extractor
      let extracted = extract-text(eq)
      
      // Determine if we need to use the failsafe
      let needs-failsafe = true
      
      if type(extracted) == str {
        // FIXED: Removed .trim()! 
        // Now if extracted is " " (like for $thin$), it won't be treated as empty.
        if extracted != "" {
          needs-failsafe = false
        }
      }
      
      // Deploy the fallback to save the paragraph continuity, or print the text!
      if needs-failsafe {
        "f(x)"
      } else {
        extracted
      }
    }
  } else {
    // In PDF mode, render normally
    eq
  }
}

#let plain-text(it) = {
  if type(it) == str {
    return it
  }
  if type(it) != content {
    return ""
  }
  if it.has("text") {
    return it.text
  }
  if it.has("children") {
    return it.children.map(plain-text).join("")
  }
  if it.has("body") {
    return plain-text(it.body)
  }
  return ""
}

#let fheading(body) = block(
  above: CONSTS.myspacing, 
  below: CONSTS.myleading,
  // above: 1.0em, 
  // below: 0.75em, 
  width: 100%, // Ensures the block spans the full page width so it can push text to the right edge
  // align(right, text(weight: "bold", style: "italic", body))
  text(weight: "bold", body)
)

#let r(target) = link(label(target))[#target]

// Helper function to link a single target to its kpi_<target> label

#let roitc(target) = link(label("oitc_" + str(target)))[#target]

// Variadic function that accepts any number of arguments and joins them
// Helper function to link a single target to its kpi_<target> label
#let rkpi(target) = link(label("KPI_" + upper(str(target))))[#target]

// Powerful variadic function that handles both strings and arrays
#let kpi(..args) = {
  // Define how to process each individual argument
  let process-item(item) = {
    if type(item) == array {
      // If it's an array: map the items, join with commas, and wrap in literal brackets \[ \]
      [\[#item.map(rkpi).join([, ])\]]
    } else {
      // If it's a single item: just apply the link function directly
      rkpi(item)
    }
  }
  
  // Apply the process to all arguments and join the top-level blocks with $-$
  args.pos().map(process-item).join([#im($-$)])
}

#let htmlplace(positionarg, clearance: CONSTS.FIGUREVCLEARANCE, body) = {
  if CONSTS.HTMLMODE {
    body
  } else {
    // If the user passes 'center', we use the inline box trick
    if positionarg == center {
      // 1. box() makes it an inline element (keeps the paragraph intact)
      // 2. width: 100% forces it onto its own line
      // 3. align(center) pushes the figure to the middle of that line
      box(width: 100%, align(center, body))
    } 
    // Otherwise, we float it to the top or bottom as normal
    else if clearance == none {
      place(positionarg, scope: "parent", float: true, body)
    } else {
      place(positionarg, scope: "parent", float: true, clearance: clearance, body)
    }
  }
}

#let baselineref() = {
  link(<sec_baselineintegration>)[baseline]
}

