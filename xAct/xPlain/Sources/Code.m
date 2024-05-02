(*========*)
(*  Code  *)
(*========*)

SetAttributes[Code,HoldAll];
Code[InputCode_,opts:OptionsPattern[Cell]]:=Module[{Expr},
	CellPrint@ExpressionCell[Defer@InputForm@InputCode,"Input",opts];	
	Expr=InputCode;
	Expr//=Evaluate;
Expr];
