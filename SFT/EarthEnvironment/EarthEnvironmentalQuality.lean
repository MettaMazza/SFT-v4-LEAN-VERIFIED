import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthEnvironmentalQuality
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
def original : Obligation := ⟨"SFT-EARTH-ENVIRONMENTAL-QUALITY-001","Environmental quality state","environmental_transport_quality","multi-measurement-environmental-state-carrier","standard-purpose-and-ecological-comparison","variables-methods-threshold-provenance-missingness-and-time-held","medium-purpose-jurisdiction-bounded","Environmental quality is a purpose- and medium-specific evidence vector retaining measurement methods, thresholds, provenance, uncertainty and missing components; no single index may erase them.","Reject if a weighted index imports fitted choices, hides an adverse component or silently becomes a universal natural law."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "boundary_transfer_is_two_sided") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthEnvironmentalQuality
