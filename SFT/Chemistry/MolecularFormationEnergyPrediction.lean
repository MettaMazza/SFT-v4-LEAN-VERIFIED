import SFT.Chemistry.MolecularFormationEnergySource
namespace SFT.Chemistry.MolecularFormationEnergyPrediction
open SFT.Host SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
def predictionMap (output : CapabilityValues.Value) : Except String (List (String × List CapabilityValues.Value)) := do
 let entries ← match output with
  | .table entries => if entries.length==2098 then pure entries else throw "PROP-013 prediction is not the complete 2,098-cell table"
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "PROP-013 prediction is not the complete 2,098-cell table"
 let rows ← entries.mapM fun (left,right) => do
  let key ← match left with
   | .label key => if Text.equal key.family "target-id" then pure key.label else throw "PROP-013 prediction lost a target identity"
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-013 prediction lost a target identity"
  let cells ← match right with
   | .word cells => if cells.length==13 then pure cells else throw "PROP-013 prediction lost its complete formation carrier"
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => throw "PROP-013 prediction lost its complete formation carrier"
  pure (key,cells)
 let keys := rows.map Prod.fst
 if (keys.foldl (fun acc key => if acc.any (Text.equal key) then acc else acc++[key]) []).length != 2098 then
  throw "PROP-013 prediction duplicated a target identity"
 pure rows
def predictionAt (rows : List (String × List CapabilityValues.Value)) (target : String) : Except String (List CapabilityValues.Value) :=
 match rows.find? (fun row => Text.equal row.1 target) with
 | some row => pure row.2
 | none => throw (Text.append "KeyError: " target)
def labelMatches (cells : List CapabilityValues.Value) (index : Nat) (value : SFT.Host.Canonical.Value) : Bool :=
 match (cells.drop index).head? with
 | none => false
 | some cell => match cell with
  | .label label => MolecularFormationEnergyExperiment.sameValue (.text label.label) value
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
theorem emptyTableRejected : predictionMap (.table [])=.error "PROP-013 prediction is not the complete 2,098-cell table" := rfl
end SFT.Chemistry.MolecularFormationEnergyPrediction
