(*=============*)
(*  VimFormat  *)
(*=============*)

BeginPackage["VimFormat`"];

Comment::usage="Comment";
Title::usage="Title";
Section::usage="Section";
Subsection::usage="Subsection";
DisplayEquation::usage="DisplayEquation";
DisplayExpression::usage="DisplayExpression";
PartIIIProject::usage="PartIIIProject";
Manuscript::usage="Manuscript";
Supercomment::usage="Manuscript";
Cref::usage="Cref";
Mref::usage="Mref";
Inline::usage="Inline";
Mlabel::usage="Mlabel";
EqnLabel::usage="EqnLabel";

Begin["VimFormat`Private`"];

Manuscript[Expr_?StringQ]:=Manuscript[{Expr}];
Manuscript[Expr_?ListQ]:=Module[{},
	CellPrint@Cell[TextData@({StyleBox["Concrete relation to manuscript: ",Large,FontWeight->Bold]}~Join~Flatten@Expr),Darker@Green,"Text",Background->Yellow]];

Supercomment[Expr_?StringQ]:=Supercomment[{Expr}];
Supercomment[Expr_?ListQ]:=Module[{},
	CellPrint@Cell[TextData@({StyleBox["Key observation: ",Large,FontWeight->Bold]}~Join~Flatten@Expr),Darker@Green,"Text",Background->Yellow]];

PartIIIProject[Expr_?StringQ]:=PartIIIProject[{Expr}];
PartIIIProject[Expr_?ListQ]:=Module[{},
	CellPrint@Cell[TextData@({StyleBox["Connection to Part III Project: ",Large,FontWeight->Bold]}~Join~Flatten@Expr),Darker@Green,"Text",Background->Yellow]];
(*
PartIIIProject[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[TextGrid[{{Style["Connection to Part III project",Bold],Expr}},Frame->All],Darker@Green,"Text",Background->Yellow]];
*)


Cref[CellTagNameList_?ListQ]:=Join[{" Eqs."},{" (",CounterBox["DisplayFormulaNumbered",#],"),"}&/@Drop[CellTagNameList,-1],{" and (",CounterBox["DisplayFormulaNumbered",CellTagNameList[[-1]]],")"}];

Cref[CellTagName_?StringQ]:={" Eq. (",CounterBox["DisplayFormulaNumbered",CellTagName],")"};
Mref[ManuscriptEquationLabel_?StringQ]:={" Eq. (",ToString@(Mlabel@ManuscriptEquationLabel),")"};
Inline[Expr_]:=Module[{CellToDisplay},	
	(*CellToDisplay=ExpressionCell[Expr,CellContext->"Global`"];*)
	CellToDisplay=Cell[BoxData@MakeBoxes@Expr,CellContext->"Global`"];
{" ",CellToDisplay}];


Comment[Expr_?ListQ]:=CellPrint@Cell[TextData@Flatten@Expr,Darker@Green,"Text",CellContext->"Global`"];
Comment[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,Darker@Green,"Text",CellContext->"Global`"]];

Title[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,40,Darker@Green,Underlined,Bold,"Text"]];

Section[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,30,Darker@Green,Underlined,Bold,"Text"]];

Subsection[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,20,Darker@Green,Underlined,"Text"]];

Options@DisplayEquation={EqnLabel->"NoEquationLabel"};
DisplayEquation[Expr_,OptionsPattern[]]:=CellPrint@ExpressionCell[Expr==0,Background->LightGreen,"DisplayFormulaNumbered",CellTags->OptionValue@EqnLabel];

Options@DisplayExpression={EqnLabel->"NoEquationLabel"};
DisplayExpression[Expr_,OptionsPattern[]]:=CellPrint@ExpressionCell[Expr,Background->LightGreen,"DisplayFormulaNumbered",CellTags->OptionValue@EqnLabel];

End[];
EndPackage[];
