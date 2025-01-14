(*=========*)
(*  Title  *)
(*=========*)

Title[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI@("     # "<>Expr);
	,
		CellPrint@TextCell[Expr,80,Underlined,"Text",FontColor->$NWhite,Background->$NBlue];
	];
];
