import SFT.Chemistry.DihedralTorsionSource
namespace SFT.Chemistry.DihedralTorsionPrediction
open SFT.Host SFT.Physics DihedralTorsion
structure Prediction where
 targetId : String
 species : String
 state : String
 torsionLabel : String
 rotorType : String
 orientation : String
 atoms : List String
 coordinateForm : String
 stateLaw : String
 barrierLaw : String
 position : Nat
 sectorCount : Nat
 coordinate : Height
def cellAt (cells : List CapabilityValues.Value) (n : Nat) : Except String CapabilityValues.Value :=
 match (cells.drop n).head? with
 | none => throw "PROP-004 prediction state word is incomplete"
 | some value => pure value
def labelValue : CapabilityValues.Value → Except String CapabilityValues.HeldLabel
 | .label label => pure label
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-004 prediction state word is incomplete"
def countValue : CapabilityValues.Value → Except String Nat
 | .count count => pure count.value
 | .emptyOne _ | .label _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-004 prediction lost positive path support"
def heightValue : CapabilityValues.Value → Except String Height
 | .ratio n d => pure (.ratio ⟨n,d⟩)
 | .emptyOne id => pure (if Text.equal id "empty-One" then .emptyOne else .otherEmptyOne id)
 | .count _ | .label _ | .word _ | .pair _ _ | .table _ => throw "PROP-004 prediction coordinate is outside the exact Fold domain"
def predictionMap (output : CapabilityValues.Value) : Except String (List Prediction) := do
 let entries ← match output with
  | .table entries => if entries.length==50 then pure entries else throw "PROP-004 prediction is not the complete fifty-row table"
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "PROP-004 prediction is not the complete fifty-row table"
 let rows ← entries.mapM fun (left,right) => do
  let key ← match left with
   | .label key => if Text.equal key.family "target-id" then pure key else throw "PROP-004 prediction lost a target identity or state word"
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-004 prediction lost a target identity or state word"
  let cells ← match right with
   | .word cells => pure cells
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => throw "PROP-004 prediction lost a target identity or state word"
  if cells.length != 17 then throw "PROP-004 prediction state word is incomplete"
  let _ ← ((cells.drop 1).take 13).mapM labelValue
  let position ← cellAt cells 14 >>= countValue
  let sectors ← cellAt cells 15 >>= countValue
  let coordinate ← cellAt cells 16 >>= heightValue
  let labels ← ((cells.drop 2).take 12).mapM fun value => do
   let label ← labelValue value
   pure label.label
  pure (⟨key.label,labels.headD "",(labels.drop 1).headD "",(labels.drop 2).headD "",
   (labels.drop 3).headD "",(labels.drop 4).headD "",(labels.drop 5).take 4,
   (labels.drop 9).headD "",(labels.drop 10).headD "",(labels.drop 11).headD "",
   position,sectors,coordinate⟩ : Prediction)
 let keys := rows.map Prediction.targetId
 if (keys.foldl (fun acc key => if acc.any (Text.equal key) then acc else acc++[key]) []).length != 50 then
  throw "PROP-004 prediction contains duplicate target identities"
 pure rows
def predictionAt (rows : List Prediction) (target : String) : Except String Prediction :=
 match rows.find? (fun row => Text.equal row.targetId target) with
 | some row => pure row
 | none => throw (Text.append "KeyError: " target)
theorem emptyTableRejected : predictionMap (.table []) = .error "PROP-004 prediction is not the complete fifty-row table" := rfl
end SFT.Chemistry.DihedralTorsionPrediction
