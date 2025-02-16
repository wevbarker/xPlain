(*==================*)
(*  LstListingCode  *)
(*==================*)

IncludeHeader@"TakePadding";

Options@LstListingCode={LineLabel->"NoLineLabel"};
LstListingCode[InputExpr__,OptionsPattern[]]:=Block[{
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
			".LstListing",(OptionValue@LineLabel)<>".tex"});
	ListingsFile=OpenAppend[
			FileNameJoin@{$xPlainWorkingDirectory,".LstListing",(OptionValue@LineLabel)<>".tex"},
			(*FileNameJoin@{$xPlainWorkingDirectory,".LstListing",$ListingsOutput<>".tex"},*)
			PageWidth->Infinity];

	WriteString[ListingsFile,"In[#]:= "<>FormattedInput<>""];
	Close@ListingsFile;
];
