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
	ExprLength,
	ListingsFile,
	Expr},

	Quiet@CreateDirectory[FileNameJoin@{$xPlainWorkingDirectory,".LstListing"}];
	FormattedInput=InputExpr;
	ExprLength=FormattedInput//StringLength;
	If[ExprLength>(2*$PadLength+$BulkLength),
		FormattedInput=TakePadding[FormattedInput,$PadLength]<>"(*omitted "<>ToString@(ExprLength-2*$PadLength)<>" characters for brevity*)"<>TakePadding[FormattedInput,-$PadLength]];
	Run@("rm -rf "<>FileNameJoin@{$xPlainWorkingDirectory,
			".LstListing",$ListingsOutput<>".tex"});
	ListingsFile=OpenAppend[
			FileNameJoin@{$xPlainWorkingDirectory,".LstListing",$ListingsOutput<>".tex"},
			PageWidth->Infinity];

	WriteString[ListingsFile,"In[#]:= "<>FormattedInput<>""];
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

$LagrangianCouplingCoefficients=<||>;
$FieldKinematics=<||>;
$ParticleSpectrographs={};

SystemTest[InputExpr_]:=Module[{CommandFileName=InputExpr,CommandContent=InputExpr},
	CommandFileName//=(#~StringDelete~" ")&;
	CommandContent//=(#~StringDelete~" ")&;
	If[(CommandFileName~StringContainsQ~"DefConstantSymbol["),
		CommandFileName//=(#~StringReplace~{"DefConstantSymbol["->"DefConstantSymbol"})&;
		CommandFileName//=(#~StringSplit~{"DefConstantSymbol","[",",","TheoryName->"})&;
		CommandFileName//=First;
		$LagrangianCouplingCoefficients@CommandFileName=CommandContent;
		CommandFileName//=("LagrangianCouplingCoefficient"<>#<>".m")&;
	];
	If[(CommandFileName~StringContainsQ~"DefField["),
		CommandFileName//=(#~StringReplace~{"DefField["->"DefField"})&;
		CommandFileName//=(#~StringSplit~{"DefField","[",",","TheoryName->"})&;
		CommandFileName//=First;
		$FieldKinematics@CommandFileName=CommandContent;
		CommandFileName//=("FieldKinematics"<>#<>".m")&;
	];
	If[(CommandFileName~StringContainsQ~"ParticleSpectrum["),
		CommandFileName//=(#~StringReplace~{"\""->""})&;
		CommandFileName//=(#~StringSplit~{"TheoryName->"})&;
		CommandFileName//=#[[2]]&;
		CommandFileName//=(#~StringSplit~{",","TheoryName->"})&;
		CommandFileName//=First;
		CommandFileName//=("ParticleSpectrograph"<>#<>".m")&;
		CommandContent~ExportCommand~CommandFileName;
	];
CommandFileName];

$SystemTests=Module[{RepositoryName},
	RepositoryName=RunProcess[{"git","rev-parse","--show-toplevel"}];
	RepositoryName//=(#@"StandardOutput")&;
	RepositoryName//Print;
	RepositoryName//=RunProcess[{"basename",#}]&;
	RepositoryName//=(#@"StandardOutput")&;
	RepositoryName//=(#~StringDelete~"\n")&;
	RepositoryName="system-tests-"<>RepositoryName;
	RepositoryName];
Quiet@Run@("rm -rf "<>FileNameJoin@{$xPlainWorkingDirectory,$SystemTests});
Quiet@CreateDirectory[FileNameJoin@{$xPlainWorkingDirectory,$SystemTests}];
ExportCommand[CommandContent_,CommandFileName_]:=Block[{ListingsFile},
	ListingsFile=OpenAppend[
		FileNameJoin@{$xPlainWorkingDirectory,$SystemTests,CommandFileName},
		PageWidth->Infinity];
	WriteString[ListingsFile,"<<xAct`PSALTer`;"<>"\n"];
	If[(CommandContent~StringContainsQ~#),
		WriteString[ListingsFile,$LagrangianCouplingCoefficients[#]<>"\n"];
	]&/@Keys@$LagrangianCouplingCoefficients;
	If[(CommandContent~StringContainsQ~#),
		WriteString[ListingsFile,$FieldKinematics[#]<>"\n"];
	]&/@Keys@$FieldKinematics;
	WriteString[ListingsFile,CommandContent<>"\n"];
	WriteString[ListingsFile,"Quit[];"];
	Close@ListingsFile;
];

LstCode[FullInputCode_]:=Module[{Expr},
	$ListingsOutput="Line"<>ToString@$LstListingsLine;
	Expr=ToString[FullInputCode];
	Expr=StringReplace[Expr,{"Defer["->""}];
	Expr=StringDrop[Expr,-1];
	Expr=StringReplace[Expr,{"*"->" * "}];
	Expr//LstListingCode;
	$LstListingsLine+=1;
	Expr//SystemTest;
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
		If[$Listings,
			FullInputCode//LstCode;
		]
	];
	Expr=InputCode//RunCode;
Expr];
