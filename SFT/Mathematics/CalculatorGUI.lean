import SFT.Mathematics.CalculatorDisplay
namespace SFT.Mathematics.CalculatorGUI
open SFT.Mathematics SFT.Physics SFT.Host CalculatorValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Original application-owned values; native toolkit state is supplied explicitly.
structure State where
 session : CalculatorSession.Session := {}
 expression : String := ""
 result : String := "0"
 mode : String := "RAD"
 memoryIndicator : String := ""
 cursor : Nat := 0
 selection : Option (Nat × Nat) := none
 historySelection : Option Nat := none
 historyRows : List String := []
 trace : String := ""
 clipboard : String := ""
 focused : Bool := true
def changeMode (s : State) : Except String State := do
 pure {s with session := ← CalculatorSession.setAngleMode s.session (Text.lowerAscii s.mode)}
def insert (s : State) (text : String) : State :=
 let chars := Text.chars s.expression
 let inserted := Text.chars text
 let (first,last) := s.selection.getD (s.cursor,s.cursor)
 {s with expression := String.ofList (chars.take first ++ inserted ++ chars.drop last),cursor := first+inserted.length,focused := true,selection := none}
def setTrace (s : State) (content : String) : State := {s with trace := content}
def clear (s : State) : State := {s with expression := "",result := "0",cursor := 0,selection := none,focused := true}
def clearHistory (s : State) : State := {s with session := CalculatorSession.clearHistory s.session,historyRows := [],historySelection := none}
def restoreHistory (s : State) : Except String State := do
 match s.historySelection with
 | none => pure s
 | some index =>
  match (s.session.history.drop index).head? with
  | none => throw "list index out of range"
  | some entry =>
   let chars := ((Text.chars entry.expression).reverse.dropWhile (fun c => c == '=')).reverse
   pure {s with expression := String.ofList chars,cursor := chars.length,selection := none,focused := true}
def copyResult (s : State) : State := {s with clipboard := s.result}
def evaluate (s : State) : Except String State := do
 let input := String.ofList (LeptonDecimal.strip (Text.chars s.expression))
 if (Text.chars input).isEmpty then pure s else
 match CalculatorSession.evaluate s.session input with
 | .error error => pure (setTrace {s with result := "HALT"} (Text.append "The expression was not admitted.\n\n" error))
 | .ok (calculation,session) =>
  let result ← CalculatorDisplay.friendly calculation.value
  let display ← CalculatorDisplay.friendly calculation.value 10
  let displayInput := String.ofList (((Text.chars calculation.expression).reverse.dropWhile (fun c => c == '=')).reverse)
  let row := Text.join [displayInput,"  =  ",display]
  let exactValue ← CalculatorProjection.valueText calculation.value session.places
  let trace := Text.join ["Exact result\n",exactValue,"\n\nProof trace\n",Text.intercalate "\n" calculation.trace,"\n\nResources\ntokens: ",CalculatorRoots.digits calculation.tokensRead,"\noperations: ",CalculatorRoots.digits calculation.operationsExecuted]
  pure {s with session := session,result := result,historyRows := s.historyRows++[row],trace := trace,expression := "",cursor := 0,selection := none}
def press (s : State) (label : String) : Except String State := do
 if Text.equal label "=" then evaluate s
 else if Text.equal label "C" then pure (clear s)
 else if Text.equal label "⌫" then
  if s.cursor == 0 then pure s else
   let chars := Text.chars s.expression
   pure {s with expression := String.ofList (chars.take (s.cursor-1) ++ chars.drop s.cursor),cursor := s.cursor-1,selection := none}
 else if Text.equal label "±" then
  let chars := LeptonDecimal.strip (Text.chars s.expression)
  let expr := if chars.isEmpty then "-" else Text.join ["-(",String.ofList chars,")"]
  pure {s with expression := expr,cursor := (Text.chars expr).length,selection := none}
 else if Text.equal label "MC" then pure {s with session := (CalculatorSession.memoryClear s.session).2,memoryIndicator := ""}
 else if Text.equal label "MR" then pure (insert s "mem")
 else if Text.equal label "MS" then pure {s with session := (CalculatorSession.memoryStore s.session).2,memoryIndicator := "M"}
 else if Text.equal label "M+" then pure {s with session := (← CalculatorSession.memoryAdd s.session).2,memoryIndicator := "M"}
 else if Text.equal label "M−" then pure {s with session := (← CalculatorSession.memorySubtract s.session).2,memoryIndicator := "M"}
 else if ["sin","cos","tan","asin","acos","atan","sinh","cosh","tanh","ln","log₂","exp","cbrt","floor","ceil","√","1/x","|x|"].any (Text.equal label) && !(LeptonDecimal.strip (Text.chars s.expression)).isEmpty then
  let function := if Text.equal label "log₂" then "log2" else if Text.equal label "√" then "sqrt" else if Text.equal label "1/x" then "recip" else if Text.equal label "|x|" then "abs" else label
  let expr := Text.join [function,"(",s.expression,")"]
  pure {s with expression := expr,cursor := (Text.chars expr).length,selection := none,focused := true}
 else if ["nCr","nPr","gcd","lcm","mod"].any (Text.equal label) && !(LeptonDecimal.strip (Text.chars s.expression)).isEmpty then
  let function := if Text.equal label "nCr" then "ncr" else if Text.equal label "nPr" then "npr" else label
  let expr := Text.join [function,"(",s.expression,","]
  pure {s with expression := expr,cursor := (Text.chars expr).length,selection := none,focused := true}
 else
  match CalculatorDisplay.insertions.find? (fun (key,_) => Text.equal key label) with
  | none => throw (Text.join ["KeyError:",label])
  | some (_,text) => pure (insert s text)
end SFT.Mathematics.CalculatorGUI
