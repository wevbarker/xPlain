(*===========*)
(*  Chapter  *)
(*===========*)

Chapter[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI@("    ## "<>Expr);
	,
		CellPrint@TextCell[Expr,35,Darker@Green,Underlined,Bold,"Text"];
	];
];
