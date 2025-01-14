(*===========*)
(*  Comment  *)
(*===========*)

Comment[Expr_?ListQ]:=If[$xPlainCLI,
	DisplayCLI[("  ---> "<>StringJoin@@Flatten@Expr),StyleCLI->"Comment"];
,
	CellPrint@Cell[TextData@Flatten@Expr,"Text",CellContext->"Global`",FontColor->$NWhite,Background->$NBlue];
];
Comment[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI[("  ---> "<>Expr),StyleCLI->"Comment"];
	,
		CellPrint@TextCell[Expr,"Text",CellContext->"Global`",FontColor->$NWhite,Background->$NBlue]
	];
];
