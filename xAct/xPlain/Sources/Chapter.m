(*===========*)
(*  Chapter  *)
(*===========*)

Chapter[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI@("    ## "<>Expr);
	,
		CellPrint@TextCell[Expr,65,Underlined,"Text",FontColor->$NWhite,Background->$NBlue];
	];
];
