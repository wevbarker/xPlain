(*==========*)
(*  xPlain  *)
(*==========*)

(*------------------------------*)
(*  Change version number here  *)
(*------------------------------*)

(*
xAct`xPlain`$Version={"0.0.0",{2023,11,4}};
*)
xAct`xPlain`$Version={"0.0.0-developer",DateList@FileDate@$InputFileName~Drop~(-3)};

If[Unevaluated[xAct`xCore`Private`$LastPackage]===xAct`xCore`Private`$LastPackage,xAct`xCore`Private`$LastPackage="xAct`xPlain`"];

(* here is an error-killing line, I can't quite remember why we needed it! *)
Off@(Solve::fulldim);

(*=================*)
(*  xAct`xPlain`  *)
(*=================*)

BeginPackage["xAct`xPlain`",{"xAct`xTensor`"}];

(*========================================================================*)
(*  The output can be long, we prefer to scroll automatically to the end  *)
(*========================================================================*)

SetOptions[$FrontEndSession,EvaluationCompletionAction->"ScrollToOutput"];

Print[xAct`xCore`Private`bars];
Print["Package xAct`xPlain` version ",$Version[[1]],", ",$Version[[2]]];
Print["CopyRight \[Copyright] 2023, Will E. V. Barker and Sebastian Zell, under the General Public License."];

(*-------------------------------------------------------------------*)
(*  Modify the path to accommodate notebook and install directories  *)
(*-------------------------------------------------------------------*)

$Path~AppendTo~NotebookDirectory[];
$xPlainInstallDirectory=Select[FileNameJoin[{#,"xAct/xPlain"}]&/@$Path,DirectoryQ][[1]];

(*--------------*)
(*  Disclaimer  *)
(*--------------*)

If[xAct`xCore`Private`$LastPackage==="xAct`xPlain`",
Unset[xAct`xCore`Private`$LastPackage];
Print[xAct`xCore`Private`bars];
Print["These packages come with ABSOLUTELY NO WARRANTY; for details type Disclaimer[]. This is free software, and you are welcome to redistribute it under certain conditions. See the General Public License for details."];
Print[xAct`xCore`Private`bars]];

Title::usage="Title";
Section::usage="Section";
Subsection::usage="Subsection";

Comment::usage="Comment";
Supercomment::usage="Manuscript";

Kind::usage="Kind";
Cref::usage="Cref";
Mref::usage="Mref";
Inline::usage="Inline";
Mlabel::usage="Mlabel";

DisplayEquation::usage="DisplayEquation";
DisplayExpression::usage="DisplayExpression";
EqnLabel::usage="EqnLabel";

$PaperPrint::usage="$PaperPrint is a global bool.";
$PaperPrint=True;
$Widetext::usage="$Widetext is a global bool.";
$Widetext=True;
$ListingsOutput::usage="$ListingsOutput is a globally-defined string which defines the name associated with the LstListing output.";
LstListingIn::usage="LstListing[Expr_] produces LaTeX listings.";
LstListingOut::usage="LstListing[Expr_] produces LaTeX listings.";

(*legacy*)
PartIIIProject::usage="PartIIIProject";
Manuscript::usage="Manuscript";

NovelOutput::usage="Manuscript";
NovelEcho::usage="Manuscript";
NovelPrint::usage="Manuscript";

Begin["xAct`xPlain`Private`"];

KindAbbr["Equation"]:="Eq.";
KindAbbrs["Equation"]:="Eqs.";
KindAbbr["Table"]:="Table";
KindAbbrs["Table"]:="Tables";
KindAbbr["Figure"]:="Fig.";
KindAbbrs["Figure"]:="Figs.";

Manuscript[Expr_?StringQ]:=Manuscript[{Expr}];
Manuscript[Expr_?ListQ]:=Module[{},
	CellPrint@Cell[TextData@({StyleBox["Concrete relation to manuscript: ",Large,FontWeight->Bold]}~Join~Flatten@Expr),Darker@Green,"Text",Background->Yellow]];

Supercomment[Expr_?StringQ]:=Supercomment[{Expr}];
Supercomment[Expr_?ListQ]:=Module[{},
	CellPrint@Cell[TextData@({StyleBox["Key observation: ",Large,FontWeight->Bold]}~Join~Flatten@Expr),Darker@Green,"Text",Background->Yellow]];

PartIIIProject[Expr_?StringQ]:=PartIIIProject[{Expr}];
PartIIIProject[Expr_?ListQ]:=Module[{},
	CellPrint@Cell[TextData@({StyleBox["Connection to Part III Project: ",Large,FontWeight->Bold]}~Join~Flatten@Expr),Darker@Green,"Text",Background->Yellow]];






Options@Cref={
	Kind->"Equation"
};
Cref[CellTagNameList_?ListQ,OptionsPattern[]]:=Join[{" ",KindAbbrs@OptionValue@Kind},{" (",CounterBox["DisplayFormulaNumbered",#],"),"}&/@Drop[CellTagNameList,-1],{" and (",CounterBox["DisplayFormulaNumbered",CellTagNameList[[-1]]],")"}];
Cref[CellTagName_?StringQ,OptionsPattern[]]:={" ",KindAbbr@OptionValue@Kind," (",CounterBox["DisplayFormulaNumbered",CellTagName],")"};

Options@Mref={
	Kind->"Equation"
};
Mref[ManuscriptEquationLabel_?StringQ,OptionsPattern[]]:=Module[{},{" ",KindAbbr@OptionValue@Kind," (",ToString@(Mlabel@ManuscriptEquationLabel),")"}];

Inline[Expr_]:=Module[{CellToDisplay},	
	(*CellToDisplay=ExpressionCell[Expr,CellContext->"Global`"];*)
	CellToDisplay=Cell[BoxData@MakeBoxes@Expr,CellContext->"Global`"];
{" ",CellToDisplay}];

Comment[Expr_?ListQ]:=CellPrint@Cell[TextData@Flatten@Expr,Darker@Green,"Text",CellContext->"Global`"];
Comment[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,Darker@Green,"Text",CellContext->"Global`"]];

Title[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,40,Darker@Green,Underlined,Bold,"Text"]];

Section[Expr_?ListQ]:=CellPrint@Cell[TextData@Flatten@Expr,30,Darker@Green,Underlined,Bold,"Text",CellContext->"Global`"];
Section[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,30,Darker@Green,Underlined,Bold,"Text"]];

Subsection[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,20,Darker@Green,Underlined,"Text"]];

Options@DisplayEquation={EqnLabel->"NoEquationLabel"};
DisplayEquation[Expr_,OptionsPattern[]]:=CellPrint@ExpressionCell[Expr==0,Background->LightGreen,"DisplayFormulaNumbered",CellTags->OptionValue@EqnLabel];

Options@DisplayExpression={EqnLabel->"NoEquationLabel"};
DisplayExpression[Expr_,OptionsPattern[]]:=CellPrint@ExpressionCell[Expr,Background->LightGreen,"DisplayFormulaNumbered",CellTags->OptionValue@EqnLabel];



BuildPackage[FileName_String]:=Get[FileNameJoin@{$xPlainInstallDirectory,"Sources",FileName}];

(*-------------------------*)
(*  Registry of functions  *)
(*-------------------------*)

BuildPackage/@{
	"LstListing.m"
};

End[];
EndPackage[];
