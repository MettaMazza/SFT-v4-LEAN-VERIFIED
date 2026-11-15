import SFT.Mathematics.CalculatorBrowserTransaction
import SFT.Mathematics.CalculatorCompleteCatalog
namespace SFT.Mathematics.CalculatorBrowserSessions
open SFT.Mathematics SFT.Host CalculatorBrowserTransaction CalculatorBrowserNative
def memoryButtons : List String := ["MC", "MR", "M+", "M−", "MS"]
def basicButtonRows : List (List String) := [["%", "CE", "C", "⌫"], ["1/x", "x²", "√", "÷"], ["7", "8", "9", "×"], ["4", "5", "6", "−"], ["1", "2", "3", "+"], ["±", "0", ".", "="]]
def scientificButtonRows : List (List String) := [["sin", "cos", "tan", "π", "e"], ["asin", "acos", "atan", "(", ")"], ["sinh", "cosh", "tanh", "φ", "exp"], ["asinh", "acosh", "atanh", "ln", "log"], ["log₂", "cbrt", "xʸ", "n!", "nCr"], ["nPr", "Ans", "floor", "ceil", "|x|"], ["gcd", "lcm", "mod", "root", "empty"]]
-- Heap cells retain Python object aliasing, including a repeated host-generated session id.
structure Application where
 places : Int := 18
 operationLimit : Int := 10000
 share : Bool := true
 token : String := ""
 entryPath : String := "/"
 networkUrl : String := ""
 defaultSessionId : String
 cells : List Controller
 sessions : List (String × Nat)
def create (sessionId token : String) (places : Int := 18) (operationLimit : Int := 10000) (share : Bool := true) : Application :=
 {places := places,operationLimit := operationLimit,share := share,token := token,defaultSessionId := sessionId,cells := [CalculatorCompleteController.create places operationLimit],sessions := [(sessionId,0)]}
def findCell (a : Application) (id : String) : Option Nat :=
 (a.sessions.find? (fun x => Text.equal x.1 id)).map Prod.snd
def readCell (a : Application) (i : Nat) : Controller :=
 (a.cells.drop i).headD (CalculatorCompleteController.create a.places a.operationLimit)
def writeCell (a : Application) (i : Nat) (s : Controller) : Application :=
 {a with cells := a.cells.take i ++ [s] ++ a.cells.drop (i+1)}
def newSession (a : Application) (id : String) : Application :=
 let cells := a.cells ++ [CalculatorCompleteController.create a.places a.operationLimit]
 let sessions := if a.sessions.any (fun x => Text.equal x.1 id) then
  a.sessions.map (fun x => if Text.equal x.1 id then (id,a.cells.length) else x)
  else a.sessions ++ [(id,a.cells.length)]
 {a with cells := cells,sessions := sessions}
def session (a : Application) (id : Option String := none) : Except String (String × Nat) :=
 let selected := id.getD a.defaultSessionId
 match findCell a selected with
 | none => .error "the calculator session is not retained"
 | some i => .ok (selected,i)
def fallbackCell (a : Application) (id : Option String) : Nat :=
 let chosen := match id with | none => a.defaultSessionId | some s => if (Text.chars s).isEmpty then a.defaultSessionId else s
 (findCell a chosen).getD 0
def initialPayload (a : Application) (id : Option String := none) : Except String Canonical.Value := do
 let (selected,i) ← session a id
 let v ← nativeView (readCell a i)
 pure (.object [("view",viewValue v),("session_id",.text selected),
  ("buttons",.array (CalculatorCompleteController.mainButtonRows.map fun row => .array (row.map Canonical.Value.text))),
  ("memory_buttons",.array (memoryButtons.map Canonical.Value.text)),
  ("basic_buttons",.array (basicButtonRows.map fun row => .array (row.map Canonical.Value.text))),
  ("scientific_buttons",.array (scientificButtonRows.map fun row => .array (row.map Canonical.Value.text))),
  ("functions",.array (CalculatorCompleteController.functionCatalog.map fun (x,y,z) => .array [.text x,.text y,.text z])),
  ("laws",.array (CalculatorCompleteCatalog.specs.map fun spec => .text spec.claimId)),
  ("network_url",.text a.networkUrl)])
def newPagePayload (a : Application) (id : String) : Application × Except String Canonical.Value :=
 let next := newSession a id
 (next,initialPayload next (some id))
def apply (a : Application) (p : Payload) (id : Option String := none) : Application × Except String Canonical.Value :=
 match session a id with
 | .error e => (a,response (readCell a (fallbackCell a id)) (.error e))
 | .ok (_,i) =>
  let (next,outcome) := applyController (readCell a i) p
  let a := writeCell a i next
  match outcome with
  | .ok _ => (a,response next outcome)
  | .error _ => (a,response (readCell a (fallbackCell a id)) outcome)
end SFT.Mathematics.CalculatorBrowserSessions
