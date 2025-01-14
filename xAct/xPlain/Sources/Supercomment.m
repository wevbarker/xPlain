(*================*)
(*  Supercomment  *)
(*================*)

Supercomment[Expr_?StringQ]:=Supercomment[{Expr}];
Supercomment[Expr_?ListQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI[("  ===> "<>StringJoin@@Flatten@Expr),StyleCLI->"Supercomment"];
	,
		CellPrint@Cell[TextData@({StyleBox["Key observation: ",Large]}~Join~Flatten@Expr),"Text",FontColor->$NWhite,Background->$NBlue];
	];
];
