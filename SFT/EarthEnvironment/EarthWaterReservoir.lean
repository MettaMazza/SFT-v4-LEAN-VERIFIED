import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthWaterReservoir
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
def original : Obligation := ⟨"SFT-EARTH-WATER-RESERVOIR-001","Water reservoir identity","hydrosphere_cryosphere","phase-location-bounded-water-carrier","storage-membership-and-exchange-relation","amount-phase-composition-boundary-and-time-held","hydrological-domain-bounded","A water reservoir retains amount, phase, composition, location, boundary, residence interval and exchanges as distinct registered properties.","Reject if water outside the observation boundary is treated as absent or if phase and chemical composition are erased."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  (match rows.find? (fun row => SFT.Host.Text.equal row.1 "complementary_cycle_recurs") with
   | none => false | some row => row.2) &&
  (match rows.find? (fun row => SFT.Host.Text.equal row.1 "reservoir_partition_closes") with
   | none => false | some row => row.2)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthWaterReservoir
