(*===========*)
(*  GUICode  *)
(*===========*)

GUICode[FullInputCode_]:=Module[{},

	Off@Attributes::ssle;
	CellPrint@ExpressionCell[FullInputCode,"Input",InitializationCell->False,FontColor->$NGreen,Background->$BMagenta,ShowAutoStyles->False];
	On@Attributes::ssle;
];
