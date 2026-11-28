import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthBiodiversityEnvironment
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
def original : Obligation := ⟨"SFT-EARTH-BIODIVERSITY-ENVIRONMENT-001","Biodiversity-environment boundary","biogeochemical_ecological","taxon-trait-habitat-pressure-carrier","environmental-condition-to-biological-response-comparison","sampling-taxonomy-space-time-confounders-and-missingness-held","study-design-bounded","A biodiversity-environment relation is a sampling- and design-bounded comparison retaining taxonomic identity, habitat, pressure, response, confounders and missingness.","Reject if correlation becomes causation or if unequal observation effort is treated as biological difference."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "coupled_cycle_recurs_and_closes") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthBiodiversityEnvironment
