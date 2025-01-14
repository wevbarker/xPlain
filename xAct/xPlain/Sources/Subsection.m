(*==============*)
(*  Subsection  *)
(*==============*)

Subsection[Expr_?ListQ]:=If[$xPlainCLI,
		DisplayCLI@("   #### "<>StringJoin@Expr);,
		CellPrint@Cell[TextData@Flatten@Expr,
				20,
				Underlined,
				"Text",
				CellContext->"Global`",
				FontColor->$NWhite,
				Background->$NBlue];
];

Subsection[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI@("  #### "<>Expr);
	,
		CellPrint@TextCell[Expr,35,Underlined,"Text",FontColor->$NWhite,Background->$NBlue];
	];
];
