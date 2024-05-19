(*===========*)
(*  Chapter  *)
(*===========*)

Chapter[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI@("    ## "<>Expr);
	,
		CellPrint@TextCell[Expr,65,Darker@Green,Underlined,"Text"];
	];
];
