// #import "@preview/acrotastic:0.1.1"

#let myleading = 0.975em
#let myspacing = 1.2em
#let FIGUREVSPACE = 1.1em
#let FIGUREVCLEARANCE = myleading
#let CAPTIONLEADING = 0.6em
#let FIGURELEADING = 0.45em

#let DEV = upper(sys.inputs.at("dev", default: "FALSE").trim()) == "TRUE"
#let HTMLMODE = upper(sys.inputs.at("htmlmode", default: "FALSE").trim()) == "TRUE"
#let POPULATEPAGESNUM = int(sys.inputs.at("populate", default: 0))

#let CONTENTDIR = "/content/"
#let HELPERFILESDIR = "/helperfiles/"
#let SRCDIR = "/src/"
#let FIGURESDIV = "/figures/"

#let DETAILS = (version: "1.0")

#let DEVCOLOR = color.red

#let APPENDIXNUMBERING = "A.1"

#let TEXTFONT = "DejaVu Serif"
#let PROGFONT = "New Computer Modern"
#let HEADERFONT = "Latin Modern Sans"
#let HEADINGSFONT = "Latin Modern Sans"
#let FIGUREFONT = "Latin Modern Sans"
#let ALGORITHMFONT = "TeX Gyre Heros"
// #let ALGORITHMFONT = "Latin Modern Sans"
#let CHAPTERNUMBERFONT = ("Liberation Sans", "Roboto")

#let TEXTFONTSIZE = 13pt
#let ALGORITHMSIZE = 12.0pt

#let TITLEFONTSIZE = 15pt
#let MYNAMEFONTSIZE = 14pt
#let HEADERFONTSIZE = 13pt
#let FIGUREFONTSIZE = 13pt

#let HEADERABSTAINFROMPAGE = 1cm

#let CHAPTERFONTSIZE = 150pt
#let CHAPTERFONTCOLOR = gray


