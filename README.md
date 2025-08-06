![license](https://img.shields.io/github/license/wevbarker/xPlain)
![Mathematica](https://img.shields.io/badge/Mathematica-13.1+-orange.svg)
![xAct](https://img.shields.io/badge/xAct-1.2.0+-green.svg)

<img src="xAct/xPlain/Documentation/English/Examples.png" width="1000">

# _xPlain_: Formatting for Mathematical Derivations in Theoretical Physics
## Version 0.0.0-developer

## License

Copyright © 2023 Will E. V. Barker and Sebastian Zell 

_xPlain_ is distributed as free software under the [GNU General Public License (GPL)](https://www.gnu.org/licenses/gpl-3.0.en.html).

_xPlain_ is provided without warranty, or the implied warranty of merchantibility or fitness for a particular purpose.

If _xPlain_ was useful to your research, please **cite us** using the following _BibTeX_:
```tex
@misc{Barker:2023xPlain,
    author = "Barker, Will E. V. and Zell, Sebastian",
    title = "{xPlain: Formatting for Mathematical Derivations in Theoretical Physics}",
    year = "2023",
    note = "Part of the xAct bundle"
}
```

## About 

_xPlain_ is a software package for _Wolfram_ (formerly _Mathematica_) designed to format mathematical derivations in theoretical physics. It bridges the gap between programmatic computation and professional presentation by enabling both command-line and notebook interfaces while maintaining consistent, paper-quality mathematical typesetting.

The package addresses a fundamental challenge in theoretical physics: how to simultaneously:
- Retain the notebook front-end's mathematical formatting capabilities
- Present calculations with paper-style layout
- Work entirely in plaintext using professional development tools

_xPlain_ is an (unofficial) part of the [xAct bundle](http://www.xact.es/) and implements the [FAIR guiding principles](https://www.go-fair.org/fair-principles/) for scientific data management. It is designed for unambiguous, lasting derivations in the Wolfram Language and is suitable for researchers who use the Wolfram Language programmatically.

The package has been successfully used in [published supplemental materials](https://github.com/wevbarker/SupplementalMaterials-2306), receiving positive feedback from anonymous referees: "_It is remarkable the effort made by the authors with the Supplemental Material to show the connection between the Mathematica code employed for the computations and the statements in the paper._"

## Example: Basic Mathematical Document 

As a demonstration, we consider formatting a simple mathematical derivation with sectioning, commentary, and cross-references.

In a fresh notebook we first load the package:
```mathematica
<<xAct`xPlain`;
```
Next, we create document structure using sectioning commands:
```mathematica
Title@"Welcome to the xPlain package, here is a title";
Chapter@"And here is a chapter";
Section@"And here is a section";
Subsection@"And here is a subsection";
```
We add commentary and define formatted variables:
```mathematica
Comment@"This is a comment. We will next type a numbered expression.";
Format@xx^=ToExpression@"\[ScriptX]";
DisplayExpression[xx,EqnLabel->"Eq1"];
```
For expressions that vanish, use the equation environment:
```mathematica
Comment@"And next we will type a numbered equation.";
DisplayEquation[xx,EqnLabel->"Eq2"];
```
Cross-references are handled automatically:
```mathematica
Comment@{"Here is a comment referring to",Cref@"Eq1",". We can also refer to multiple equations as",Cref@{"Eq1","Eq2"},"."};
Supercomment@{"Here is a comment referring to",Cref@"Eq1"," and multiple equations as",Cref@{"Eq1","Eq2"},"."};
```
The output is shown below:

<img src="xAct/xPlain/Documentation/English/Examples.png" width="1000">

## Documentation

The package includes a comprehensive example notebook demonstrating all basic functionality. To run the examples:
```console
[user@system xPlain]$ cp xAct/xPlain/Documentation/English/Examples.nb ~/Examples.nb
[user@system xPlain]$ cd ~
[user@system ~]$ wolframnb Examples.nb &
```

## General use

### Document Structure

The package provides hierarchical sectioning commands:
- `Title["title text"]` - Document title
- `Chapter["chapter text"]` - Chapter heading 
- `Section["section text"]` - Section heading
- `Subsection["subsection text"]` - Subsection heading

### Commentary and Display

- `Comment["text"]` or `Comment[{"text", Cref["label"], "more text"}]` - Regular commentary with optional cross-references
- `Supercomment[...]` - Emphasized commentary
- `DisplayExpression[expr, EqnLabel->"label"]` - Numbered mathematical expression
- `DisplayEquation[expr, EqnLabel->"label"]` - Numbered equation (implies vanishing)

### Cross-referencing

- `Cref["label"]` - Reference to a single equation
- `Cref[{"label1", "label2"}]` - Reference to multiple equations
- `Mref["label"]` - Alternative reference format

### Mathematical Formatting

Format variables using standard Wolfram Language conventions:
```mathematica
Format@myvar^=ToExpression@"\[ScriptM]";
```

## Quickstart

### Requirements

#### Basic hardware requirements

- A multi-core processor (recommended)
- An internet connection (recommended for package dependencies)

#### Operating systems

- [_Linux_](https://www.linux.org/) (recommended, tested on _Linux v 6.15.8_ via [_Arch_](https://archlinux.org/) and [_Manjaro_](https://manjaro.org/))
- [_macOS_](https://www.apple.com/uk/macos) (tested on _macOS Monterey_)
- [_Windows_](https://www.microsoft.com/en-gb/windows) (tested on _Windows 10_)

#### Software dependencies

- [_Wolfram_ (formerly _Mathematica_)](https://www.wolfram.com/mathematica/) (required, tested on _Wolfram v 13.1.0.0_)
- [_xAct_](http://www.xact.es/) (required, tested on _xAct v 1.2.0_)

### Installation

:warning: Note that _Mathematica_ was re-branded as _Wolfram_ on July 31 2024 with the release of _Wolfram v 14.1_. You may still be able to install _xPlain_ in older versions by replacing `Wolfram` with `Mathematica` in the paths below.

#### _Linux_

1. ***Prepare.*** Make sure your system satisfies all the [requirements](#requirements).
2. ***Download.*** Clone or download the repository:
```console
[user@system ~]$ git clone https://github.com/wevbarker/xPlain
```
3. ***Install.*** Use the provided installation script:
```console
[user@system xPlain]$ ./install.sh
```
Alternatively, manually copy to your xAct installation:
```console
[user@system xPlain]$ cp -r xAct/xPlain ~/.Wolfram/Applications/xAct/
```
For a global installation:
```console
[user@system xPlain]$ sudo cp -r xAct/xPlain /usr/share/Wolfram/Applications/xAct/
```

#### _macOS_

1. ***Prepare.*** Make sure your system satisfies all the [requirements](#requirements).
2. ***Download.*** Clone or download the repository:
```console
user@system ~ % git clone https://github.com/wevbarker/xPlain
```
3. ***Install.*** Copy to your xAct installation:
```console
user@system xPlain % cp -r xAct/xPlain ~/Library/Mathematica/Applications/xAct/
```
For a global installation:
```console
user@system xPlain % sudo cp -r xAct/xPlain /Library/Mathematica/Applications/xAct/
```

#### _Microsoft Windows_

1. ***Prepare.*** Make sure your system satisfies all the [requirements](#requirements).
2. ***Download.*** Clone or download the repository:
```console
C:\Users\user> git clone https://github.com/wevbarker/xPlain
```
3. ***Install.*** Copy to your xAct installation:
```console
C:\Users\user\xPlain> xcopy /e /k /h /i xAct\ "C:\Users\user\AppData\Roaming\Mathematica\Applications\xAct\"
```
For a global installation (run as administrator):
```console
C:\Users\user\xPlain> xcopy /e /k /h /i xAct\ "C:\Program Files\Wolfram Research\Mathematica\14.0\AddOns\Applications\xAct\"
```

## Getting help

There are several ways to get help:
- The [xAct google group](https://groups.google.com/g/xAct) contains a well-established, highly active and very friendly community of researchers. Feel free to start a _New conversation_ by posting a minimal working example of your code.
- For private correspondence, you can email us at [wb263@cam.ac.uk](mailto:wb263@cam.ac.uk).
- You may wish to raise a [_New issue_](https://github.com/wevbarker/xPlain/issues) on _GitHub_.

## Acknowledgements

This work was performed using resources provided by the Cambridge Service for Data Driven Discovery (CSD3) operated by the University of Cambridge Research Computing Service ([www.csd3.cam.ac.uk](www.csd3.cam.ac.uk)), provided by Dell EMC and Intel using Tier-2 funding from the Engineering and Physical Sciences Research Council (capital grant EP/T022159/1), and DiRAC funding from the Science and Technology Facilities Council ([www.dirac.ac.uk](www.dirac.ac.uk)).

I am grateful for the kind hospitality of Leiden University and the [Lorentz Institute](https://www.lorentz.leidenuniv.nl/), and am supported by [Girton College, Cambridge](https://www.girton.cam.ac.uk/).
