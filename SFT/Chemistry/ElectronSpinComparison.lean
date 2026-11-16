import SFT.Chemistry.ElectronSpinPrediction
namespace SFT.Chemistry.ElectronSpinComparison
open SFT.Host SFT.Physics.CapabilityValues ElectronCountSpin ElectronSpinPrediction
abbrev J := SFT.Host.Canonical.Value
def predictionKey : Value → Except String String
 | .label key => if Text.equal key.family "molecular-row" then .ok key.label else .error "ELEC-002 prediction key is invalid"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "ELEC-002 prediction key is invalid"
def countParity (a b : Value) : Except String (PositiveCount × HeldLabel) :=
 match a with
 | .count count => match b with
   | .label parity => if Text.equal parity.family "spin-width-parity" then .ok (count,parity)
     else .error "ELEC-002 prediction value left the exact Fold domain"
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "ELEC-002 prediction value left the exact Fold domain"
 | .emptyOne _ | .label _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "ELEC-002 prediction value left the exact Fold domain"
def predictionValue : Value → Except String (PositiveCount × HeldLabel)
 | .word cells => match cells with
   | [] => .error "ELEC-002 prediction value is invalid"
   | a::rest => match rest with
     | [] => .error "ELEC-002 prediction value is invalid"
     | b::tail => match tail with
       | [] => countParity a b
       | _::_ => .error "ELEC-002 prediction value is invalid"
 | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => .error "ELEC-002 prediction value is invalid"
def insertPrediction (rows : List (String × (PositiveCount × HeldLabel)))
 (key : String) (value : PositiveCount × HeldLabel) :=
 if rows.any (fun row => Text.equal row.1 key) then
  rows.map (fun row => if Text.equal row.1 key then (key,value) else row)
 else rows++[(key,value)]
def predictions : Value → Except String (List (String × (PositiveCount × HeldLabel)))
 | .table entries => do
  if entries.length != 22 then throw "ELEC-002 did not emit the complete prediction table"
  let rows ← entries.foldlM (fun rows (key,value) => do
   let name ← predictionKey key
   let prediction ← predictionValue value
   return insertPrediction rows name prediction) []
  if rows.length != 22 then throw "ELEC-002 prediction table contains duplicate rows"
  return rows
 | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => .error "ELEC-002 did not emit the complete prediction table"
def termWidth (a b : Value) : Except String (HeldLabel × PositiveCount) :=
 match a with
 | .label term => match b with
   | .count width => .ok (term,width)
   | .emptyOne _ | .label _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "released NIST state term or width is invalid"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "released NIST state term or width is invalid"
def releasedValue : Value → Except String (HeldLabel × PositiveCount)
 | .word cells => match cells with
   | [] => .error "released NIST target is invalid"
   | a::rest => match rest with
     | [] => .error "released NIST target is invalid"
     | b::tail => match tail with
       | [] => termWidth a b
       | _::_ => .error "released NIST target is invalid"
 | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => .error "released NIST target is invalid"
def multiplicityValue : CountOrEmpty → J
 | .emptyOne _ => .text "empty-One"
 | .count n => .integer (.ofNat n.value)
structure Comparison where
 rowId : String
 formula : String
 chargeAction : String
 count : PositiveCount
 parity : HeldLabel
 term : HeldLabel
 width : PositiveCount
 pairs : CountOrEmpty
 unmatched : CountOrEmpty
 passed : Bool
def compare (input : InputRow) (formula sourceTerm : String)
 (prediction : PositiveCount × HeldLabel) (released : Value) : Except String Comparison := do
 let exact ← exactElectronCount input.populations input.transfer
 let (term,width) ← releasedValue released
 let measuredParity ← heldLabel "spin-width-parity" (if width.value%2 != 0 then "odd-positive-width" else "even-positive-width")
 let organization ← buildCompleteSpinOrganization input.rowId prediction.1 width
 let passed := prediction.1.value==exact.value && sameLabel prediction.2 measuredParity &&
  organization.electronCount.value==prediction.1.value && Text.equal sourceTerm term.label
 return ⟨input.rowId,formula,input.transfer.action.label,prediction.1,prediction.2,term,width,
  organization.complementaryPairCount,organization.unmatchedFibreCount,passed⟩
def comparisonValue (row : Comparison) : J := .object [
 ("row_id",.text row.rowId),("formula",.text row.formula),("charge_action",.text row.chargeAction),
 ("predicted_electron_count",.integer (.ofNat row.count.value)),("predicted_width_parity",.text row.parity.label),
 ("measured_NIST_X_state",.text row.term.label),("measured_multiplicity",.integer (.ofNat row.width.value)),
 ("complementary_pair_count",multiplicityValue row.pairs),("unmatched_fibre_count",multiplicityValue row.unmatched),
 ("passed",.boolean row.passed)]
def adverseControls (first : InputRow) (comparisonsCount referencesCount : Nat)
 (actualSnapshotHash tamperedSnapshotHash registeredSnapshotHash : String) : Except String (List (String × Bool)) := do
 let original ← exactElectronCount first.populations first.transfer
 let transfer : HeldChargeTransfer := ⟨← heldLabel "electron-transfer" "remove-electron",.count (← count 1)⟩
 let tampered ← exactElectronCount first.populations transfer
 let incompatible := match buildCompleteSpinOrganization "tampered-width" ⟨14,by decide⟩ ⟨2,by decide⟩ with
  | .error _ => true
  | .ok _ => false
 return [("tampered_charge_rejected",tampered.value != original.value),
  ("tampered_multiplicity_parity_rejected",incompatible),
  ("omitted_row_rejected",comparisonsCount-1 != referencesCount),
  ("tampered_snapshot_hash_rejected",Text.equal actualSnapshotHash registeredSnapshotHash && !Text.equal tamperedSnapshotHash registeredSnapshotHash),
  ("all_registered_rows_retained",comparisonsCount==referencesCount && referencesCount==22)]
end SFT.Chemistry.ElectronSpinComparison
