(*===============*)
(*  TakePadding  *)
(*===============*)

TakePadding[InputExpr_,PadLength_]:=Module[{StringList=StringTake[InputExpr,PadLength]},
	If[PadLength>0,
		StringList//=StringSplit;
		StringList//=Drop[#,-1]&;
		StringList=(#<>" ")&/@StringList;
		StringList=StringJoin@@StringList;
	,
		StringList//=StringSplit;
		StringList//=Drop[#,1]&;
		StringList=(" "<>#)&/@StringList;
		StringList=StringJoin@@StringList;
	];	
StringList];
