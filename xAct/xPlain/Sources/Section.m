(*===========*)
(*  Section  *)
(*===========*)

Section[Expr_?ListQ]:=If[$xPlainCLI,
		DisplayCLI@("   ### "<>StringJoin@Expr);,
		CellPrint@Cell[TextData@Flatten@Expr,
				25,
				Underlined,
				"Text",
				CellContext->"Global`",
				FontColor->$NWhite,
				Background->$NBlue];
];

Section[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI@("   ### "<>Expr);
	,
		CellPrint@TextCell[Expr,50,Underlined,"Text",FontColor->$NWhite,Background->$NBlue];
	];
];
