(*========*)
(*  Code  *)
(*========*)

SetAttributes[Code,HoldAll];

$PadLength=100;
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

	WriteString[ListingsFile,"In["<>ToString@$LstListingsLine<>"]:= "<>FormattedInput<>""];
	Close@ListingsFile;
];

TakePadding[InputExpr,PadLength]:=Module[{StringList=StringTake[InputExpr,PadLength]},
	If[PadLength>0,
		StringList//=StringSplit;
		StringList//=Drop[#,-1];
		StringList=(#<>" ")&/@StringList;
		StringList=StringJoin@@StringList;
	,
		StringList//=StringSplit;
		StringList//=Drop[#,1];
		StringList=(" "<>#)&/@StringList;
		StringList=StringJoin@@StringList;
	];	
StringList];

Code[InputCode_,opts:OptionsPattern[Cell]]:=Code[DummyVar,InputCode,opts];

Code[SomeVar_,InputCode_,opts:OptionsPattern[Cell]]:=Module[{
	Expr,
	LineWidth=60,
	Content,
	ContentWidth},

	$ListingsOutput="Line"<>ToString@$LstListingsLine;

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
		Expr=ToString[Defer@InputForm@InputCode/.OwnValues@SomeVar];
		Expr=StringReplace[Expr,{"Defer["->""}];
		Expr=StringReplace[Expr,{"*"->" * "}];
		Expr=StringDrop[Expr,-1];
		ExprLength=Expr//StringLength;
		Print@ExprLength;
		If[ExprLength>(2*$PadLength+$BulkLength),Expr=TakePadding[Expr,$PadLength]<>"(*omitted "<>ToString@(ExprLength-2*$PadLength)<>" characters for brevity*)"<>TakePadding[Expr,-$PadLength]];
		LstListingCode[Expr];
		$LstListingsLine+=1;
		Expr=InputCode;
		Expr//=Evaluate;
		On@Attributes::ssle;
	];
Expr];
