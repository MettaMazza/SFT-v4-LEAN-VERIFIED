import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthIonosphereResonance
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
def original : Obligation := ⟨"SFT-EARTH-EARTH-IONOSPHERE-RESONANCE-001","Earth-ionosphere resonant cavity","atmosphere_weather","earth-surface-atmosphere-ionosphere-boundary-carrier","bounded-propagation-mode-recurrence","geometry-medium-source-spectrum-time-and-uncertainty-held","earth-cavity-observation-bounded","Earth-ionosphere resonance composes the admitted bounded-wave relation with the measured Earth-atmosphere cavity geometry and retains the complete source spectrum and uncertainty.","Reject if the observed resonant frequency selects the cavity law, if a universal wave law is reowned, or if engineering transmission claims are inferred from resonance alone."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "bounded_cavity_has_distinct_modes") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthIonosphereResonance
