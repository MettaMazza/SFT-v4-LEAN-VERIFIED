import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthClimateVariability
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
def original : Obligation := ⟨"SFT-EARTH-CLIMATE-VARIABILITY-001","Internal climate variability","climate_system","coupled-state-history-carrier","recurrent-and-nonrecurrent-transition-partition","modes-phases-forcing-record-length-and-missingness-held","record-and-scale-bounded","Internal climate variability is the source-bounded state-transition structure remaining after registered external drivers are retained, with recurrence and nonrecurrence both recorded.","Reject if unexplained change is automatically labeled internal or if a short record establishes a depth-independent cycle."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "tipping_basins_share_image_without_physical_assignment") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthClimateVariability
