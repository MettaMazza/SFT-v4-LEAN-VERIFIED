import SFT.AstronomyCosmology.StructuralModel
namespace SFT.AstronomyCosmology.AstrometricRadialMotion
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
def original : Obligation := ⟨"SFT-ASTRO-MOTION-001","Astrometric and radial motion","radiation_motion_time","time-indexed-position-spectrum-carrier","position-or-feature-change-relation","frame-epochs-baseline-components-and-errors-held","motion-observation-bounded","Motion retains frame, epochs, baseline, components and uncertainties.","Reject if apparent and physical motion are conflated."⟩
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
end SFT.AstronomyCosmology.AstrometricRadialMotion
