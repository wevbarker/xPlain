(*========*)
(*  Code  *)
(*========*)

SetAttributes[Code,HoldAll];

Code[InputCode_,opts:OptionsPattern[Cell]]:=Code[DummyVar,InputCode,opts];

Code[SomeVar_,InputCode_,opts:OptionsPattern[Cell]]:=Module[{
	Expr,
	LineWidth=60,
	Content,
	ContentWidth},

	If[$xPlainCLI,
		Off@Attributes::ssle;
		Content="[displayed code with "<>ToString@LeafCount@(Defer@InputForm@InputCode/.OwnValues@SomeVar)<>" leaves]";
		ContentWidth=StringLength@Content;
		Content//=StringPadLeft[#,Floor@(ContentWidth+(LineWidth-ContentWidth)/2)]&;
		ContentWidth=StringLength@Content;
		Content//=StringPadRight[#,Floor@(ContentWidth+(LineWidth-ContentWidth)/2)]&;
		Content//=StringPadRight[#,LineWidth]&;
		Content=Content<>"(##)";
		DisplayCLI[Content,StyleCLI->"Code"];
		Expr=InputCode;
		Expr//=Evaluate;
		On@Attributes::ssle;
		,
		Off@Attributes::ssle;
		CellPrint@ExpressionCell[Defer@InputForm@InputCode/.OwnValues@SomeVar,"Input",InitializationCell->True];	
		Expr=InputCode;
		Expr//=Evaluate;
		On@Attributes::ssle;
	];
Expr];
