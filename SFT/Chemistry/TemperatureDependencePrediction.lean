import SFT.Chemistry.TemperatureDependenceSource
namespace SFT.Chemistry.TemperatureDependencePrediction
open SFT.Host SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
def predictionMap (output : CapabilityValues.Value) : Except String (List (String × List CapabilityValues.Value)) := do
 let entries ← match output with
  | .table entries => if entries.length==19 then pure entries else throw "KIN-003 prediction is not the complete nineteen-target table"
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "KIN-003 prediction is not the complete nineteen-target table"
 let rows ← entries.mapM fun (left,right) => do
  let key ← match left with
   | .label key => if Text.equal key.family "target-id" then pure key.label else throw "KIN-003 prediction lost a complete consequence"
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "KIN-003 prediction lost a complete consequence"
  let cells ← match right with
   | .word cells => if cells.length==9 then pure cells else throw "KIN-003 prediction lost a complete consequence"
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => throw "KIN-003 prediction lost a complete consequence"
  pure (key,cells)
 let keys := rows.map Prod.fst
 if (keys.foldl (fun acc key => if acc.any (Text.equal key) then acc else acc++[key]) []).length != 19 then
  throw "KIN-003 duplicated a target identity"
 pure rows
def predictionAt (rows : List (String × List CapabilityValues.Value)) (target : String) : Except String (List CapabilityValues.Value) :=
 match rows.find? (fun row => Text.equal row.1 target) with
 | some row => pure row.2
 | none => throw (Text.append "KeyError: " target)
def labelMatches (cells : List CapabilityValues.Value) (index : Nat) (value : SFT.Host.Canonical.Value) : Bool :=
 match (cells.drop index).head? with
 | none => false
 | some cell => match cell with
  | .label label => TemperatureDependenceExperiment.sameValue (.text label.label) value
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
theorem emptyTableRejected : predictionMap (.table [])=.error "KIN-003 prediction is not the complete nineteen-target table" := rfl
end SFT.Chemistry.TemperatureDependencePrediction
