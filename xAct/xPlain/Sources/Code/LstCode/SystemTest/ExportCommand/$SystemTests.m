(*================*)
(*  $SystemTests  *)
(*================*)

$SystemTests=Module[{RepositoryName},
	RepositoryName=RunProcess[{"git","rev-parse","--show-toplevel"}];
	RepositoryName//=(#@"StandardOutput")&;
	RepositoryName//=RunProcess[{"basename",#}]&;
	RepositoryName//=(#@"StandardOutput")&;
	RepositoryName//=(#~StringDelete~"\n")&;
	RepositoryName="system-tests-"<>RepositoryName;
	RepositoryName];

$TestDirectoryFresh=False;
TestDirectoryExistQ[]:=DirectoryQ@FileNameJoin@{$xPlainWorkingDirectory,$SystemTests};
TestDirectoryFreshQ[]:=$TestDirectoryFresh;
TestDirectoryAskedQ[]:=xAct`PSALTer`Private`$SystemTesting;
ReplaceTestDirectory[]:=(
	Quiet@Run@("rm -rf "<>FileNameJoin@{$xPlainWorkingDirectory,$SystemTests});
	Quiet@CreateDirectory[FileNameJoin@{$xPlainWorkingDirectory,$SystemTests}];
);
ReplaceTestDirectoryIfNeeded[]:=(
	If[TestDirectoryExistQ[]&&TestDirectoryAskedQ[]&&!TestDirectoryFreshQ[],
		ReplaceTestDirectory[];
	];
	If[!TestDirectoryExistQ[]&&TestDirectoryAskedQ[],
		ReplaceTestDirectory[];
	];	
	$TestDirectoryFresh=True;
);
