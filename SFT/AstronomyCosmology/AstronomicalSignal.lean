import SFT.AstronomyCosmology.StructuralModel
namespace SFT.AstronomyCosmology.AstronomicalSignal
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
def original : Obligation := ⟨"SFT-ASTRO-SIGNAL-001","Astronomical signal","observation_geometry","source-path-detector-signal-carrier","propagation-and-detection-relation","emission-path-band-arrival-and-quality-held","signal-channel-bounded","A signal retains source, path, band, arrival, detector response and quality status.","Reject if propagation, detector response or non-detection is omitted."⟩
def carrierWitness : Bool := !original.carrier.isEmpty
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "source_path_observer_ordered") with
 | none => false
 | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.AstronomyCosmology.AstronomicalSignal
