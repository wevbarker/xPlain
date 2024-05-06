(*========*)
(*  Code  *)
(*========*)

SetAttributes[Code,HoldAll];

Code[InputCode_,opts:OptionsPattern[Cell]]:=Code[DummyVar,InputCode,opts];

Code[SomeVar_,InputCode_,opts:OptionsPattern[Cell]]:=Module[{Expr},
	Off@Attributes::ssle;
	CellPrint@ExpressionCell[Defer@InputForm@InputCode/.OwnValues@SomeVar,"Input",InitializationCell->True];	
	(*CellPrint@ExpressionCell[Defer@InputForm@InputCode/.OwnValues@SomeVar,"Input",opts];	*)
	Expr=InputCode;
	Expr//=Evaluate;
	On@Attributes::ssle;
Expr];
