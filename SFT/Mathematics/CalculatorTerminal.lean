import SFT.Mathematics.CalculatorGUI
namespace SFT.Mathematics.CalculatorTerminal
open SFT.Mathematics SFT.Physics SFT.Host CalculatorValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Python display representation at the CLI boundary; arithmetic is unchanged.
def scalarRepr : FoldScalar.Scalar → String
 | .emptyOne => "EmptyOne()"
 | .positive held m => Text.join ["FoldScalar(orientation='",(match held with | .forward => "forward-held" | .counter => "counter-held"),"', magnitude=Fraction(",CalculatorRoots.digits m.numerator,", ",CalculatorRoots.digits m.denominator,"))"]
def certificateQuote (text : String) : String :=
 let chars := Text.chars text
 let quote := if chars.any (fun c => c == '\'') && !(chars.any (fun c => c == '"')) then '"' else '\''
 let body := chars.map (fun c => if c == quote then String.ofList ['\\',c] else if c == '\\' then "\\\\" else if c == '\n' then "\\n" else if c == '\r' then "\\r" else if c == '\t' then "\\t" else String.ofList [c])
 Text.join [String.ofList [quote],Text.join body,String.ofList [quote]]
def memoryText : Value → String
 | .scalar .emptyOne => "empty-One"
 | .scalar (.positive held m) => scalarRepr (.positive held m)
 | .complex x => Text.join ["ComplexFibre(real=",scalarRepr x.real,", orthogonal=",scalarRepr x.orthogonal,")"]
 | .interval x =>
  let tuple := Text.join ["(",Text.intercalate ", " (x.certificate.map certificateQuote),(if x.certificate.length == 1 then "," else ""),")"]
  Text.join ["CertifiedInterval(lower=",scalarRepr x.lower,", upper=",scalarRepr x.upper,", certificate=",tuple,")"]
def printResult (calculation : CalculatorMachine.Calculation) (showTrace : Bool) : Except String (List String) := do
 let display ← CalculatorMachine.render calculation
 pure ([display] ++ if showTrace then ["trace:"] ++ calculation.trace.map (Text.append "  ") ++ [Text.join ["resources: tokens=",CalculatorRoots.digits calculation.tokensRead,", operations=",CalculatorRoots.digits calculation.operationsExecuted]] else [])
structure Result where
 session : CalculatorSession.Session
 stdout : List String := []
 stderr : List String := []
 exitCode : Option Nat := none
def halt (s : CalculatorSession.Session) (error : String) (exitCode : Option Nat) : Result :=
 {session := s,stderr := [Text.append "HALT: " error],exitCode := exitCode}
def oneExpression (s : CalculatorSession.Session) (input : String) (showTrace : Bool) : Result :=
 match CalculatorSession.evaluate s input with
 | .error e => halt s e (some 2)
 | .ok (calculation,next) =>
  match printResult calculation showTrace with
  | .error e => halt next e (some 2)
  | .ok lines => {session := next,stdout := lines,exitCode := some 0}
def step (s : CalculatorSession.Session) (input : Option String) (showTrace : Bool) : Result :=
 match input with
 | none => {session := s,exitCode := some 0}
 | some raw =>
  let input := String.ofList (LeptonDecimal.strip (Text.chars raw))
  if ["quit","exit"].any (Text.equal (Text.lowerAscii input)) then {session := s,exitCode := some 0}
  else if Text.equal input ":help" then {session := s,stdout := ["commands: :rad :deg :grad :mc :mr :ms :m+ :m- :history :clear"]}
  else if [":rad",":deg",":grad"].any (Text.equal input) then
   let mode := String.ofList ((Text.chars input).drop 1)
   match CalculatorSession.setAngleMode s mode with
   | .error e => halt s e (some 2)
   | .ok next => {session := next,stdout := [Text.append "angle mode: " (if Text.equal mode "rad" then "RAD" else if Text.equal mode "deg" then "DEG" else "GRAD")]}
  else if Text.equal input ":mc" then {session := (CalculatorSession.memoryClear s).2,stdout := ["memory: empty-One"]}
  else if Text.equal input ":mr" then {session := s,stdout := [Text.append "memory: " (memoryText s.memory)]}
  else if Text.equal input ":ms" then {session := (CalculatorSession.memoryStore s).2,stdout := ["memory stored"]}
  else if Text.equal input ":m+" then
   match CalculatorSession.memoryAdd s with
   | .error e => halt s e (some 2)
   | .ok (_,next) => {session := next,stdout := ["memory updated"]}
  else if Text.equal input ":m-" then
   match CalculatorSession.memorySubtract s with
   | .error e => halt s e (some 2)
   | .ok (_,next) => {session := next,stdout := ["memory updated"]}
  else if Text.equal input ":history" then
   match s.history.mapM (fun item => do
    let display ← CalculatorMachine.render item.calculation
    pure (Text.join [CalculatorRoots.digits item.index,": ",item.expression," = ",display])) with
   | .error e => halt s e (some 2)
   | .ok lines => {session := s,stdout := lines}
  else if Text.equal input ":clear" then {session := CalculatorSession.clearHistory s,stdout := ["history cleared"]}
  else if (Text.chars input).isEmpty then {session := s}
  else match CalculatorSession.evaluate s input with
  | .error e => halt s e none
  | .ok (calculation,next) =>
   match printResult calculation showTrace with
   | .error e => halt next e none
   | .ok lines => {session := next,stdout := lines}
def introduction : String := "SFT exact calculator. Type an expression ending with =, or :help for commands."
def prompt : String := "sft> "
def argumentSchema : Canonical.Value := .object [
 ("prog",.text "python -m sft.mathematics.calculator"),
 ("description",.text "Exact SFT-native scientific calculator"),
 ("arguments",.array [
  .object [("name",.text "expression"),("nargs",.text "?"),("help",.text "expression to evaluate; omit for interactive mode")],
  .object [("name",.text "--places"),("type",.text "int"),("default",.integer 18),("help",.text "decimal projection places (1..60)")],
  .object [("name",.text "--angle"),("choices",.array [.text "rad",.text "deg",.text "grad"]),("default",.text "rad"),("help",.text "angle mode")],
  .object [("name",.text "--trace"),("action",.text "store_true"),("help",.text "print the complete operation trace")],
  .object [("name",.text "--gui"),("action",.text "store_true"),("help",.text "open the desktop calculator app")]])]
end SFT.Mathematics.CalculatorTerminal
