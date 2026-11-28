import SFT.AstronomyCosmology.StructuralModel
namespace SFT.AstronomyCosmology.AstronomicalVariability
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
def original : Obligation := ⟨"SFT-ASTRO-VARIABILITY-001","Astronomical variability","radiation_motion_time","time-series-source-carrier","state-to-signal-change-relation","cadence-window-band-errors-and-nondetections-held","time-series-bounded","Variability is source change observed through a declared cadence and window with gaps retained.","Reject if sampling aliases or missing intervals are erased."⟩
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
end SFT.AstronomyCosmology.AstronomicalVariability
