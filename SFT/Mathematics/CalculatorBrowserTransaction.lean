import SFT.Mathematics.CalculatorBrowserNative
namespace SFT.Mathematics.CalculatorBrowserTransaction
open SFT.Mathematics SFT.Host CalculatorValues CalculatorBrowserNative
abbrev Controller := CalculatorCompleteController.State
-- Source payload tests distinguish strings, integers (including Python bool), and other values.
inductive Field where
 | text : String → Field
 | integer : Int → Field
 | boolean : Bool → Field
 | other : Field
structure Payload where
 action : Field := .other
 expression : Option Field := none
 label : Field := .other
 mode : Field := .other
 name : Field := .other
 index : Field := .other
structure Snapshot where
 expression : String
 result : String
 exactDetails : String
 error : String
 justEvaluated : Bool
 answer : Value
 memory : Value
 history : List CalculatorCompleteSession.HistoryEntry
 angleMode : String
def snapshot (s : Controller) : Snapshot :=
 ⟨s.expression,s.result,s.exactDetails,s.error,s.justEvaluated,s.session.answer,s.session.memory,s.session.history,s.session.angleMode⟩
def restore (s : Controller) (v : Snapshot) : Controller :=
 {s with expression := v.expression
         result := v.result
         exactDetails := v.exactDetails
         error := v.error
         justEvaluated := v.justEvaluated
         session := {s.session with answer := v.answer
                                    memory := v.memory
                                    history := v.history
                                    angleMode := v.angleMode}}
def stateHasCounter (s : Controller) : Bool :=
 containsCounter s.session.answer || containsCounter s.session.memory || s.session.history.any (fun h => containsCounter h.calculation.value)
def fieldText (f : Field) (error : String) : Except String String :=
 match f with | .text s => .ok s | .integer _ => .error error | .boolean _ => .error error | .other => .error error
def fieldIndex : Field → Except String Int
 | .integer i => .ok i
 | .boolean b => .ok (if b then 1 else 0)
 | .text _ => .error "a counted history position is required"
 | .other => .error "a counted history position is required"
def actionIs (p : Payload) (s : String) : Bool :=
 match p.action with | .text a => Text.equal a s | .integer _ => false | .boolean _ => false | .other => false
def edit (s : Controller) (p : Payload) : Except String Controller := do
 match p.expression with
 | none => pure s
 | some f => pure (CalculatorCompleteController.setExpression s (← fieldText f "the editable expression must be text"))
def dispatch (s : Controller) (p : Payload) : Except String Controller := do
 if actionIs p "state" then pure s
 else if actionIs p "evaluate" then CalculatorCompleteController.evaluate s
 else if actionIs p "press" then CalculatorCompleteController.press s (← fieldText p.label "a calculator control label is required")
 else if actionIs p "mode" then CalculatorCompleteController.setAngleMode s (← fieldText p.mode "an angle mode is required")
 else if actionIs p "function" then CalculatorCompleteController.insertCatalog s (← fieldText p.name "a function name is required")
 else if actionIs p "history" then CalculatorCompleteController.restoreHistory s (← fieldIndex p.index)
 else if actionIs p "clear_history" then pure (CalculatorCompleteController.clearHistory s)
 else throw "unknown calculator application action"
def rejectCounter (s : Controller) (v : Snapshot) (p : Payload) : Controller :=
 let attempted := if !(Text.chars s.expression).isEmpty then s.expression else
  match p.expression with
  | none => ""
  | some f => match f with | .text x => x | .integer _ => "" | .boolean _ => "" | .other => ""
 let restored := restore s v
 {restored with expression := attempted
                result := "HALT"
                error := "result crosses below structural empty One; negative and counter-held numeric results are outside the admitted calculator domain"
                exactDetails := "The attempted result was rejected before admission to answer, memory or history."
                justEvaluated := false}
-- Error return retains the expression edit made before the source action dispatch.
def applyController (s : Controller) (p : Payload) : Controller × Except String Unit :=
 match edit s p with
 | .error e => (s,.error e)
 | .ok edited =>
  match dispatch edited p with
  | .error e => (edited,.error e)
  | .ok changed =>
   let result := if !(actionIs p "state") && stateHasCounter changed then rejectCounter changed (snapshot edited) p else changed
   (result,.ok ())
def response (s : Controller) (outcome : Except String Unit) : Except String Canonical.Value := do
 let v ← nativeView s
 match outcome with
 | .ok _ => pure (.object [("ok",.boolean true),("view",viewValue v)])
 | .error e => pure (.object [("ok",.boolean false),("error",.text e),("view",viewValue v)])
end SFT.Mathematics.CalculatorBrowserTransaction
