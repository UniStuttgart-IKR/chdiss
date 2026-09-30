#import "peripherals/mytemplate.typ": chdiss
#import "peripherals/myfunctions.typ" as FUNCS
#import "peripherals/myconstants.typ" as CONSTS
#import "peripherals/cetzfigures.typ" as CETZFIGS
#import "peripherals/coverpage.typ": generatecoverpage
#import "3rdparty/typst-algorithmic/algorithmic.typ" as algorithmic
#import "3rdparty/typst-algorithmic/algorithmic.typ": (
  Assign,
  Return,
  For,
  While,
  If,
  Else,
  ElseIf,
  Function,
  Procedure,
  Call,
  Comment,
  LineComment,
  Break,
  Terminate,
)

// User-facing functions offered to users
#import FUNCS: (
  subfigures,
  subfig,
  table-figure,
  gridequations,
  algo-block,
  CleanProcedure,
  FadedComment,
  FadedLineComment,
  inline-terms,
  myqty,
  ffont,
  pfont,
  wr,
  eqref,
  im,
  fheading,
  kpi,
  htmlplace,
  lorempages,
  todo,
)

// Citation helpers from pergamon
#import "@preview/pergamon:0.8.0": cite, citet, citep
