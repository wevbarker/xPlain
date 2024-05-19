(*==================*)
(*  PartIIIProject  *)
(*==================*)

PartIIIProject[Expr_?StringQ]:=PartIIIProject[{Expr}];
PartIIIProject[Expr_?ListQ]:=Module[{},
	CellPrint@Cell[TextData@({StyleBox["Connection to Part III Project: ",Large]}~Join~Flatten@Expr),Darker@Green,"Text",Background->Yellow]];
