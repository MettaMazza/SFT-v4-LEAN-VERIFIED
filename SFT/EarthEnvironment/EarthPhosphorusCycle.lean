import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthPhosphorusCycle
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
def original : Obligation := ⟨"SFT-EARTH-PHOSPHORUS-CYCLE-001","Earth phosphorus cycle","biogeochemical_ecological","phosphorus-species-rock-soil-water-biota-network","weathering-uptake-transfer-return-relation","species-stocks-flows-organisms-sediment-and-time-held","earth-phosphorus-domain-bounded","The Earth phosphorus cycle composes geological, chemical and biological carriers while retaining weathering, uptake, transfer, burial, return and boundary exports.","Reject if a named cycle asserts atmospheric equivalence or complete return without evidence."⟩
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
end SFT.EarthEnvironment.EarthPhosphorusCycle
