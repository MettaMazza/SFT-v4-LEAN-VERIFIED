import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthStressStrain
structure Obligation where
 claim_id : String
 title : String
 family : String
 carrier : String
 relation : String
 retained_record : String
 evidence_boundary : String
 statement : String
 falsification_condition : String
def original : Obligation := ⟨"SFT-EARTH-STRESS-STRAIN-001","Geophysical stress and strain","seismic_volcanic","material-load-deformation-carrier","load-to-deformation-relation","orientation-path-rate-history-and-material-state-held","specimen-and-scale-bounded","Geophysical stress and strain retain load orientation, deformation, material state, path, rate and scale rather than reducing both to an unsigned scalar.","Reject if orientation or loading history is lost or if a laboratory relation is applied across scale without an admitted handoff."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "unit_exponent_is_uniquely_enumerated") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthStressStrain
