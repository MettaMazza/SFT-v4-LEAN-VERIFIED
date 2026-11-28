import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthPollutantIdentity
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
def original : Obligation := ⟨"SFT-EARTH-POLLUTANT-IDENTITY-001","Pollutant identity and boundary","environmental_transport_quality","substance-form-source-context-carrier","harm-relevant-exposure-classification","chemical-form-source-medium-dose-time-and-endpoint-held","environment-health-handoff-bounded","A pollutant is a source- and context-bound material form associated with a declared exposure and adverse endpoint; substance identity alone does not establish harm.","Reject if chemical forms, exposure, dose, endpoint or Medicine-owned health evidence are omitted."⟩
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
end SFT.EarthEnvironment.EarthPollutantIdentity
