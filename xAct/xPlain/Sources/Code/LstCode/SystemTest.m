(*==============*)
(*  SystemTest  *)
(*==============*)

IncludeHeader@"ExportCommand";

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
