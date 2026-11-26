import SFT.Chemistry.MolecularIonizationSource
namespace SFT.Chemistry.MolecularIonizationPrediction
open SFT.Host SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
def predictionMap (output : CapabilityValues.Value) : Except String (List (String × List CapabilityValues.Value)) := do
 let entries ← match output with
  | .table entries => if entries.length==9 then pure entries else throw "PROP-007 prediction is not the complete nine-row table"
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "PROP-007 prediction is not the complete nine-row table"
 let rows ← entries.mapM fun (left,right) => do
  let key ← match left with
   | .label key => if Text.equal key.family "target-id" then pure key.label else throw "PROP-007 prediction lost target identity"
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-007 prediction lost target identity"
  let cells ← match right with
   | .word cells => if cells.length==17 then pure cells else throw "PROP-007 prediction lost complete state custody"
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => throw "PROP-007 prediction lost complete state custody"
  pure (key,cells)
 let keys := rows.map Prod.fst
 if (keys.foldl (fun acc key => if acc.any (Text.equal key) then acc else acc++[key]) []).length != 9 then
  throw "PROP-007 prediction duplicated a target identity"
 pure rows
def predictionAt (rows : List (String × List CapabilityValues.Value)) (target : String) : Except String (List CapabilityValues.Value) :=
 match rows.find? (fun row => Text.equal row.1 target) with
 | some row => pure row.2
 | none => throw (Text.append "KeyError: " target)
def labelMatches (cells : List CapabilityValues.Value) (index : Nat) (value : SFT.Host.Canonical.Value) : Bool :=
 match (cells.drop index).head? with
 | none => false
 | some cell => match cell with
  | .label label => MolecularIonizationExperiment.sameValue (.text label.label) value
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
theorem emptyTableRejected : predictionMap (.table [])=.error "PROP-007 prediction is not the complete nine-row table" := rfl
end SFT.Chemistry.MolecularIonizationPrediction
