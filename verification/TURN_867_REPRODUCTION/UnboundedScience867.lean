import SFT.QuantumComputation.UnboundedFaults
import SFT.Host.Canonical
open SFT.QuantumComputation UnboundedFaults ReversibleFaults SFT.Host.Canonical

def trace (d : Nat) := (List.range d).map (fun i => "fault-" ++ toString (i+1))
def strings (xs : List String) : Value := .array (xs.map Value.text)
def resultString (x : Except String String) : Value := match x with
 | .ok s => .object [("ok",.text s)]
 | .error e => .object [("error",.text e)]
def resultNat (x : Except String Nat) : Value := match x with
 | .ok n => .object [("ok",.integer n)]
 | .error e => .object [("error",.text e)]
def resultWords (x : Except String (List String)) : Value := match x with
 | .ok w => .object [("ok",strings w)]
 | .error e => .object [("error",.text e)]
def main : IO Unit := do
 for d in List.range 14 do
  IO.println (render (resultNat (forcedWidth (trace (d+1)))))
 for label in ["held","returned"] do
  for d in [1,2,3] do
   for mask in faultMasks (2*d+1) d do
    let word := changeFrom mask (if label="held" then "returned" else "held") 0 (List.replicate (2*d+1) label)
    IO.println (render (.object [("label",.text label),("depth",.integer d),("mask",.array (mask.map (fun n : Nat => .integer n))),("changed",strings word),("decoded",resultString (UnboundedFaults.decode word))]))
 for d in List.range 14 do
  for i in List.range (2*(d+1)) do
   let word := predecessorWord (i+1)
   IO.println (render (.object [("depth",.integer (d+1)),("width",.integer (i+1)),("changed",strings word),("decoded",resultString (UnboundedFaults.decode word))]))
 for source in SFT.InformationScience.QuantitySupport.words ["held","returned"] 7 do
  IO.println (render (.object [("source",strings source),("changed",.array (source.map (fun label => strings (worstMaskWord label 14 29)))),("recovered",resultWords (recoverWord source 14 29))]))
 for word in [[],["external"],["held","returned"],["held"],["returned"]] do
  IO.println (render (resultString (UnboundedFaults.decode word)))
 for fault in [[],["f","f"],["f"]] do
  IO.println (render (resultNat (forcedWidth fault)))
