import SFT.Chemistry.MolecularDipoleMagnitudeSource
namespace SFT.Chemistry.MolecularDipoleMagnitudePrediction
open SFT.Host SFT.Physics MolecularDipoleMagnitude
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def labelValue : CapabilityValues.Value → Except String CapabilityValues.HeldLabel
 | .label value => pure value
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-005 structural word is incomplete"
def cellAt (cells : List CapabilityValues.Value) (index : Nat) : Except String CapabilityValues.Value :=
 match (cells.drop index).head? with
 | none => throw "PROP-005 structural word is incomplete"
 | some value => pure value
def axisLabels (tail : List CapabilityValues.Value) : Except String (List String) := do
 if tail.length==1 && tail.all (fun value => match value with
  | .emptyOne id => Text.equal id "empty-One"
  | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => false) then pure []
 else tail.mapM fun value => match value with
  | .label axis => if Text.equal axis.family "dipole-axis" then pure axis.label else throw "PROP-005 component-axis support changed"
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-005 component-axis support changed"
def validateStructuralPrediction (output : CapabilityValues.Value) : Except String Unit := do
 let entries ← match output with
  | .table entries => if entries.length==5 then pure entries else throw "PROP-005 value-free structural prediction is incomplete"
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "PROP-005 value-free structural prediction is incomplete"
 let observed ← entries.mapM fun (left,right) => do
  let key ← match left with
   | .label key => if Text.equal key.family "molecular-species" then pure key else throw "PROP-005 structural relation lost its molecular identity"
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-005 structural relation lost its molecular identity"
  let cells ← match right with
   | .word cells => pure cells
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => throw "PROP-005 structural relation lost its molecular identity"
  if cells.length<10 then throw "PROP-005 structural word is incomplete"
  let _ ← ((cells.drop 1).take 8).mapM labelValue
  let symmetry ← cellAt cells 5 >>= labelValue
  let magnitudeClass ← cellAt cells 6 >>= labelValue
  let axes ← axisLabels (cells.drop 9)
  pure (key.label,symmetry.label,magnitudeClass.label,axes)
 let supportMatches := MolecularDipoleMagnitudeSource.sameKeys (observed.map Prod.fst) (registeredCarriers.map fun c => c.species.label)
 let valuesMatch := observed.all fun (species,symmetry,magnitudeClass,axes) =>
  match registeredCarriers.find? (fun c => Text.equal c.species.label species) with
  | none => false
  | some carrier => Text.equal carrier.symmetry.label symmetry &&
   Text.equal (structuralMagnitudeClass carrier).label magnitudeClass && (carrier.axes.map fun a => a.label)==axes
 if !supportMatches || !valuesMatch then throw "PROP-005 predicted symmetry/component vector changed"
 pure ()
theorem absentStructuralVectorRejected : validateStructuralPrediction (.table []) = .error "PROP-005 value-free structural prediction is incomplete" := rfl
end SFT.Chemistry.MolecularDipoleMagnitudePrediction
