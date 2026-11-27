import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthState
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
def original : Obligation := ⟨"SFT-EARTH-STATE-001","Earth-system state","earth_system_observation","time-indexed-complete-reservoir-carrier","stock-relation-state-assignment","stocks-relations-missingness-and-time-held","registered-state-vector-bounded","An Earth-system state is the complete registered assignment of stocks, relations and observation status at one declared time and scale.","Reject if favorable variables alone define the state or if missing and outside-scope entries are collapsed into absence."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool := StructuralModel.labelsDistinct StructuralModel.observationStatuses
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := StructuralModel.statusSeparation
end SFT.EarthEnvironment.EarthState
