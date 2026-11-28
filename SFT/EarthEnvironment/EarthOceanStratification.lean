import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthOceanStratification
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
def original : Obligation := ⟨"SFT-EARTH-OCEAN-STRATIFICATION-001","Ocean stratification","ocean_coast","depth-indexed-water-mass-carrier","property-contrast-and-layer-stability-relation","temperature-composition-pressure-mixing-and-time-held","profile-network-bounded","Ocean stratification is a depth- and time-resolved organization of water masses defined by retained property contrasts, interfaces, mixing and observation uncertainty.","Reject if a single profile fixes a persistent layer globally or if density is imported without its admitted physical and compositional dependencies."⟩
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
end SFT.EarthEnvironment.EarthOceanStratification
