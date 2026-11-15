import SFT.Mathematics.CalculatorCompleteTerminal
namespace SFT.Mathematics.CalculatorCompleteLaunchers
open SFT.Host
inductive Step where
 | changeDirectory (expression : String)
 | command (arguments : List String) (replacesShell : Bool)
 | exit (code : Nat)
def posixLaunch (directoryChangeSucceeded : Bool) : List Step :=
 [.changeDirectory "$SCRIPT_DIR/.."] ++
 if directoryChangeSucceeded then [.command ["python3","-m","sft.mathematics.calculator_complete","--gui"] true]
 else [.exit 1]
def windowsLaunch (pyExit : Int) : List Step :=
 [.changeDirectory "%~dp0\\..",.command ["py","-3","-m","sft.mathematics.calculator_complete","--gui"] false] ++
 if pyExit ≥ 1 then [.command ["python","-m","sft.mathematics.calculator_complete","--gui"] false] else []
def sourceFiles : List (String × String) := [("launchers/Launch Smithian Calculator.command","#!/bin/sh\nSCRIPT_DIR=$(CDPATH= cd -- \"$(dirname -- \"$0\")\" && pwd)\ncd \"$SCRIPT_DIR/..\" || exit 1\nexec python3 -m sft.mathematics.calculator_complete --gui\n"),("launchers/Launch Smithian Calculator.bat","@echo off\ncd /d \"%~dp0\\..\"\npy -3 -m sft.mathematics.calculator_complete --gui\nif errorlevel 1 python -m sft.mathematics.calculator_complete --gui\n"),("launchers/launch-smithian-calculator.sh","#!/bin/sh\nSCRIPT_DIR=$(CDPATH= cd -- \"$(dirname -- \"$0\")\" && pwd)\ncd \"$SCRIPT_DIR/..\" || exit 1\nexec python3 -m sft.mathematics.calculator_complete --gui\n")]
end SFT.Mathematics.CalculatorCompleteLaunchers
