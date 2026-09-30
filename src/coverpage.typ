#import "myconstants.typ" as CONSTS

#let generatecoverpage(
  title: [Doctoral Dissertation Title Doctoral \ Dissertation Title Doctoral ],
  author: "John Doe",
  birthplace: "Sample City, Sample Country",
  first_examiner: "Prof. Dr.-Ing. Jane Smith",
  second_examiner: "Prof. Dr.-Ing. Alex Johnson",
  faculty: "Fakultät für Informatik, Elektrotechnik und Informationstechnik",
  university: "Universität Stuttgart",
  degree: "Doktor-Ingenieurs (Dr.-Ing.)",
  institute: [Institut für Kommunikationsnetze und Rechnersysteme\ der Universität Stuttgart],
  submission_date: "1. Januar 2026",
  defense_date: none,
  year: "2026",
  version: none,
  dev: CONSTS.DEV,
  dev_color: CONSTS.DEVCOLOR,
  title_font_size: CONSTS.TITLEFONTSIZE,
  myname_font_size: CONSTS.MYNAMEFONTSIZE,
) = {

align(center)[
  #if dev [
     #place(top + center, float: false, [
      #let ver = if version != none { version } else { CONSTS.DETAILS.at("version", default: "1.0") }
      #text(fill: dev_color, [draft version #ver])
    ])
  ]
  #v(1fr)
  #text(size: title_font_size, weight: "bold", title)
  #v(1fr)
  Von der #faculty\
  der #university zur Erlangung der Würde\
  eines #degree genehmigte Abhandlung
  #v(1fr)
  Vorgelegt von
  #v(0.4fr)
  #text(size: myname_font_size, author)
  #v(0.2fr)
  #if birthplace != none [geboren in #birthplace]
  #v(1fr)
  #table(
    columns: 2,
    stroke: none,
    align: (right, left),
    column-gutter: 1.5em,
    [Hauptberichter], [#first_examiner],
    [Mitberichter], [#second_examiner],
    [],[],
    [Tag der Einreichung], [#submission_date],
    [Tag der mündlichen Prüfung], [#if defense_date != none { defense_date } else { [] }],
  )
  #v(1fr)
  #institute
  #v(1fr)
  #year
  #v(0.5fr)
]

}
