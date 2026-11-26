import SFT.Chemistry.MolecularPolarizabilityPrediction
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Chemistry.MolecularPolarizabilityPrediction
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
def table (n : Nat) (family : String) (width : Nat) (word : Bool) : Except String CapabilityValues.Value := do
 let entries ← (List.range n).mapM fun i => do
  let key ← CapabilityValues.heldLabel family (Text.append "row-" (toString i))
  pure (.label key,
   if word then .word (List.replicate width (.label ⟨"held","value",rfl,rfl⟩)) else .label ⟨"held","wrong",rfl,rfl⟩)
 CapabilityValues.table entries
def result : Except String (List (String × List CapabilityValues.Value)) → Value
 | .error e => .object [("error",.text e)]
 | .ok rows => .object [("ok",.array (rows.map fun (key,word) => .array [.text key,.integer word.length]))]
def main : IO Unit := IO.println (render (.array [
result ((table 252 "target-id" 16 true) >>= predictionMap),
result ((table 0 "target-id" 16 true) >>= predictionMap),
result ((table 251 "target-id" 16 true) >>= predictionMap),
result ((table 253 "target-id" 16 true) >>= predictionMap),
result ((table 252 "other" 16 true) >>= predictionMap),
result ((table 252 "target-id" 15 true) >>= predictionMap),
result ((table 252 "target-id" 17 true) >>= predictionMap),
result ((table 252 "target-id" 16 false) >>= predictionMap),
result (predictionMap (.word [])),
result (predictionMap (.label ⟨"held","value",rfl,rfl⟩))]))
