from pathlib import Path
s='''import SFT.Mathematics.CalculatorCompleteController
namespace SFT.Mathematics.CalculatorBrowserNative
open SFT.Mathematics SFT.Host CalculatorValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def nativeScalar : FoldScalar.Scalar → String
 | .emptyOne => "0"
 | .positive o m =>
  let magnitude := if m.denominator==1 then CalculatorRoots.digits m.numerator else Text.join [CalculatorRoots.digits m.numerator,"/",CalculatorRoots.digits m.denominator]
  match o with | .forward => magnitude | .counter => Text.append "counter-held " magnitude
def nativeValue : Value → String
 | .scalar s => nativeScalar s
 | .interval i => if decide (compareScalar i.lower i.upper = 0) then nativeScalar i.lower
   else Text.join ["certified rational interval [",nativeScalar i.lower,", ",nativeScalar i.upper,"]"]
 | .complex c => Text.join ["Fold fibres (real: ",nativeScalar c.real,"; orthogonal: ",nativeScalar c.orthogonal,")"]
def scalarContainsCounter : FoldScalar.Scalar → Bool
 | .emptyOne => false
 | .positive o _ => match o with | .forward => false | .counter => true
def containsCounter : Value → Bool
 | .scalar s => scalarContainsCounter s
 | .interval i => scalarContainsCounter i.lower || scalarContainsCounter i.upper
 | .complex c => scalarContainsCounter c.real || scalarContainsCounter c.orthogonal
def beforeApprox : List Char → List Char
 | [] => []
 | c::cs => if Text.equal (String.ofList ((c::cs).take 3)) " ≈ " then [] else c::beforeApprox cs
def nativeView (controller : CalculatorCompleteController.State) : Except String CalculatorCompleteController.View := do
 let view ← CalculatorCompleteController.view controller
 let history := controller.session.history.map fun item =>
  let expression := String.ofList (((Text.chars item.expression).reverse.dropWhile (fun c => c == '=')).reverse)
  Text.join [expression,"  =  ",nativeValue item.calculation.value]
 let view := {view with history:=history}
 if !(Text.chars view.error).isEmpty then pure view
 else
  let view := {view with result:=nativeValue controller.session.answer}
  match controller.session.history.getLast? with
  | none => pure view
  | some item =>
   let c := item.calculation
   pure {view with exactDetails:=Text.join ["Exact SFT result\\n",nativeValue c.value,"\\n\\nProof trace\\n",Text.intercalate "\\n" (c.trace.map fun line => String.ofList (beforeApprox (Text.chars line))),"\\n\\nResources\\ntokens: ",CalculatorRoots.digits c.tokensRead,"\\noperations: ",CalculatorRoots.digits c.operationsExecuted]}
def viewValue (v : CalculatorCompleteController.View) : Canonical.Value := .object [
 ("expression",.text v.expression),("result",.text v.result),("exact_details",.text v.exactDetails),("error",.text v.error),("memory_active",.boolean v.memoryActive),("angle_mode",.text v.angleMode),("history",.array (v.history.map Canonical.Value.text))]
end SFT.Mathematics.CalculatorBrowserNative
'''
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');(r/'SFT/Mathematics/CalculatorBrowserNative.lean').write_text(s)
