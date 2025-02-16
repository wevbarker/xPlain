(*=================*)
(*  ExportCommand  *)
(*=================*)

IncludeHeader@"$SystemTests";

ExportCommand[CommandContent_,CommandFileName_]:=Block[{ListingsFile},
	ReplaceTestDirectoryIfNeeded[];
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
