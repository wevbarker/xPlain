(*===========*)
(*  LstCode  *)
(*===========*)

IncludeHeader@"LstListingCode";
IncludeHeader@"SystemTest";

$LstListingsLine=1;
Options@LstCode={LineLabel->"NoLineLabel"};
LstCode[FullInputCode_,OptionsPattern[]]:=Module[{Expr},

	$ListingsOutput="Line"<>ToString@$LstListingsLine;
	Expr=ToString[FullInputCode];
	Expr=StringReplace[Expr,{"Defer["->""}];
	Expr=StringDrop[Expr,-1];
	Expr=StringReplace[Expr,{"*"->" * "}];
	LstListingCode[Expr,LineLabel->OptionValue@LineLabel];
	$LstListingsLine+=1;
	Expr//SystemTest;
];
