(*========*)
(*  Code  *)
(*========*)

SetAttributes[Code,HoldAll];

$PadLength=300;
$BulkLength=1000;
$LstListingsLine=1;

(*SetAttributes[LstListingCode,HoldAll];*)
LstListingCode[InputExpr__]:=Block[{
	FormattedInput,
	ListingsFile,
	Expr},

	Quiet@CreateDirectory[FileNameJoin@{$xPlainWorkingDirectory,"LstListing"}];
	FormattedInput=InputExpr;
	(*FormattedInput=ToString[Unevaluated[InputExpr]~ToString~InputForm];*)
	Run@("rm -rf "<>FileNameJoin@{$xPlainWorkingDirectory,
			"LstListing",$ListingsOutput<>".tex"});
	ListingsFile=OpenAppend[
			FileNameJoin@{$xPlainWorkingDirectory,"LstListing",$ListingsOutput<>".tex"},
			PageWidth->Infinity];

	WriteString[ListingsFile,"In[#]:= "<>FormattedInput<>""];
	(*WriteString[ListingsFile,"In["<>ToString@$LstListingsLine<>"]:= "<>FormattedInput<>""];*)
	Close@ListingsFile;
];

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

RunCode[InputCode_]:=Module[{Expr=InputCode},
	Expr//=Evaluate;
Expr];

CLICode[FullInputCode_]:=Module[{
	LineWidth=60,
	Content,
	ContentWidth},

	Off@Attributes::ssle;
	Content="[displayed code with "<>ToString@LeafCount@(FullInputCode)<>" leaves]";
	ContentWidth=StringLength@Content;
	Content//=StringPadLeft[#,Floor@(ContentWidth+(LineWidth-ContentWidth)/2)]&;
	ContentWidth=StringLength@Content;
	Content//=StringPadRight[#,Floor@(ContentWidth+(LineWidth-ContentWidth)/2)]&;
	Content//=StringPadRight[#,LineWidth]&;
	Content=Content<>"(##)";
	DisplayCLI[Content,StyleCLI->"Code"];
	On@Attributes::ssle;
];

GUICode[FullInputCode_]:=Module[{},

	Off@Attributes::ssle;
	CellPrint@ExpressionCell[FullInputCode,"Input",InitializationCell->False];	
	On@Attributes::ssle;
];

LstCode[FullInputCode_]:=Module[{Expr,ExprLength},
	$ListingsOutput="Line"<>ToString@$LstListingsLine;
	Expr=ToString[FullInputCode];
	Expr=StringReplace[Expr,{"Defer["->""}];
	Expr=StringDrop[Expr,-1];
	Expr=StringReplace[Expr,{"*"->" * "}];
	ExprLength=Expr//StringLength;
	If[ExprLength>(2*$PadLength+$BulkLength),Expr=TakePadding[Expr,$PadLength]<>"(*omitted "<>ToString@(ExprLength-2*$PadLength)<>" characters for brevity*)"<>TakePadding[Expr,-$PadLength]];
	LstListingCode[Expr];
	$LstListingsLine+=1;
	Expr//=(#~StringDelete~" ")&;
	If[(Expr~StringContainsQ~"DefField")||(Expr~StringContainsQ~"DefConstantSymbol"),
		Expr//=(#~StringReplace~{"DefField["->"DefField"})&;
		Expr//=(#~StringReplace~{"DefConstantSymbol["->"DefConstantSymbol"})&;
		Expr//=(#~StringSplit~{"DefField","DefConstantSymbol","[",",","TheoryName->"})&;
		Expr//=First;
	];
	If[(Expr~StringContainsQ~"ParticleSpectrum"),
		Expr//=(#~StringReplace~{"\""->""})&;
		Expr//=(#~StringSplit~{"TheoryName->"})&;
		Expr//=#[[2]]&;
		Expr//=(#~StringSplit~{",","TheoryName->"})&;
		Expr//=First;
	];
	Expr//Print;
];

Code[InputCode_,opts:OptionsPattern[Cell]]:=Code[DummyVar,InputCode,opts];

Code[SomeVar_,InputCode_,opts:OptionsPattern[Cell]]:=Module[{Expr,FullInputCode=Defer@InputForm@InputCode/.OwnValues@SomeVar},

	If[$xPlainCLI,
		FullInputCode//CLICode;
		,
		FullInputCode//GUICode;
		FullInputCode//LstCode;
	];
	Expr=InputCode//RunCode;
Expr];

Code[SomeVar_,SomeOtherVar_,InputCode_,opts:OptionsPattern[Cell]]:=Module[{Expr,FullInputCode=Defer@InputForm@InputCode/.OwnValues@SomeVar/.OwnValues@SomeOtherVar},

	If[$xPlainCLI,
		FullInputCode//CLICode;
		,
		FullInputCode//GUICode;
		FullInputCode//LstCode;
	];
	Expr=InputCode//RunCode;
Expr];
