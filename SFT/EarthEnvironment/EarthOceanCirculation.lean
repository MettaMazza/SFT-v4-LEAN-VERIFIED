import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthOceanCirculation
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
def original : Obligation := ⟨"SFT-EARTH-OCEAN-CIRCULATION-001","Ocean circulation","ocean_coast","water-mass-pathway-network","transport-overturning-and-mixing-relation","mass-properties-direction-depth-time-and-boundaries-held","basin-time-window-bounded","Ocean circulation is a carrier-resolved transport network retaining water-mass identity, direction, depth, mixing, exchange and observation interval.","Reject if a streamfunction or inferred path is treated as direct parcel history or if unresolved recirculation is erased."⟩
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
end SFT.EarthEnvironment.EarthOceanCirculation
