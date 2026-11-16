import SFT.Mathematics.CalculatorBrowserTransport
import SFT.Mathematics.CalculatorCompleteExplorer
namespace SFT.Mathematics.CalculatorBrowserHTTP
open SFT.Host SFT.Mathematics
open CalculatorBrowserSessions CalculatorBrowserTransaction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
mutual
 def jsonBody : Canonical.Value → String
 | .text s => Canonical.quote s
 | .boolean b => if b then "true" else "false"
 | .integer i => String.ofList (if i<0 then '-'::Nat.toDigits 10 i.natAbs else Nat.toDigits 10 i.natAbs)
 | .null => "null"
 | .array xs => Text.join ["[",Text.intercalate ", " (jsonValues xs),"]"]
 | .object xs => Text.join ["{",Text.intercalate ", " ((Canonical.sortFields (jsonFields xs)).map Prod.snd),"}"]
 def jsonValues : List Canonical.Value → List String
 | [] => []
 | x::xs => jsonBody x :: jsonValues xs
 def jsonFields : List (String × Canonical.Value) → List (String × String)
 | [] => []
 | (k,v)::xs => (k,Text.join [Canonical.quote k,": ",jsonBody v]) :: jsonFields xs
end
structure Reply where
 status : Nat
 headers : List (String × String)
 body : String
 shutdown : Bool := false
def sendJSON (v : Canonical.Value) (status : Nat := 200) : Reply :=
 let body := jsonBody v
 ⟨status,CalculatorBrowserTransport.headers "application/json; charset=utf-8" body.toUTF8.size,body,false⟩
def errorJSON (error : String) (status : Nat) : Reply :=
 sendJSON (.object [("ok",.boolean false),("error",.text error)]) status
def field? (fields : List (String × Canonical.Value)) (key : String) : Option Canonical.Value :=
 (fields.find? (fun kv => Text.equal kv.1 key)).map Prod.snd
def field (fields : List (String × Canonical.Value)) (key : String) : Canonical.Value := (field? fields key).getD .null
def inputField : Canonical.Value → Field
 | .text s => .text s
 | .integer i => .integer i
 | .boolean b => .boolean b
 | .null => .other
 | .array _ => .other
 | .object _ => .other
def payload (fields : List (String × Canonical.Value)) : Payload :=
 ⟨inputField (field fields "action"),(field? fields "expression").map inputField,inputField (field fields "label"),inputField (field fields "mode"),inputField (field fields "name"),inputField (field fields "index")⟩
def truthy : Canonical.Value → Bool
 | .null => false
 | .boolean b => b
 | .integer i => !(decide (i=0))
 | .text s => !(Text.chars s).isEmpty
 | .array xs => !xs.isEmpty
 | .object xs => !xs.isEmpty
-- The standard-library isdigit/int/UTF-8/JSON results are host inputs, in source evaluation order.
def readJSON (isDigits : Bool) (length : Except String Int) (decoded : Except String Canonical.Value) : Except String (List (String × Canonical.Value)) := do
 if !isDigits then throw "a counted request length is required"
 let n ← length
 if n<1 || n>65536 then throw "request exceeds the local application boundary"
 let v ← decoded
 match v with
 | .object fields => pure fields
 | .text _ => throw "request must be a JSON object"
 | .integer _ => throw "request must be a JSON object"
 | .boolean _ => throw "request must be a JSON object"
 | .null => throw "request must be a JSON object"
 | .array _ => throw "request must be a JSON object"
def law (explorer : CalculatorCompleteExplorer.Explorer) (id : String) (replay : Bool) : Canonical.Value :=
 let result := if replay then CalculatorCompleteExplorer.replay explorer id else CalculatorCompleteExplorer.summary explorer id
 match result with
 | .ok v => .object [("ok",.boolean true),("content",v)]
 | .error e =>
  let message := match CalculatorCompleteExplorer.spec explorer id with
   | .error _ => CalculatorCompleteController.quoted e
   | .ok _ => e
  .object [("ok",.boolean false),("error",.text message)]
def get (a : Application) (path newId : String) : Application × Except String Reply :=
 if Text.equal path a.entryPath then
  let (a,result) := newPagePayload a newId
  (a,do
    let initial ← result
    let body := CalculatorBrowserPage.renderPage a.token initial
    pure ⟨200,CalculatorBrowserTransport.headers "text/html; charset=utf-8" body.toUTF8.size,body,false⟩)
 else if Text.equal path "/health" then (a,.ok (sendJSON (.object [("ok",.boolean true),("service",.text "smithian-fold-calculator")])))
 else (a,.ok (errorJSON "not found" 404))
def post (a : Application) (explorer : CalculatorCompleteExplorer.Explorer) (path token sessionId : String) (parsed : Except String (List (String × Canonical.Value))) : Application × Except String Reply :=
 if !(Text.equal token a.token) then (a,.ok (errorJSON "local application token rejected" 403))
 else match parsed with
 | .error e => (a,.ok (errorJSON e 400))
 | .ok fields =>
  if Text.equal path "/api/action" then
   let (a,result) := apply a (payload fields) (some sessionId)
   (a,result.map fun v => sendJSON v)
  else if Text.equal path "/api/law" then
   match field fields "claim_id" with
   | .text id => (a,.ok (sendJSON (law explorer id (truthy (field fields "replay")))))
   | .integer _ => (a,.ok (errorJSON "a law identifier is required" 400))
   | .boolean _ => (a,.ok (errorJSON "a law identifier is required" 400))
   | .null => (a,.ok (errorJSON "a law identifier is required" 400))
   | .array _ => (a,.ok (errorJSON "a law identifier is required" 400))
   | .object _ => (a,.ok (errorJSON "a law identifier is required" 400))
  else if Text.equal path "/api/close" then
   let r := sendJSON (.object [("ok",.boolean true),("message",.text "calculator closed")])
   (a,.ok {r with shutdown := true})
  else (a,.ok (errorJSON "not found" 404))
end SFT.Mathematics.CalculatorBrowserHTTP
