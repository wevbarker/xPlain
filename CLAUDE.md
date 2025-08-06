# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

xPlain is a Wolfram Language/Mathematica package that provides formatting capabilities for mathematical derivations in theoretical physics. It is designed to work both in command-line environments and Mathematica notebooks, allowing users to write plaintext code while maintaining professional mathematical typesetting.

The package is part of the xAct bundle for tensor calculus and general relativity computations in Mathematica.

## Installation and Development

- **Installation**: Use `./install.sh` to install the package to local Mathematica/Wolfram directories
- **Package location**: Core package files are in `xAct/xPlain/`
- **Entry point**: `xAct/xPlain/xPlain.m` is the main package file
- **Kernel initialization**: `xAct/xPlain/Kernel/init.wl` loads the package

## Key Architecture

### Source Organization
- `xAct/xPlain/Sources/`: Contains modular source files for different functionality
  - Sectioning commands: `Title.m`, `Chapter.m`, `Section.m`, `Subsection.m`
  - Display functions: `DisplayExpression.m`, `DisplayEquation.m`
  - Commentary: `Comment.m`, `Supercomment.m`
  - Cross-referencing: `Cref.m`, `Mref.m`
  - Code formatting: `Code.m`, `LstListing.m`
  - Color handling: `Colors.m`
  - CLI display: `DisplayCLI.m`

### Module Loading Pattern
The package uses a dynamic source loading system via `RereadSources[]` function that loads all source modules from the Sources directory. Individual modules can be reloaded during development.

### CLI vs Notebook Detection
The package automatically detects whether it's running in CLI mode (`$xPlainCLI`) or notebook mode and adjusts behavior accordingly. This is handled by checking if `NotebookDirectory[]` is available.

## Testing and Examples

- **Examples**: `xAct/xPlain/Documentation/English/Examples.m` contains usage examples
- **System tests**: Located in `xAct/xPlain/Sources/Code/LstCode/SystemTest.m`
- **Run examples**: Execute Examples.m in Mathematica to see package functionality

## Development Commands

Since this is a Mathematica package, development typically involves:

1. **Testing changes**: Run `Examples.m` in Mathematica to verify functionality
2. **Installation**: Use `./install.sh` to install to system paths
3. **Package reload**: Use `RereadSources[]` within Mathematica to reload source files during development
4. **CLI testing**: Run Wolfram scripts directly from command line to test CLI behavior

## Key Features to Understand

- **Dual output modes**: Package formats output differently for CLI vs notebook interfaces
- **Mathematical formatting**: Extensive use of Wolfram Language formatting for mathematical expressions
- **Cross-referencing system**: Label-based equation and section referencing via `Cref` and `Mref`
- **Modular architecture**: Each formatting function is in its own source file for maintainability