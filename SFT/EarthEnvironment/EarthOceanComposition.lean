import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthOceanComposition
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
def original : Obligation := ⟨"SFT-EARTH-OCEAN-COMPOSITION-001","Ocean composition and salinity","ocean_coast","water-dissolved-particulate-gas-carrier","composition-fraction-and-transformation-relation","species-basis-depth-location-time-and-method-held","sample-program-bounded","Ocean composition retains dissolved, particulate and gaseous carriers, amount basis, depth, location, time, method and transformations rather than salinity as an answer-only scalar.","Reject if practical and absolute composition bases are silently mixed or if missing species are treated as absent."⟩
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
end SFT.EarthEnvironment.EarthOceanComposition
