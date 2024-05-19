(*=========*)
(*  Title  *)
(*=========*)

Title[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI@("     # "<>Expr);
	,
		CellPrint@TextCell[Expr,80,Darker@Green,Underlined,"Text"];
	];
];
