(*===========*)
(*  RunCode  *)
(*===========*)

RunCode[InputCode_]:=Module[{Expr=InputCode},
	Expr//=Evaluate;
Expr];
