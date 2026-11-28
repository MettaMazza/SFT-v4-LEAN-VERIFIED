import SFT.AstronomyCosmology.StructuralModel
namespace SFT.AstronomyCosmology.AstronomicalRedshift
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
def original : Obligation := ⟨"SFT-ASTRO-REDSHIFT-001","Astronomical redshift","radiation_motion_time","emitted-observed-feature-carrier","feature-displacement-relation","feature-identity-frame-motion-gravity-expansion-and-error-held","redshift-cause-bounded","Redshift is an emitted-to-observed feature relation; motion, gravity and expansion causes remain distinguishable.","Reject if measured redshift alone is treated as a unique distance or cause."⟩
def carrierWitness : Bool := !original.carrier.isEmpty
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "period_two_recurs") with
 | none => false
 | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.AstronomyCosmology.AstronomicalRedshift
