(*===========*)
(*  Section  *)
(*===========*)

Section[Expr_?ListQ]:=If[$xPlainCLI,
		DisplayCLI@("   ### "<>StringJoin@Expr);,
		CellPrint@Cell[TextData@Flatten@Expr,
				25,
				Darker@Green,
				Underlined,
				"Text",
				CellContext->"Global`"];
];

Section[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI@("   ### "<>Expr);
	,
		CellPrint@TextCell[Expr,50,Darker@Green,Underlined,"Text"];
	];
];
