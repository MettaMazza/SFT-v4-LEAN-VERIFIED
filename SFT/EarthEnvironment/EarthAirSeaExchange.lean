import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthAirSeaExchange
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
def original : Obligation := ⟨"SFT-EARTH-AIR-SEA-EXCHANGE-001","Air-sea exchange","ocean_coast","atmosphere-ocean-interface-carrier","two-way-material-energy-transfer-relation","species-energy-area-direction-state-and-time-held","interface-method-bounded","Air-sea exchange is a two-way, interface-bounded transfer ledger retaining carrier identity, direction, area, state, time and method uncertainty.","Reject if a transfer coefficient is fitted to close the budget and then presented as a forced Earth law."⟩
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
end SFT.EarthEnvironment.EarthAirSeaExchange
