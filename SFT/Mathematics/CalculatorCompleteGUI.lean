import SFT.Mathematics.CalculatorCompleteExplorer
namespace SFT.Mathematics.CalculatorCompleteGUI
open SFT.Mathematics SFT.Host
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure State where
 controller : CalculatorCompleteController.State  :=  {}
 expression : String  :=  ""
 result : String  :=  "0"
 status : String  :=  "Ready"
 mode : String  :=  "RAD"
 memoryIndicator : String  :=  ""
 proofText : String  :=  ""
 lawText : String  :=  ""
 history : List String  :=  []
 detailsVisible : Bool  :=  false
 selectedTab : Option Nat  :=  none
 geometry : String  :=  "760x760"
 detailsButton : String  :=  "Show SFT proof"
 clipboard : String  :=  ""
 cursorAtEnd : Bool  :=  false
 entryFocused : Bool  :=  true
 lawChoice : String  :=  "SFT-MATH-EXACT-ARITHMETIC-001"
def create (places : Int  :=  18) (operationLimit : Int  :=  10000) : State  := 
 {controller  :=  CalculatorCompleteController.create places operationLimit}
def sync (s : State) (view : CalculatorCompleteController.View) : State  := 
 {s with
   expression := view.expression
   result := view.result
   mode := view.angleMode
   memoryIndicator := if view.memoryActive then "M" else "" 
   status := if (Text.chars view.error).isEmpty then "Ready" else Text.append "Cannot calculate: " view.error 
   proofText := view.exactDetails
   history := view.history}
def update (s : State) (controller : CalculatorCompleteController.State) : Except String State  :=  do
 let view ← CalculatorCompleteController.view controller
 pure (sync {s with controller := controller} view)
def toggleDetails (s : State) : State  := 
 let visible  :=  !s.detailsVisible
 {s with detailsVisible := visible, geometry := if visible then "1180x760" else "760x760", detailsButton := if visible then "Hide SFT proof" else "Show SFT proof"}
def showLearn (s : State) : State  := 
 let s  :=  if s.detailsVisible then s else toggleDetails s
 {s with selectedTab := some 4}
def changeMode (s : State) : Except String State  :=  do
 update s (← CalculatorCompleteController.setAngleMode s.controller s.mode)
def press (s : State) (label : String) : Except String State  :=  do
 let controller  :=  CalculatorCompleteController.setExpression s.controller s.expression
 let next ← update s (← CalculatorCompleteController.press controller label)
 pure {next with cursorAtEnd := true, entryFocused := true}
def evaluate (s : State) : Except String State  :=  do
 let controller  :=  CalculatorCompleteController.setExpression s.controller s.expression
 update s (← CalculatorCompleteController.evaluate controller)
def insertCatalog (s : State) (name : String) : Except String State  :=  do
 let controller  :=  CalculatorCompleteController.setExpression s.controller s.expression
 let next ← update s (← CalculatorCompleteController.insertCatalog controller name)
 pure {next with cursorAtEnd := true, entryFocused := true}
def restoreHistory (s : State) (selection : List Int) : Except String State  := 
 match selection with
 | [] => .ok s
 | index::_ => do
  let next ← update s (← CalculatorCompleteController.restoreHistory s.controller index)
  pure {next with cursorAtEnd := true, entryFocused := true}
def clearHistory (s : State) : Except String State  :=  update s (CalculatorCompleteController.clearHistory s.controller)
def copyResult (s : State) : State  :=  {s with clipboard := s.result}
def showLaw (s : State) (explorer : CalculatorCompleteExplorer.Explorer) : Except String State  :=  do
 let summary ← CalculatorCompleteExplorer.summary explorer s.lawChoice
 pure {s with lawText := CalculatorCompleteJSON.pretty 0 summary}
def replayLaw (s : State) (explorer : CalculatorCompleteExplorer.Explorer) : Except String State  :=  do
 let text ← CalculatorCompleteExplorer.replayJSON explorer s.lawChoice
 pure {s with lawText := text}
inductive Launch where
 | run (places operationLimit : Int)
 | halt (error : String)
def launch (tkAvailable : Bool) (places : Int  :=  18) (operationLimit : Int  :=  10000) : Launch  := 
 if tkAvailable then .run places operationLimit else .halt "This Python installation does not include the standard graphical library. The terminal calculator remains available."
def guideText : String := "Use it like the calculator you already know\n\nType an expression or press the number and operation keys, then press = or Enter.\n\nTry these\n  1 + 1 =\n  0.1 + 0.2 =\n  sqrt(2)\n  sin(30) in DEG mode\n  mean(1, 2, 3, 4)\n\nWhat is different about a Smithian Fold result?\n\n• The screen can display 0, but the proof stores the structural empty-One form rather than a numerical zero.\n• A minus sign is represented by a held direction and a positive size; the proof never stores a negative magnitude.\n• A decimal you type is translated into an exact fraction before calculation.\n• Values such as pi, square roots and trigonometric answers remain exact rational lower-and-upper certificates. The large decimal is a friendly view of that proof.\n• A conventional complex value is represented by a real Fold fibre and an orthogonal Fold fibre, not an imaginary proof number.\n• If an expression cannot obey the laws or close inside its counted resources, the calculator stops and explains why. It never hides the problem as NaN or infinity.\n\nNothing advanced is required for ordinary use. Select “Show SFT proof” only when you want the exact value, trace, history, complete function list, or Mathematics law explorer.\n\nMemory\n  MS stores the answer. MR recalls it. M+ and M− change the retained memory. MC clears memory. Ans means the previous answer.\n\nAngle modes\n  RAD uses radians, DEG uses degrees, and GRAD uses gradians.\n"
theorem toggleDetailsPreservesCalculation (s : State) : (toggleDetails s).controller = s.controller := rfl
theorem showLearnPreservesCalculation (s : State) : (showLearn s).controller = s.controller := by
 unfold showLearn
 split <;> rfl
theorem copyResultPreservesCalculation (s : State) : (copyResult s).controller = s.controller := rfl
end SFT.Mathematics.CalculatorCompleteGUI
