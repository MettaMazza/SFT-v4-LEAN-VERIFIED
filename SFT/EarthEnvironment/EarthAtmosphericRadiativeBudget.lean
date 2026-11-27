import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthAtmosphericRadiativeBudget
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
def original : Obligation := ⟨"SFT-EARTH-ATMOSPHERIC-RADIATIVE-BUDGET-001","Atmospheric radiative budget","atmosphere_weather","spectral-source-layer-boundary-carrier","absorption-emission-scattering-transfer-relation","spectrum-direction-cloud-aerosol-surface-and-time-held","spectral-spatial-window-bounded","An atmospheric radiative budget is a directional and spectral transfer ledger through atmosphere and surface with clouds, aerosols, storage and unresolved terms retained.","Reject if a bulk fitted parameter substitutes for the registered carriers or if incoming and outgoing quantities use incompatible boundaries."⟩
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
end SFT.EarthEnvironment.EarthAtmosphericRadiativeBudget
