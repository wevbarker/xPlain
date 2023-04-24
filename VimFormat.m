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
Cref::usage="Cref";
EqnLabel::usage="EqnLabel";

Begin["VimFormat`Private`"];

Manuscript[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[TextGrid[{{Style["Manuscript",Bold],Expr}},Frame->All],Darker@Green,"Text",Background->Yellow]];

PartIIIProject[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[TextGrid[{{Style["Connection to Part III project",Bold],Expr}},Frame->All],Darker@Green,"Text",Background->Yellow]];

Cref[CellTagName_?StringQ]:={" (",CounterBox["DisplayFormulaNumbered",CellTagName],")"};

Comment[Expr_?ListQ]:=CellPrint@Cell[TextData@Flatten@Expr,Darker@Green,"Text"];

Comment[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,Darker@Green,"Text"]];

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
