#import "myfunctions.typ" as FUNCS
#import "myconstants.typ" as CONSTS
#import "coverpage.typ": generatecoverpage

#import "@preview/i-figured:0.2.4"
#import "@preview/pergamon:0.8.0" as pergamon
// #import "@preview/pergamon:0.7.1" as pergamon
#import "../3rdparty/glossy/lib.typ" as glossy

/// Main template show rule for the doctoral dissertation.
///
/// Applies Universität Stuttgart IKR dissertation styling, sets up frontmatter
/// (cover page, abstract, kurzfassung, dedication, table of contents), configures
/// headers/footers with odd/even page differentiation, registers glossary/acronyms,
/// two-tier bibliography ("Author's Publications" vs general "References"), and appendix styling.
#let chdiss(
  /// Dissertation title (and optional subtitle).
  title: [Doctoral Dissertation Title \ Subtitle or Secondary Title of the Work],
  /// Full author name.
  author: "John Doe",
  /// Place of birth (e.g. "City, Country").
  birthplace: "Sample City, Sample Country",
  /// Primary doctoral advisor / first examiner (Hauptberichter).
  first_examiner: "Prof. Dr.-Ing. Jane Smith",
  /// Secondary doctoral advisor / second examiner (Mitberichter).
  second_examiner: "Prof. Dr.-Ing. Alex Johnson",
  /// Faculty conferring the degree.
  faculty: "Fakultät für Informatik, Elektrotechnik und Informationstechnik",
  /// University conferring the degree.
  university: "Universität Stuttgart",
  /// Degree sought.
  degree: "Doktor-Ingenieurs (Dr.-Ing.)",
  /// Institute / department name.
  institute: [Institut für Kommunikationsnetze und Rechnersysteme\ der Universität Stuttgart],
  /// Official date of submission (Tag der Einreichung).
  submission_date: "1. Januar 2026",
  /// Official date of oral examination / defense (Tag der mündlichen Prüfung). Defaults to placeholder dashes if `none`.
  defense_date: none,
  /// Publication year shown on cover page.
  year: "2026",
  /// Draft version string shown on cover page when `dev_mode` is true (defaults to "1.0").
  version: none,
  /// BibTeX keyword used to identify author's own publications for the separate "Author's Publications" bibliography.
  own_bib_keyword: "own",
  /// List of programming identifiers / terms to automatically format with `font_prog`.
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
  /// List of algorithm names to automatically format in smallcaps and link to pseudocode blocks.
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
  // Typography and Font Configuration
  /// Body text font family (defaults to CONSTS.TEXTFONT: "DejaVu Serif").
  font_text: auto,
  /// Base text font size (defaults to CONSTS.TEXTFONTSIZE: 13pt).
  font_size: auto,
  /// Programming/code terms font family (defaults to CONSTS.PROGFONT: "New Computer Modern").
  font_prog: auto,
  /// Running page header font family (defaults to CONSTS.HEADERFONT: "Latin Modern Sans").
  font_header: auto,
  /// Section/chapter headings font family (defaults to CONSTS.HEADINGSFONT: "Latin Modern Sans").
  font_headings: auto,
  /// Figure/table captions font family (defaults to CONSTS.FIGUREFONT: "Latin Modern Sans").
  font_figure: auto,
  /// Algorithm pseudocode font family (defaults to CONSTS.ALGORITHMFONT: "TeX Gyre Heros").
  font_algo: auto,
  /// Large chapter number decorative font family (defaults to CONSTS.CHAPTERNUMBERFONT: ("Liberation Sans", "Roboto")).
  font_chapternumber: auto,

  // Sizing & Spacing Options
  /// Running header font size (defaults to CONSTS.HEADERFONTSIZE: 13pt).
  header_font_size: auto,
  /// Figure caption font size (defaults to CONSTS.FIGUREFONTSIZE: 13pt).
  figure_font_size: auto,
  /// Algorithm font size (defaults to CONSTS.ALGORITHMSIZE: 12.0pt).
  algo_font_size: auto,
  /// Title font size on cover page (defaults to CONSTS.TITLEFONTSIZE: 15pt).
  title_font_size: auto,
  /// Author name font size on cover page (defaults to CONSTS.MYNAMEFONTSIZE: 14pt).
  myname_font_size: auto,
  /// Background chapter number size (defaults to CONSTS.CHAPTERFONTSIZE: 150pt).
  chapter_font_size: auto,
  /// Background chapter number color (defaults to CONSTS.CHAPTERFONTCOLOR: gray).
  chapter_font_color: auto,

  /// Paragraph line leading (defaults to CONSTS.myleading: 0.975em).
  par_leading: auto,
  /// Paragraph block spacing (defaults to CONSTS.myspacing: 1.2em).
  par_spacing: auto,
  /// Spacing above and below figures (defaults to CONSTS.FIGUREVSPACE: 1.1em).
  figure_vspace: auto,
  /// Floating figure clearance (defaults to CONSTS.FIGUREVCLEARANCE: 0.975em).
  figure_vclearance: auto,
  /// Caption line leading (defaults to CONSTS.CAPTIONLEADING: 0.6em).
  caption_leading: auto,
  /// Horizontal spacing between page number and title in headers (defaults to CONSTS.HEADERABSTAINFROMPAGE: 1cm).
  header_abstain_from_page: auto,

  // Appendix & Compilation Modes
  /// Appendix numbering format string (defaults to CONSTS.APPENDIXNUMBERING: "A.1").
  appendix_numbering: auto,
  /// Development/draft mode toggle (defaults to sys.inputs.dev == "TRUE"). Shows missing citations and draft version.
  dev_mode: auto,
  /// Accent color for development mode annotations (defaults to CONSTS.DEVCOLOR: color.red).
  dev_color: auto,
  /// Experimental HTML export mode toggle (defaults to sys.inputs.htmlmode == "TRUE").
  html_mode: auto,

  // Optional constants dictionary override
  /// Dictionary of constant overrides mapping constant names (e.g. TEXTFONT, myleading) to values.
  constants: (:),
  /// English abstract content.
  abstract: [],
  /// Dedication page content.
  dedication: [],
  /// German Kurzfassung content.
  kurzfassung: [],
  /// Appendix content placed after bibliography.
  appendix: [],
  /// Glossary/acronym data loaded from YAML or passed as a dictionary.
  glossary: none,
  /// BibTeX bibliography content string loaded via `read(...)`.
  bib: none,
  /// Document body content provided automatically by `#show: chdiss.with(...)`.
  doc,
) = {

  // Resolve constants: user explicit parameter -> constants dictionary -> CONSTS default
  let c(key, param, fallback) = {
    if param != auto { param }
    else if key in constants { constants.at(key) }
    else if lower(key) in constants { constants.at(lower(key)) }
    else { fallback }
  }

  let font_text = c("TEXTFONT", font_text, CONSTS.TEXTFONT)
  let font_size = c("TEXTFONTSIZE", font_size, CONSTS.TEXTFONTSIZE)
  let font_prog = c("PROGFONT", font_prog, CONSTS.PROGFONT)
  let font_header = c("HEADERFONT", font_header, CONSTS.HEADERFONT)
  let font_headings = c("HEADINGSFONT", font_headings, CONSTS.HEADINGSFONT)
  let font_figure = c("FIGUREFONT", font_figure, CONSTS.FIGUREFONT)
  let font_algo = c("ALGORITHMFONT", font_algo, CONSTS.ALGORITHMFONT)
  let font_chapternumber = c("CHAPTERNUMBERFONT", font_chapternumber, CONSTS.CHAPTERNUMBERFONT)

  let header_font_size = c("HEADERFONTSIZE", header_font_size, CONSTS.HEADERFONTSIZE)
  let figure_font_size = c("FIGUREFONTSIZE", figure_font_size, CONSTS.FIGUREFONTSIZE)
  let algo_font_size = c("ALGORITHMSIZE", algo_font_size, CONSTS.ALGORITHMSIZE)
  let title_font_size = c("TITLEFONTSIZE", title_font_size, CONSTS.TITLEFONTSIZE)
  let myname_font_size = c("MYNAMEFONTSIZE", myname_font_size, CONSTS.MYNAMEFONTSIZE)
  let chapter_font_size = c("CHAPTERFONTSIZE", chapter_font_size, CONSTS.CHAPTERFONTSIZE)
  let chapter_font_color = c("CHAPTERFONTCOLOR", chapter_font_color, CONSTS.CHAPTERFONTCOLOR)

  let par_leading = c("myleading", par_leading, CONSTS.myleading)
  let par_spacing = c("myspacing", par_spacing, CONSTS.myspacing)
  let figure_vspace = c("FIGUREVSPACE", figure_vspace, CONSTS.FIGUREVSPACE)
  let figure_vclearance = c("FIGUREVCLEARANCE", figure_vclearance, CONSTS.FIGUREVCLEARANCE)
  let caption_leading = c("CAPTIONLEADING", caption_leading, CONSTS.CAPTIONLEADING)
  let header_abstain_from_page = c("HEADERABSTAINFROMPAGE", header_abstain_from_page, CONSTS.HEADERABSTAINFROMPAGE)

  let appendix_numbering = c("APPENDIXNUMBERING", appendix_numbering, CONSTS.APPENDIXNUMBERING)
  let dev_mode = c("DEV", dev_mode, CONSTS.DEV)
  let dev_color = c("DEVCOLOR", dev_color, CONSTS.DEVCOLOR)
  let html_mode = c("HTMLMODE", html_mode, CONSTS.HTMLMODE)

set document(
  title: title,
  author: author,
  date: auto //gets current compilation date
)

set text(
  font: font_text,
  size: font_size,
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
        #text(font: font_header, size: header_font_size, content)
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
    return returntext(left, [#counter(page).display("1") #h(header_abstain_from_page) #chaptername])
  } else {
    return returntext(left, [#counter(page).display("1") #h(header_abstain_from_page) Chapter #chapternumbering #sym.dash #chaptername])
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
    return returntext(right, [#headingname #h(header_abstain_from_page) #counter(page).display("1")])
  } else {
    return returntext(right, [#headingnumbertouse #headingname #h(header_abstain_from_page) #counter(page).display("1")])
  }
  }
  }

  } 
  }
  )

set par(
  first-line-indent: 1em,
  leading: par_leading,
  spacing: par_spacing,
  justify: true,
)

set heading(
  numbering: "1.1",
  supplement: [Section]
)

show figure: set block(above: figure_vspace, below: figure_vspace)
show figure: set place(clearance: figure_vclearance)

show figure.caption: c => {
  set par(leading: caption_leading)
  text(font: font_figure, size: figure_font_size, c)
}

// show figure: i-figured.show-figure
show figure.where(kind: image): i-figured.show-figure
show figure.where(kind: table): i-figured.show-figure
show figure.where(kind: raw): i-figured.show-figure
show figure.where(kind: "algorithm"): i-figured.show-figure.with(extra-prefixes: (algorithm: "algo:"))
show figure.where(kind: "algorithm"): set figure(supplement: "Algorithm")
show figure.where(kind: "algorithm"): set text(font: font_algo, size: algo_font_size)
set math.equation(numbering: "(1.1)")
show math.equation: i-figured.show-equation

show figure.where(kind: "subfigure"): it => {
  block(align(center, {
    it.body
    v(0.5em, weak: true)
    if it.caption != none {
      let num = numbering(it.numbering, it.counter.at(it.location()).first())
      text(font: font_figure, size: figure_font_size)[#strong[(#num)] #it.caption.body]
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
  } else if it.element != none {
    let t = str(it.target)
    if not (t.starts-with("fig:") or t.starts-with("tbl:") or t.starts-with("eqt:") or t.starts-with("algo:") or t.starts-with("lst:")) {
      if it.element.func() == figure {
        let p = if it.element.kind == image { "fig:" }
          else if it.element.kind == table { "tbl:" }
          else if it.element.kind == "algorithm" { "algo:" }
          else if it.element.kind == raw { "lst:" }
          else { none }
        if p != none {
          return ref(label(p + t), supplement: it.supplement)
        }
      } else if it.element.func() == math.equation {
        return ref(label("eqt:" + t), supplement: it.supplement)
      }
    }
    it
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
      text(beforeselectorcounterdisplay, fill: chapter_font_color, size: chapter_font_size, font: font_chapternumber)
    }
    reset + counter(figure.where(kind: image)).update(0) + counter(figure.where(kind: table)).update(0) + [
    #linebreak()#linebreak()
    #text(it.body, font: font_headings, size: 1.5em)
    #linebreak()#linebreak()
    ]
  } else {
    reset + text(it, font: font_headings)
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
  show progterms-regex: it => text(font: font_prog)[#it.text]
}

if algorithms != none and algorithms.len() > 0 {
  let algo-regex = regex("\b(" + algorithms.join("|") + ")\b")
  show algo-regex: it => {
    let styled-text = text(font: font_algo)[#smallcaps(it.text)]
    if html_mode {
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

show: doc => if glossary != none {
  let glossary-data = if type(glossary) == dictionary { glossary } else { yaml(glossary) }
  glossy.init-glossary(glossary-data, term-links: true, emphasize-first-use: true, doc)
} else {
  doc
}


show regex("\\?[^\\?\\s]+\\?"): it => {
  if dev_mode {
    [#metadata(it.text) <missing-cite>]
    text(fill: dev_color, weight: "bold")[#it]
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
  dev: dev_mode,
  dev_color: dev_color,
  title_font_size: title_font_size,
  myname_font_size: myname_font_size,
)

FUNCS.myoddpagebreak()
dedication
FUNCS.myoddpagebreak()

heading(level: 1, numbering: none, outlined: false, [Abstract])
if glossary != none { glossy.enable-local-mode(true) }
abstract
if glossary != none { glossy.enable-local-mode(false) }

heading([Kurzfassung], numbering: none, outlined: false)
if glossary != none { glossy.enable-local-mode(true) }
kurzfassung
if glossary != none { glossy.enable-local-mode(false) }

outline(indent: auto)

// i-figured.outline()
FUNCS.ifiguredoutlineoutlinedfigure()
FUNCS.ifiguredoutlineoutlinedtable()
FUNCS.ifiguredoutlineoutlinedalgorithm()

if glossary != none {
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
}

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
if bib != none {
  let bib-str = if type(bib) == str { bib } else { read(bib) }
  pergamon.add-bib-resource(bib-str)
}
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
  
  if dev_mode {
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
// show figure: i-figured.show-figure.with(numbering: appendix_numbering)
show figure.where(kind: image): i-figured.show-figure.with(numbering: appendix_numbering)
show figure.where(kind: table): i-figured.show-figure.with(numbering: appendix_numbering)
show figure.where(kind: raw): i-figured.show-figure.with(numbering: appendix_numbering)
let app_eq_numbering = if appendix_numbering.starts-with("(") { appendix_numbering } else { "(" + appendix_numbering + ")" }
show math.equation: i-figured.show-equation.with(numbering: app_eq_numbering)
show figure.where(kind: "algorithm"): i-figured.show-figure.with(numbering: appendix_numbering, extra-prefixes: (algorithm: "algo:"))

FUNCS.myoddpagebreak()
// set heading(
//   numbering: "A.1"
// )
set heading(supplement: [Appendix])
[#heading([Appendix], numbering: appendix_numbering, outlined: true) <seca_all>]
appendix

FUNCS.myoddpagebreak()

if dev_mode {
  [#metadata("end") <end-of-doc>]
}
}
