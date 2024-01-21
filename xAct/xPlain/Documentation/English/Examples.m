(*============*)
(*  Examples  *)
(*============*)

<<xAct`xPlain`;

Title@"Welcome to the xPlain package, here is a title";
Chapter@"And here is a chapter";
Section@"And here is a section";
Subsection@"And here is a subsection";
Comment@"This is a comment. We will next type a numbered expression.";
Format@xx^=ToExpression@"\[ScriptX]";
DisplayExpression[xx,EqnLabel->"Eq1"];
Comment@"And next we will type a numbered equation.";
DisplayEquation[xx,EqnLabel->"Eq2"];
Comment@{"Here is a comment referring to",Cref@"Eq1",". We can also refer to multiple equations as",Cref@{"Eq1","Eq2"},". You can see that this is a pretty long comment so it will be interesting to see how the line break works in the terminal."};
Supercomment@{"Here is a comment referring to",Cref@"Eq1"," and multiple equations as",Cref@{"Eq1","Eq2"},"."};

Quit[];
