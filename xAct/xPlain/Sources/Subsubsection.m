(*=================*)
(*  Subsubsection  *)
(*=================*)

Subsubsection[Expr_?ListQ]:=If[$xPlainCLI,
		DisplayCLI@("   #### "<>StringJoin@Expr);,
		CellPrint@Cell[TextData@Flatten@Expr,
				15,
				Underlined,
				"Text",
				CellContext->"Global`",
				FontColor->$NWhite,
				Background->$NBlue];
];

Subsubsection[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI@("  #### "<>Expr);
	,
		CellPrint@TextCell[Expr,20,Underlined,"Text",FontColor->$NWhite,Background->$NBlue];
	];
];
