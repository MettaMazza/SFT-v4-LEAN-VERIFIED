import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthCarbonCycle
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
def original : Obligation := ⟨"SFT-EARTH-CARBON-CYCLE-001","Earth carbon cycle","biogeochemical_ecological","carbon-species-reservoir-network","transformation-storage-and-transfer-relation","species-isotopes-stocks-flows-boundaries-and-time-held","earth-carbon-domain-bounded","The Earth carbon cycle is a species- and reservoir-resolved transformation and transfer network with isotopic, stock, flow, boundary and uncertainty records retained.","Reject if chemically distinct carriers are merged, if an unmeasured sink closes the budget by assumption, or if biological uptake is rederived rather than cited."⟩
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
end SFT.EarthEnvironment.EarthCarbonCycle
