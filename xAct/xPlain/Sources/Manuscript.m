(*==============*)
(*  Manuscript  *)
(*==============*)

Manuscript[Expr_?StringQ]:=Manuscript[{Expr}];
Manuscript[Expr_?ListQ]:=Module[{},
	CellPrint@Cell[TextData@({StyleBox["Concrete relation to manuscript: ",Large]}~Join~Flatten@Expr),Darker@Green,"Text",Background->Yellow]];
