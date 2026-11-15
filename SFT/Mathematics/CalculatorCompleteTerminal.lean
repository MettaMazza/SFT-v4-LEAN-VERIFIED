import SFT.Mathematics.CalculatorCompleteExplorer
import SFT.Mathematics.CalculatorTerminal
namespace SFT.Mathematics.CalculatorCompleteTerminal
open SFT.Mathematics SFT.Physics SFT.Host
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def printCalculation (c : CalculatorMachine.Calculation) (proof : Bool)
 (rows : Option (List CalculatorCompleteEvidence.CensusRow) := none) : Except String String :=
 if proof then CalculatorCompleteEvidence.calculationEvidenceJSON c rows
 else (CalculatorCompletePresentation.friendly c.value).map (fun s => Text.append s "\n")
structure Result where
 session : CalculatorCompleteSession.Session
 stdout : String := ""
 stderr : String := ""
 exitCode : Option Nat := none
def halt (s : CalculatorCompleteSession.Session) (error : String) (exitCode : Option Nat) : Result :=
 {session:=s,stderr:=Text.join ["Cannot calculate: ",error,"\n"],exitCode:=exitCode}
def oneExpression (s : CalculatorCompleteSession.Session) (input : String) (proof : Bool)
 (rows : Option (List CalculatorCompleteEvidence.CensusRow) := none) : Result :=
 match CalculatorCompleteSession.evaluate s input with
 | .error e => halt s e (some 2)
 | .ok (c,next) => match printCalculation c proof rows with
   | .error e => halt next e (some 2)
   | .ok output => {session:=next,stdout:=output,exitCode:=some 0}
def introduction : String := "Smithian Fold Scientific Calculator. Type 1+1=, :help, or :quit.\n"
def prompt : String := "sft> "
def step (s : CalculatorCompleteSession.Session) (raw : Option String) (proof : Bool)
 (rows : Option (List CalculatorCompleteEvidence.CensusRow) := none) : Result :=
 match raw with
 | none => {session:=s,exitCode:=some 0}
 | some raw =>
  let input := String.ofList (LeptonDecimal.strip (Text.chars raw))
  if [":quit","quit","exit"].any (Text.equal (Text.lowerAscii input)) then {session:=s,exitCode:=some 0}
  else if Text.equal input ":help" then {session:=s,stdout:="Use ordinary calculator expressions. Commands: :rad :deg :grad :mc :mr :ms :m+ :m- :history :clear :quit\n"}
  else if [":rad",":deg",":grad"].any (Text.equal input) then
   let mode := String.ofList ((Text.chars input).drop 1)
   match CalculatorCompleteSession.setAngleMode s mode with
   | .error e => halt s e (some 2)
   | .ok next => {session:=next,stdout:=Text.join ["Angle mode: ",if Text.equal mode "rad" then "RAD" else if Text.equal mode "deg" then "DEG" else "GRAD","\n"]}
  else if Text.equal input ":mc" then {session:=(CalculatorCompleteSession.memoryClear s).2,stdout:="Memory cleared\n"}
  else if Text.equal input ":mr" then {session:=s,stdout:=Text.join ["Memory: ",CalculatorTerminal.memoryText s.memory,"\n"]}
  else if Text.equal input ":ms" then {session:=(CalculatorCompleteSession.memoryStore s).2,stdout:="Memory stored\n"}
  else if Text.equal input ":m+" then
   match CalculatorCompleteSession.memoryAdd s with
   | .error e => halt s e (some 2)
   | .ok (_,next) => {session:=next,stdout:="Memory updated\n"}
  else if Text.equal input ":m-" then
   match CalculatorCompleteSession.memorySubtract s with
   | .error e => halt s e (some 2)
   | .ok (_,next) => {session:=next,stdout:="Memory updated\n"}
  else if Text.equal input ":history" then
   match s.history.mapM (fun item => do
     let display ← CalculatorCompletePresentation.friendly item.calculation.value
     pure (Text.join [CalculatorRoots.digits item.index,": ",item.expression," = ",display,"\n"])) with
   | .error e => halt s e (some 2)
   | .ok output => {session:=s,stdout:=Text.join output}
  else if Text.equal input ":clear" then {session:=CalculatorCompleteSession.allClear (CalculatorCompleteSession.clearHistory s),stdout:="Calculator and history cleared; memory retained\n"}
  else if (Text.chars input).isEmpty then {session:=s}
  else match CalculatorCompleteSession.evaluate s input with
   | .error e => halt s e none
   | .ok (c,next) => match printCalculation c proof rows with
     | .error e => halt next e none
     | .ok output => {session:=next,stdout:=output}
structure Arguments where
 expression : Option String := none
 gui : Bool := false
 terminal : Bool := false
 places : Int := 18
 limit : Int := 10000
 angle : String := "rad"
 proof : Bool := false
 law : Option String := none
 replayLaw : Option String := none
inductive Action where
 | finished (result : Result)
 | gui (places limit : Int)
 | interactive (session : CalculatorCompleteSession.Session) (proof : Bool)
def mainAction (args : Arguments) (explorer : CalculatorCompleteExplorer.Explorer)
 (rows : Option (List CalculatorCompleteEvidence.CensusRow) := none) : Action :=
 let law := args.law.filter (fun s => !(Text.chars s).isEmpty)
 let replay := args.replayLaw.filter (fun s => !(Text.chars s).isEmpty)
 let request := match law with
  | some id => some ((CalculatorCompleteExplorer.summary explorer id).map CalculatorCompleteJSON.document)
  | none => match replay with | some id => some (CalculatorCompleteExplorer.replayJSON explorer id) | none => none
 match request with
 | some (.ok text) => .finished {session:={},stdout:=text,exitCode:=some 0}
 | some (.error error) => .finished (halt {} (CalculatorCompleteController.quoted error) (some 2))
 | none =>
  if args.gui || (args.expression.isNone && !args.terminal) then .gui args.places args.limit
  else match CalculatorCompleteSession.create args.places args.angle args.limit with
   | .error error => .finished (halt {} error (some 2))
   | .ok session => match args.expression with
     | some input => .finished (oneExpression session input args.proof rows)
     | none => .interactive session args.proof
def argumentSchema : Canonical.Value := .object [("prog",.text "sft-calculator"),("description",.text "Familiar scientific calculator with exact Smithian Fold proof output"),("arguments",.array [.object [("name",.text "expression"),("nargs",.text "?"),("help",.text "ordinary calculator expression")],.object [("name",.text "--gui"),("action",.text "store_true"),("help",.text "open the desktop application")],.object [("name",.text "--terminal"),("action",.text "store_true"),("help",.text "open the interactive terminal")],.object [("name",.text "--places"),("type",.text "int"),("default",.integer 18),("help",.text "readable decimal places, from 1 through 60")],.object [("name",.text "--limit"),("type",.text "int"),("default",.integer 10000),("help",.text "positive counted operation boundary")],.object [("name",.text "--angle"),("choices",.array [.text "rad",.text "deg",.text "grad"]),("default",.text "rad")],.object [("name",.text "--proof"),("action",.text "store_true"),("help",.text "print exact JSON proof output")],.object [("name",.text "--law"),("help",.text "explain a registered Mathematics claim")],.object [("name",.text "--replay-law"),("help",.text "locally replay a registered Mathematics enumeration")]])]
end SFT.Mathematics.CalculatorCompleteTerminal
