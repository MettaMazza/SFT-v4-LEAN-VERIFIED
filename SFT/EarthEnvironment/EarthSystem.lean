import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthSystem
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
def original : Obligation := ⟨"SFT-EARTH-SYSTEM-001","Earth-system identity","earth_system_observation","nested-earth-reservoir-interface-carrier","bounded-joint-state-continuation","reservoirs-interfaces-time-and-scale-held","earth-state-observation-bounded","The Earth system is a declared joint organization of distinguishable reservoirs and interfaces whose state, boundary, scale and observation time remain explicit.","Reject if system identity is claimed while a participating reservoir, interface, spatial boundary, timescale or observation class is silently erased."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool := StructuralModel.labelsDistinct StructuralModel.observationStatuses
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := StructuralModel.statusSeparation
end SFT.EarthEnvironment.EarthSystem
