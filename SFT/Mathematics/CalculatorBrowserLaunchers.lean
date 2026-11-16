import SFT.Mathematics.CalculatorBrowserLaunch
namespace SFT.Mathematics.CalculatorBrowserLaunchers
open SFT.Host
inductive Step where
 | changeDirectory (expression : String)
 | command (arguments : List String) (replacesShell : Bool)
 | exit (code : Nat)
def posixLaunch (macOS directoryChangeSucceeded : Bool) : List Step :=
 [.changeDirectory "$SCRIPT_DIR/.."] ++
 if directoryChangeSucceeded then [.command ((if macOS then ["/usr/bin/env"] else []) ++ ["python3","-m","sft.mathematics.calculator_browser"]) true]
 else [.exit 1]
def windowsLaunch (pyExit : Int) : List Step :=
 [.changeDirectory "%~dp0\\..",.command ["py","-3","-m","sft.mathematics.calculator_browser"] false] ++
 if pyExit ≥ 1 then [.command ["python","-m","sft.mathematics.calculator_browser"] false] else []
def sourceFiles : List (String × String) := [("calculator_launchers/Launch Smithian Fold Calculator.command","#!/bin/sh\nSCRIPT_DIR=$(CDPATH= cd -- \"$(dirname -- \"$0\")\" && pwd)\ncd \"$SCRIPT_DIR/..\" || exit 1\nexec /usr/bin/env python3 -m sft.mathematics.calculator_browser\n"),("calculator_launchers/Launch Smithian Fold Calculator.bat","@echo off\ncd /d \"%~dp0\\..\"\npy -3 -m sft.mathematics.calculator_browser\nif errorlevel 1 python -m sft.mathematics.calculator_browser\n"),("calculator_launchers/launch-smithian-fold-calculator.sh","#!/bin/sh\nSCRIPT_DIR=$(CDPATH= cd -- \"$(dirname -- \"$0\")\" && pwd)\ncd \"$SCRIPT_DIR/..\" || exit 1\nexec python3 -m sft.mathematics.calculator_browser\n")]
def argumentSchema : Canonical.Value := .array [(.object [("call",(.text "ArgumentParser")),("args",(.array [])),("kwargs",(.object [("prog",(.text "smithian-fold-calculator")),("description",(.text "Open the dependency-free Smithian Fold scientific calculator"))]))]),(.object [("call",(.text "add_argument")),("args",(.array [(.text "--no-browser")])),("kwargs",(.object [("action",(.text "store_true")),("help",(.text "serve without opening the browser"))]))]),(.object [("call",(.text "add_argument")),("args",(.array [(.text "--private")])),("kwargs",(.object [("action",(.text "store_true")),("help",(.text "limit access to this computer"))]))]),(.object [("call",(.text "add_argument")),("args",(.array [(.text "--port")])),("kwargs",(.object [("type",(.text "int")),("default",(.integer 8765)),("help",(.text "first local port to try"))]))]),(.object [("call",(.text "add_argument")),("args",(.array [(.text "--places")])),("kwargs",(.object [("type",(.text "int")),("default",(.integer 18)),("help",(.text "readable decimal places"))]))]),(.object [("call",(.text "add_argument")),("args",(.array [(.text "--limit")])),("kwargs",(.object [("type",(.text "int")),("default",(.integer 10000)),("help",(.text "positive counted operation boundary"))]))])]
end SFT.Mathematics.CalculatorBrowserLaunchers
