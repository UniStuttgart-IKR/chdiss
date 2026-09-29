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

#import FUNCS: (
  subfigures,
  subfig,
  table-figure,
  callout,
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
  arr,
  extract-text,
  im,
  plain-text,
  fheading,
  r,
  roitc,
  rkpi,
  kpi,
  htmlplace,
  baselineref,
  lorempages,
  todo,
)
