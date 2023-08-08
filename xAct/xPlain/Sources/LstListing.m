(*==============*)
(*  LstListing  *)
(*==============*)

If[$PaperPrint,
	Quiet@CreateDirectory[FileNameJoin@{NotebookDirectory[],"LstListing"}];
	If[NotebookDirectory[]==$Failed,
		Print[" ** BuildNovel: Purging LstListing directory at "<>FileNameJoin@{NotebookDirectory[],"LstListing/*"}<>"..."];,
		Run@("rm -rf "<>FileNameJoin@{NotebookDirectory[],"LstListing/*"});,
		Run@("rm -rf "<>FileNameJoin@{NotebookDirectory[],"LstListing/*"});
	];
];

$OldLine=$Line;
$SubLine=1;

NovelOutput[x_String]:=Module[{},
	$ListingsOutput=x;
	Run@("rm "<>FileNameJoin@{NotebookDirectory[],"LstListing",$ListingsOutput});
];

SetAttributes[LstListingIn,HoldAll];
LstListingIn[InputExpr__]:=Block[{
	FormattedInput,
	ListingsFile,
	Expr},

	Quiet@CreateDirectory[FileNameJoin@{NotebookDirectory[],"LstListing"}];
	FormattedInput=ToString[Unevaluated[InputExpr]~ToString~InputForm];
	Print@FormattedInput;

	ListingsFile=OpenAppend[
			FileNameJoin@{NotebookDirectory[],"LstListing",$ListingsOutput<>".tex"},
			PageWidth->Infinity];

	WriteString[ListingsFile,"In[]:= "<>FormattedInput<>"\nOut[]= "];
	Close@ListingsFile;
	Expr=Evaluate@InputExpr;
Expr];

LstListingOut[InputExpr__]:=Block[{
	FormattedOutput,
	ListingsFile,
	ChosenImageSize},

	Quiet@CreateDirectory[FileNameJoin@{NotebookDirectory[],"LstListing"}];
	If[$Widetext,ChosenImageSize=(510/246)*350,ChosenImageSize=350];
	FormattedOutput=InputExpr;

	If[$PaperPrint,
		If[$Line==$OldLine,
			$SubLine=$SubLine+1,
			$SubLine=1;
			$OldLine=$Line;
		];

		ListingsFile=OpenAppend[
				FileNameJoin@{NotebookDirectory[],"LstListing",$ListingsOutput<>".tex"},
				PageWidth->Infinity];

		If[{FormattedOutput}~AllTrue~StringQ,
			Print@FormattedOutput;
			WriteString[
				ListingsFile,
				"|\n\\vspace{-10pt}\n|\n"<>""<>StringJoin@{FormattedOutput}<>"\n"];,

			FormattedOutput=Panel[
					Row@{"",FormattedOutput},
					ImageSize->ChosenImageSize,
					Background->RGBColor[0.95,1.,0.8],
					FrameMargins->None,
					ContentPadding->True,
					Alignment->Right];
			Print@FormattedOutput;

			FormattedOutputFileName=$ListingsOutput<>ToString@$OldLine<>"-"<>ToString@$SubLine<>"LstListing.pdf";
			FileNameJoin@{NotebookDirectory[],"LstListing",FormattedOutputFileName}~Export~FormattedOutput;

			WriteString[
				ListingsFile,
				"|\n\\vspace{-4pt}\n\\begin{flushleft}\n\\includegraphics[width=\\linewidth]{LstListing/"<>FormattedOutputFileName<>"}\n\\end{flushleft}\n\\vspace{-5pt}\n|\n"];
		];
		Close@ListingsFile;
	];
];
