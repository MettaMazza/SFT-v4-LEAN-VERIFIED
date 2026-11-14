import SFT.Computation.NativeCircuitCensus
import SFT.Computation.NativeCircuitDomain
import SFT.Host.Canonical
open SFT.Computation NativeCircuit NativeCircuitCensus SFT.Host.Canonical

def wordValue (w : List String) : Value := .array (w.map Value.text)
def edgeValue (e : Edge) : Value := .array [wordValue e.1,wordValue e.2]
def resourcesValue (r : Nat × Nat × Nat) : Value := .array [.integer r.1,.integer r.2.1,.integer r.2.2]
def main : IO Unit := do
 for e in forcedEdges 14 do
  IO.println (render (.object [("edge",edgeValue e)]))
 for i in List.range 14 do
  IO.println (render (.object [("depth",.integer (i+1)),("resources",resourcesValue (circuitResources (i+1)))]))
 for mask in List.range (2^14) do
  IO.println (render (.object [("mask",.integer mask),("selected",.array ((selectedEdges mask).map edgeValue)),("accepted",.boolean (subsetAdmitted mask))]))
 for d in [-2,-1,0,1,2,14] do
  let value := match NativeCircuitDomain.admittedResources d with
   | .ok r => .object [("ok",resourcesValue r)]
   | .error e => .object [("error",.text e)]
  IO.println (render value)
