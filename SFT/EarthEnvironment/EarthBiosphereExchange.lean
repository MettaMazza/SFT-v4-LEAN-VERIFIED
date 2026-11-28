import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthBiosphereExchange
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
def original : Obligation := ⟨"SFT-EARTH-BIOSPHERE-EXCHANGE-001","Biosphere-Earth exchange","biogeochemical_ecological","organism-community-abiotic-interface-carrier","two-way-resource-waste-and-state-transfer","biological-owner-reservoir-carrier-rate-time-and-controls-held","ecosystem-boundary-bounded","Biosphere-Earth exchange cites Biology-owned organismal processes while Earth Science owns their measured coupling to atmosphere, water, soil and rock reservoirs.","Reject if Earth Science reowns biological mechanism or if an ecosystem observation is generalized without organism and environmental boundaries."⟩
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
end SFT.EarthEnvironment.EarthBiosphereExchange
