(*===========*)
(*  CLICode  *)
(*===========*)

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
