import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthTectonicMotion
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
def original : Obligation := ⟨"SFT-EARTH-TECTONIC-MOTION-001","Tectonic motion and deformation","interior_geodynamics","time-indexed-solid-earth-position-carrier","relative-displacement-strain-transition","reference-frame-path-rate-events-and-errors-held","spatial-temporal-window-bounded","Tectonic motion is a reference-frame-bound history of relative displacement and deformation reconstructed from complete geodetic and geological records.","Reject if reference-frame change creates the claimed motion or if episodic and unresolved intervals are smoothed away."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  (match rows.find? (fun row => SFT.Host.Text.equal row.1 "layers_are_positive_and_ordered") with
   | none => false | some row => row.2) &&
  (match rows.find? (fun row => SFT.Host.Text.equal row.1 "boundary_transfer_is_two_sided") with
   | none => false | some row => row.2)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthTectonicMotion
