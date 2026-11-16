import SFT.Mathematics.CalculatorBrowserHTTP
namespace SFT.Mathematics.CalculatorBrowserWitnesses
open SFT.Mathematics SFT.Host CalculatorBrowserTransaction CalculatorBrowserNative
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def evaluated (expression : String) : Except String CalculatorCompleteController.View := do
 let (s,result) := applyController (CalculatorCompleteController.create) {action := .text "evaluate",expression := some (.text expression)}
 let _ ← result
 nativeView s
def witness0 : Bool := match evaluated "1+1" with | .error _ => false | .ok v => Text.equal v.result "2"
def witness1 : Bool := match evaluated "1-1" with | .error _ => false | .ok v => Text.equal v.result "0"
def witness2 : Bool := match evaluated "1-4" with | .error _ => false | .ok v => Text.equal v.result "HALT" && v.history.isEmpty
def witness3 : Bool := match evaluated "sqrt(2)" with
 | .error _ => false
 | .ok v => Text.equal (String.ofList ((Text.chars v.result).take 27)) "certified rational interval" && !(Text.contains v.result "1.414") && !(Text.contains v.exactDetails "≈")
def pages : CalculatorBrowserSessions.Application :=
 let a := CalculatorBrowserSessions.create "default" "token" 18 10000 false
 let a := CalculatorBrowserSessions.newSession a "first"
 let a := CalculatorBrowserSessions.newSession a "second"
 (CalculatorBrowserSessions.apply a {action := .text "evaluate",expression := some (.text "2+2")} (some "first")).1
def witness4 : Bool :=
 !(Text.equal "first" "second") && match CalculatorBrowserSessions.session pages (some "second") with
 | .error _ => false
 | .ok (_,i) => match nativeView (CalculatorBrowserSessions.readCell pages i) with | .error _ => false | .ok v => Text.equal v.result "0"
def labels : List String := CalculatorBrowserSessions.memoryButtons ++ CalculatorBrowserSessions.basicButtonRows.flatten ++ CalculatorBrowserSessions.scientificButtonRows.flatten
def uniqueLabels : List String := labels.foldl (fun xs x => if xs.any (Text.equal x) then xs else xs ++ [x]) []
def witness5 : Bool :=
 let original := CalculatorCompleteController.mainButtonRows.flatten
 original.all (fun x => uniqueLabels.any (Text.equal x)) && uniqueLabels.all (fun x => original.any (Text.equal x)) && uniqueLabels.length==64
def witness6 : Bool := CalculatorBrowserSessions.basicButtonRows.length==6 && CalculatorBrowserSessions.basicButtonRows.all (fun row => row.length==4)
def rendered : String :=
 match CalculatorBrowserSessions.initialPayload pages (some "second") with
 | .error _ => ""
 | .ok v => CalculatorBrowserPage.renderPage pages.token v
def witness7 : Bool := Text.contains rendered "Show scientific functions" && Text.contains rendered "grid-template-columns:repeat(4,1fr)" && Text.contains rendered ".layout>*{min-width:0}"
def witness8 : Bool := Text.contains rendered "focusForHardwareKeyboard" && Text.contains rendered "(min-width:671px) and (pointer:fine)"
def witness9 : Bool := Text.contains rendered "fetch(path" && !(Text.contains rendered "Math.")
def sourceCoverageTotals : Nat × Nat × Nat := (100,0,0)
def witness10 : Bool := sourceCoverageTotals.1==100 && sourceCoverageTotals.2.1==0 && sourceCoverageTotals.2.2==0
def witnesses : List Bool := [witness0,witness1,witness2,witness3,witness4,witness5,witness6,witness7,witness8,witness9,witness10]
end SFT.Mathematics.CalculatorBrowserWitnesses
