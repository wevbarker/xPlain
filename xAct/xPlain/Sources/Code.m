(*========*)
(*  Code  *)
(*========*)

IncludeHeader@"LstCode";
IncludeHeader@"CLICode";
IncludeHeader@"GUICode";
IncludeHeader@"RunCode";

Options@Code={LineLabel->"NoLineLabel"};
SetAttributes[Code,HoldAll];
Code[InputCode_,CodeOptions:OptionsPattern[]]:=Code[DummyVar,InputCode,CodeOptions];

Code[Var1_,InputCode_,OptionsPattern[]]:=Module[{Expr,FullInputCode=Defer@InputForm@InputCode/.OwnValues@Var1},

	If[$xPlainCLI,
		FullInputCode//CLICode;
		,
		FullInputCode//GUICode;
		If[$Listings,
			LstCode[FullInputCode,LineLabel->OptionValue@LineLabel];
		];
	];
	Expr=InputCode//RunCode;
Expr];

Code[Var1_,Var2_,InputCode_,OptionsPattern[]]:=Module[{Expr,FullInputCode=Defer@InputForm@InputCode/.OwnValues@Var1/.OwnValues@Var2},

	If[$xPlainCLI,
		FullInputCode//CLICode;
		,
		FullInputCode//GUICode;
		If[$Listings,
			LstCode[FullInputCode,LineLabel->OptionValue@LineLabel];
		];
	];
	Expr=InputCode//RunCode;
Expr];

Code[Var1_,Var2_,Var3_,InputCode_,OptionsPattern[]]:=Module[{Expr,FullInputCode=Defer@InputForm@InputCode/.OwnValues@Var1/.OwnValues@Var2/.OwnValues@Var3},

	If[$xPlainCLI,
		FullInputCode//CLICode;
		,
		FullInputCode//GUICode;
		If[$Listings,
			LstCode[FullInputCode,LineLabel->OptionValue@LineLabel];
		];
	];
	Expr=InputCode//RunCode;
Expr];

Code[Var1_,Var2_,Var3_,Var4_,InputCode_,OptionsPattern[]]:=Module[{Expr,FullInputCode=Defer@InputForm@InputCode/.OwnValues@Var1/.OwnValues@Var2/.OwnValues@Var3/.OwnValues@Var4},

	If[$xPlainCLI,
		FullInputCode//CLICode;
		,
		FullInputCode//GUICode;
		If[$Listings,
			LstCode[FullInputCode,LineLabel->OptionValue@LineLabel];
		];
	];
	Expr=InputCode//RunCode;
Expr];

Code[Var1_,Var2_,Var3_,Var4_,Var5_,InputCode_,OptionsPattern[]]:=Module[{Expr,FullInputCode=Defer@InputForm@InputCode/.OwnValues@Var1/.OwnValues@Var2/.OwnValues@Var3/.OwnValues@Var4},

	If[$xPlainCLI,
		FullInputCode//CLICode;
		,
		FullInputCode//GUICode;
		If[$Listings,
			LstCode[FullInputCode,LineLabel->OptionValue@LineLabel];
		];
	];
	Expr=InputCode//RunCode;
Expr];
