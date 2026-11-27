import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthRupture
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
def original : Obligation := ⟨"SFT-EARTH-RUPTURE-001","Earth rupture process","seismic_volcanic","fault-state-transition-carrier","stored-deformation-to-slip-transition","geometry-loading-nucleation-propagation-and-arrest-held","event-and-network-bounded","Rupture is a source-bound transition from stored deformation to propagating and arrested slip with fault geometry, loading history and unresolved segments retained.","Reject if catalog time alone is treated as the rupture mechanism or if unobserved nucleation is asserted as measured fact."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "unit_exponent_is_uniquely_enumerated") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthRupture
