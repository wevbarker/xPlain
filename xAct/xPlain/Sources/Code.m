(*========*)
(*  Code  *)
(*========*)

IncludeHeader@"LstCode";
IncludeHeader@"CLICode";
IncludeHeader@"GUICode";
IncludeHeader@"RunCode";

Options@Code={LineLabel->"NoLineLabel"};
SetAttributes[Code,HoldAll];
Code[InputCode_,otheropts:OptionsPattern[]]:=Code[DummyVar,InputCode,otheropts];

Code[SomeVar_,InputCode_,OptionsPattern[]]:=Module[{Expr,FullInputCode=Defer@InputForm@InputCode/.OwnValues@SomeVar},

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

Code[SomeVar_,SomeOtherVar_,InputCode_,OptionsPattern[]]:=Module[{Expr,FullInputCode=Defer@InputForm@InputCode/.OwnValues@SomeVar/.OwnValues@SomeOtherVar},

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

Code[SomeVar_,SomeOtherVar_,SomeOtherOtherVar_,InputCode_,OptionsPattern[]]:=Module[{Expr,FullInputCode=Defer@InputForm@InputCode/.OwnValues@SomeVar/.OwnValues@SomeOtherVar/.OwnValues@SomeOtherOtherVar},

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

Code[SomeVar_,SomeOtherVar_,SomeOtherOtherVar_,SomeOtherOtherVar_,InputCode_,OptionsPattern[]]:=Module[{Expr,FullInputCode=Defer@InputForm@InputCode/.OwnValues@SomeVar/.OwnValues@SomeOtherVar/.OwnValues@SomeOtherOtherVar/.OwnValues@SomeOtherOtherOtherVar},

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
