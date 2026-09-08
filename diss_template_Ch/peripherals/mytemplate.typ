#import "myfunctions.typ" as FUNCS
#import "myconstants.typ" as CONSTS
#import "coverpage.typ": generatecoverpage

#import "@preview/i-figured:0.2.4"
#import "@preview/pergamon:0.8.0" as pergamon
// #import "@preview/pergamon:0.7.1" as pergamon
#import "/3rdparty/glossy/lib.typ" as glossy

#let chdiss(
  title: [Availability-Aware Multi-Domain Intent-Driven \ IP-Optical Networking Using Bayesian Modeling],
  author: "Filippos Christou",
  birthplace: "Larissa, Griechenland",
  first_examiner: "Prof. Dr.-Ing. Andreas Kirstädter",
  second_examiner: "Prof.’in Dr.-Ing. Carmen Mas Machuca",
  faculty: "Fakultät für Informatik, Elektrotechnik und Informationstechnik",
  university: "Universität Stuttgart",
  degree: "Doktor-Ingenieurs (Dr.-Ing.)",
  institute: [Institut für Kommunikationsnetze und Rechnersysteme\ der Universität Stuttgart],
  submission_date: "19. Juni 2026",
  defense_date: none,
  year: "2026",
  version: none,
  own_bib_keyword: "own",
  progterms: (
    "Turing.jl",
    "MINDFul.jl",
    "MINDFulCompanion.jl",
    "MINDFulTeraFlowSDN.jl",
    "RemoteIntents?",
    "ConnectivityIntents?",
    "LightpathIntents?",
    "ProtectedLightpathIntents?",
    "CrossLightpathIntents?",
    "TransmissionModuleLLIs?",
    "RouterLLIs?",
    "ROADMLLIs?",
    "OpticalTerminateConstraints?",
    "OpticalInitiateConstraints?",
    "AvailabilityConstraints?",
    "SplitLimitConstraints?",
    "NoGroomingConstraints?",
    "UNCOMPILED",
    "COMPILED",
    "INSTALLING",
    "INSTALLED",
    "FAILED",
    "PENDING",
    "Gamma",
    "Beta",
    "Binomial",
    "Normal",
    "Bernoulli",
    "InverseGamma",
    "Erlang",
    "Uniform",
    "Exponential",
    "Poisson",
    "LogNormal",
    "Weibull",
    "Hyperexponential",
  ),
  algorithms: (
    "CrossDomainNodePrior",
    "HyperlinksPrior",
    "DiscoverHyperlinks",
    "IntentCompilation",
    "PrioritizeSplitNodes",
    "PrioritizeAvailabilitySpecifications",
    "PrioritizePaths",
    "LightpathCompilation",
  ),
  abstract: [],
  dedication: [],
  kurzfassung: [],
  appendix: [],
  doc,
) = {

set document(
  title: title,
  author: author,
  date: auto //gets current compilation date
)

set text(
  font: CONSTS.TEXTFONT,
  size: CONSTS.TEXTFONTSIZE,
  spacing: 100%,        // tighter word spacing
  // tracking: -0.00pt,   // subtle letter tightening
  // hyphenate: true,     // breaks words to fill lines better
  // kerning: true,       // optimal character pairing
  // lang: "en"           // correct hyphenation rules
)

  set page(
    paper: "a4",
    margin: (x: 2.0cm, top: 3.0cm, bottom: 2.0cm),
    header-ascent: 0.7cm,
    numbering: none,
    header: context {
    let returntext(direction, content) = {
      return align(direction)[
        #text(font: CONSTS.HEADERFONT, size: CONSTS.HEADERFONTSIZE, content)
      ]
    }
    let chapters = query(
      heading.where(
        level: 1,
      )
    )
    let allheadingscounter = counter(selector(heading))
    let currentpage = counter(page).get()
    let chapterbegins = chapters.any(m =>
      counter(page).at(m.location()) == currentpage
    )
    if currentpage.first() > 1 and not chapterbegins {
    // ignore empty pages
    if state("content.switch", true).get() {
    // align page number right for odd and left for even pages
    if calc.even(currentpage.first()) {
    let lastheading1 = query(selector(heading.where(level:1)).before(here())).last()
    let chaptername = smallcaps(lastheading1.body)
    // let chapternumbering = counter(heading).get().at(0)
    let chapternumbering = numbering(FUNCS.defaultnumbering(lastheading1),  counter(heading).get().at(0))
    if chapternumbering == "0" {
    return returntext(left, [#counter(page).display("1") #h(CONSTS.HEADERABSTAINFROMPAGE) #chaptername])
  } else {
    return returntext(left, [#counter(page).display("1") #h(CONSTS.HEADERABSTAINFROMPAGE) Chapter #chapternumbering #sym.dash #chaptername])
  }
  } else {
    let afterheadings = query(selector(heading).after(here()))
    let lastheading = query(selector(heading).before(here())).last()
    let beforeselectorcounterdisplay = numbering(FUNCS.defaultnumbering(lastheading), ..counter(heading).get())
    let headingtouse = none
    let headingnumbertouse = none
    if afterheadings == () { //if there are no after headings get the last heading
    headingtouse = lastheading
    headingnumbertouse = beforeselectorcounterdisplay
  } else {
    let afterheading1 = afterheadings.first()
    let afterheading1page = afterheading1.location().page-numbering()
    afterheading1page = counter(page).at(afterheading1.location())
    if afterheading1.level != 1 and afterheading1page == currentpage {
    headingtouse = afterheadings.first()
    headingnumbertouse = numbering(headingtouse.numbering, ..counter(heading).at(headingtouse.location()))
  } else {
    headingtouse = lastheading
    headingnumbertouse = beforeselectorcounterdisplay
  }
  }
    let headingname = smallcaps(headingtouse.body)
    if headingtouse.level == 1 {
    return returntext(right, [#counter(page).display("1")])
  } else if headingnumbertouse == "0" {
    return returntext(right, [#headingname #h(CONSTS.HEADERABSTAINFROMPAGE) #counter(page).display("1")])
  } else {
    return returntext(right, [#headingnumbertouse #headingname #h(CONSTS.HEADERABSTAINFROMPAGE) #counter(page).display("1")])
  }
  }
  }

  } 
  }
  )

set par(
  first-line-indent: 1em,
  // leading: CONSTS.myleading,
  // leading: 0.65em * 2,
  leading: CONSTS.myleading,
  spacing: CONSTS.myspacing,
  justify: true,
)

set heading(
  numbering: "1.1",
  supplement: [Section]
)

// set figure(gap: CONSTS.FIGURELEADING)
show figure: set block(above: CONSTS.FIGUREVSPACE, below: CONSTS.FIGUREVSPACE)
show figure: set place(clearance: CONSTS.FIGUREVCLEARANCE)

show figure.caption: c => {
  set par(leading: CONSTS.CAPTIONLEADING)
  text(font: CONSTS.FIGUREFONT, size: CONSTS.FIGUREFONTSIZE, c)
}

// show figure: i-figured.show-figure
show figure.where(kind: image): i-figured.show-figure
show figure.where(kind: table): i-figured.show-figure
show figure.where(kind: raw): i-figured.show-figure
show figure.where(kind: "algorithm"): i-figured.show-figure.with(extra-prefixes: (algorithm: "algo:"))
show figure.where(kind: "algorithm"): set figure(supplement: "Algorithm")
show figure.where(kind: "algorithm"): set text(font: CONSTS.ALGORITHMFONT, size: CONSTS.ALGORITHMSIZE)
set math.equation(numbering: "(1.1)")
show math.equation: i-figured.show-equation

show figure.where(kind: "subfigure"): it => {
  block(align(center, {
    it.body
    v(0.5em, weak: true)
    if it.caption != none {
      let num = numbering(it.numbering, it.counter.at(it.location()).first())
      text(font: CONSTS.FIGUREFONT, size: CONSTS.FIGUREFONTSIZE)[#strong[(#num)] #it.caption.body]
    }
  }))
}

show ref: it => {
  if it.element != none and it.element.func() == figure and it.element.kind == "subfigure" {
    let subfig = it.element
    let mainfigs = query(figure.where(kind: image).before(subfig.location()))
    if mainfigs.len() > 0 {
      let mainfig = mainfigs.last()
      let main-num = counter(figure.where(kind: image)).at(mainfig.location())
      
      // --- START: Dynamic Appendix/Chapter Numbering Fix ---
      let chapters = query(heading.where(level: 1).before(mainfig.location()))
      let supp = if it.supplement == auto { mainfig.supplement } else { it.supplement }
      let supp-str = if supp != none { [#supp~] } else { [] }
      if chapters.len() > 0 {
        let chapter = chapters.last()
        let chapter-num = counter(heading).at(mainfig.location()).first()
        let sub-num = subfig.counter.at(subfig.location()).first()
        let sub-letter = numbering(subfig.numbering, sub-num)
        let num-format = FUNCS.defaultnumbering(chapter)
        
        link(it.target, [#supp-str#numbering(num-format, chapter-num, ..main-num)#sub-letter])
      } else {
        // Fallback for cases where no level-1 heading is found
        let sub-num = subfig.counter.at(subfig.location()).first()
        let sub-letter = numbering(subfig.numbering, sub-num)
        link(it.target, [#supp-str#numbering("1.1", 0, ..main-num)#sub-letter])
      }
      // --- END: Dynamic Appendix/Chapter Numbering Fix ---

      /* REVERSION NOTE: To restore original logic, replace the block above with:
      let chapter-num = counter(heading.where(level: 1)).at(mainfig.location())
      let sub-num = subfig.counter.at(subfig.location()).first()
      let sub-letter = numbering(subfig.numbering, sub-num)
      link(it.target, [#mainfig.supplement #numbering("1.1", ..chapter-num, ..main-num)#sub-letter])
      */
    } else {
      it
    }
  } else {
    it
  }
}

show heading: it => {
  let reset = i-figured.reset-counters(it, return-orig-heading: false, extra-kinds: ("algorithm",))
  if it.level == 1 {
    if it.body != [References] {
      FUNCS.myoddpagebreak()
      // v(1%)
    }
    let beforeselectorcounterdisplay = numbering(FUNCS.defaultnumbering(it), ..counter(heading).get())

    if not(beforeselectorcounterdisplay == "0" or it.body == [Author's Publications] or it.body == [References]) {
      text(beforeselectorcounterdisplay, fill: CONSTS.CHAPTERFONTCOLOR, size: CONSTS.CHAPTERFONTSIZE, font: CONSTS.CHAPTERNUMBERFONT)
    }
    reset + counter(figure.where(kind: image)).update(0) + counter(figure.where(kind: table)).update(0) + [
    #linebreak()#linebreak()
    #text(it.body, font: CONSTS.HEADINGSFONT, size: 1.5em)
    #linebreak()#linebreak()
    ]
  } else {
    reset + text(it, font: CONSTS.HEADINGSFONT)
    // it
  }
}



// needs time to fix
// set cite(
//   style: "ieee"
// )

show outline.entry.where(
  level: 1,
) : it => {
  if it.element.func() == heading {
    strong(it)
  } else {
    it
  }
}

if progterms != none and progterms.len() > 0 {
  let progterms-regex = regex("\b(" + progterms.join("|") + ")\b")
  show progterms-regex: it => text(font: CONSTS.PROGFONT)[#it.text]
}

if algorithms != none and algorithms.len() > 0 {
  let algo-regex = regex("\b(" + algorithms.join("|") + ")\b")
  show algo-regex: it => {
    let styled-text = text(font: CONSTS.ALGORITHMFONT)[#smallcaps(it.text)]
    if CONSTS.HTMLMODE {
      styled-text
    } else {
      link(label("refer_alg_" + it.text))[#styled-text]
    }
  }
}

// 3. THE FIX: Intercept literal "$" strings and evaluate them as math markup.
// (Note the double backslashes to properly escape the $ for the regex engine)
// THE FIX: Scope the regex exclusively inside links
show link: it => {
  // This regex will now ONLY execute on text that is part of a hyperlink/reference
  show regex("\\$.+?\\$"): m => eval(m.text, mode: "markup")
  it
}

let glossary-data = yaml(CONSTS.HELPERFILESDIR + "glossary.yaml")
show: glossy.init-glossary.with(glossary-data, term-links: true, emphasize-first-use: true)


show regex("\\?[^\\?\\s]+\\?"): it => {
  if CONSTS.DEV {
    [#metadata(it.text) <missing-cite>]
    text(fill: red, weight: "bold")[#it]
  } else {
    it
  }
}

generatecoverpage(
  title: title,
  author: author,
  birthplace: birthplace,
  first_examiner: first_examiner,
  second_examiner: second_examiner,
  faculty: faculty,
  university: university,
  degree: degree,
  institute: institute,
  submission_date: submission_date,
  defense_date: defense_date,
  year: year,
  version: version,
)

FUNCS.myoddpagebreak()
dedication
FUNCS.myoddpagebreak()

heading(level: 1, numbering: none, outlined: false, [Abstract])
glossy.enable-local-mode(true)
abstract
glossy.enable-local-mode(false)

heading([Kurzfassung], numbering: none, outlined: false)
glossy.enable-local-mode(true)
kurzfassung
glossy.enable-local-mode(false)

outline(indent: auto)

// i-figured.outline()
FUNCS.ifiguredoutlineoutlinedfigure()
FUNCS.ifiguredoutlineoutlinedtable()
FUNCS.ifiguredoutlineoutlinedalgorithm()

// // 3. THE FIX: Intercept literal "$" strings and evaluate them as math markup.
// // (Note the double backslashes to properly escape the $ for the regex engine)
// // THE FIX: Scope the regex exclusively inside links
// show link: it => {
//   // This regex will now ONLY execute on text that is part of a hyperlink/reference
//   show regex("\\$.+?\\$"): m => eval(m.text, mode: "markup")
//   it
// }

// show: glossy.init-glossary.with(yaml(CONSTS.HELPERFILESDIR + "glossary.yaml"), term-links: true, emphasize-first-use: true)

glossy.glossary(
  title: "Acronyms", // Optional: defaults to Glossary theme:
  theme: FUNCS.my-acronym-theme, // Optional: defaults to theme-academic
  sort: true, // Optional: whether or not to sort the glossary
  ignore-case: false, // Optional: ignore case when sorting terms
  groups: ("Acronym")  // Optional: Filter to specific groups
)

glossy.glossary(
  title: "Glossary", // Optional: defaults to Glossary theme:
  theme: FUNCS.my-glossary-theme, // Optional: defaults to theme-academic
  sort: true, // Optional: whether or not to sort the glossary
  ignore-case: false, // Optional: ignore case when sorting terms
  groups: ("Glossary")  // Optional: Filter to specific groups
)

glossy.glossary(
  title: "Symbols", // Optional: defaults to Glossary theme:
  theme: FUNCS.my-symbol-theme, // Optional: defaults to theme-academic
  sort: true, // Optional: whether or not to sort the glossary
  ignore-case: false, // Optional: ignore case when sorting terms
  groups: ("Symbol")  // Optional: Filter to specific groups
)

 // --- START CUSTOM STYLE DEFINITION ---
// 1. Create the base style.
//    - format-brackets: it => it (Disables default brackets so we can control them)
//    - citation-separator: "; "   (Sets the separator to a semicolon)
let base-style = pergamon.format-citation-alphabetic(
  format-brackets: it => it, 
  citation-separator: "; "
)

// 2. Define a custom formatter that handles the suffix.
let custom-alpha-formatter(citations, form, options) = {
  // Call the base style to get the raw labels separated by semicolons (e.g., "GCV15; MSF15")
  let content = (base-style.format-citation)(citations, form, options)
  
  if "chapter" in options {
    content += ", Ch." + FUNCS.im($thin$) + [#options.chapter]
  }

  // Check if a suffix (e.g., "p. 3") was passed and append it
  if "suffix" in options {
    content += ", " + options.suffix
  }
  
  // (Optional) Handle prefix if needed
  if "prefix" in options {
    content = options.prefix + " " + content
  }
  
  // Finally, wrap the result in brackets manually
  [\[#content\]]
}

// 3. Package the components into the 'style' variable.
// The label-generator is wrapped to handle short author names (e.g., "He"), 
// preventing a crash when taking a 3-character slice.
let safe-label-generator(index, reference) = {
  let lastnames = (pergamon.family-names)(reference.fields.at("labelname", default: none))
  
  let abbreviation = if lastnames == none or lastnames.len() == 0 {
    "???"
  } else if lastnames.len() == 1 {
    let name = lastnames.at(0)
    name.slice(0, calc.min(name.len(), 3)) // default labelalpha is 3
  } else {
    let first-letters = lastnames.map(s => s.at(0)).join("")
    if lastnames.len() > 3 { // default maxalphanames is 3
      first-letters.slice(0, calc.min(first-letters.len(), 3)) + "+"
    } else {
      first-letters
    }
  }

  let year = if "parsed-date" in reference.fields and reference.fields.parsed-date != none and "year" in reference.fields.parsed-date {
    let y = str(reference.fields.parsed-date.year)
    y.slice(calc.max(0, y.len() - 2))
  } else {
    ""
  }

  let lbl = abbreviation + year
  return (lbl, lbl)
}

let style = (
  format-citation: custom-alpha-formatter,
  label-generator: safe-label-generator,
  reference-label: base-style.reference-label
)

show: doc => pergamon.refsection(format-citation: style.format-citation, doc) 
pergamon.add-bib-resource(read(CONSTS.HELPERFILESDIR + "references.bib"))
doc

// The Context Extraction Block
context {
  // We still query ALL level 1 headings to keep our page math accurate
  let chapters = query(heading.where(level: 1))
  
  let end-label = query(<end-of-doc>)
  let total-pages = if end-label.len() > 0 {
    end-label.last().location().page()
  } else {
    1
  }
  
  let toc-data = ()
  
  for (i, chap) in chapters.enumerate() {
    let current-page = chap.location().page()
    
    let next-boundary = if i + 1 < chapters.len() {
      chapters.at(i + 1).location().page()
    } else {
      total-pages + 1 
    }
    
    let pages-contained = next-boundary - current-page
    
    // THE MAGIC FILTER: Only add to the JSON if it has numbering enabled
    if chap.numbering != none {
      toc-data.push((
        title: FUNCS.plain-text(chap.body),
        total_pages: pages-contained
      ))
    }
  }
  
  if CONSTS.DEV {
    [#metadata(toc-data) <chapter-lengths>]
  }
}

FUNCS.myoddpagebreak()


set heading(numbering: none)

let is-own-pub(r, kw) = {
  let kws = r.fields.at("keywords", default: "")
  if type(kws) == array {
    kws.any(k => k.trim() == kw)
  } else if type(kws) == str {
    kws.split(",").map(k => k.trim()).contains(kw) or kws.split(";").map(k => k.trim()).contains(kw)
  } else {
    false
  }
}

pergamon.print-bibliography(
  format-reference: pergamon.format-reference(
      reference-label: style.reference-label,
      print-doi: true,
      print-url: true,
    ),
  label-generator: style.label-generator,
  title: [Author's Publications],
  filter: r => is-own-pub(r, own_bib_keyword),
)

pagebreak()

pergamon.print-bibliography(
  format-reference: pergamon.format-reference(
      reference-label: style.reference-label,
      print-doi: true,
      print-url: true,
    ),
  label-generator: style.label-generator,
  title: "References",
  filter: r => not is-own-pub(r, own_bib_keyword),
)

// restart counter
counter(heading).update(0)

// ORIGINAL RULE (revert by uncommenting this and removing the selective rules below):
// show figure: i-figured.show-figure.with(numbering: CONSTS.APPENDIXNUMBERING)
show figure.where(kind: image): i-figured.show-figure.with(numbering: CONSTS.APPENDIXNUMBERING)
show figure.where(kind: table): i-figured.show-figure.with(numbering: CONSTS.APPENDIXNUMBERING)
show figure.where(kind: raw): i-figured.show-figure.with(numbering: CONSTS.APPENDIXNUMBERING)
show math.equation: i-figured.show-equation.with(numbering: CONSTS.APPENDIXNUMBERING)
show figure.where(kind: "algorithm"): i-figured.show-figure.with(numbering: CONSTS.APPENDIXNUMBERING, extra-prefixes: (algorithm: "algo:"))

FUNCS.myoddpagebreak()
// set heading(
//   numbering: "A.1"
// )
set heading(supplement: [Appendix])
[#heading([Appendix], numbering: CONSTS.APPENDIXNUMBERING, outlined: true) <seca_all>]
appendix

FUNCS.myoddpagebreak()

if CONSTS.DEV {
  [#metadata("end") <end-of-doc>]
}
}
