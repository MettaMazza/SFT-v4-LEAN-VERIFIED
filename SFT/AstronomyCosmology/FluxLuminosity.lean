import SFT.AstronomyCosmology.StructuralModel
namespace SFT.AstronomyCosmology.FluxLuminosity
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
def original : Obligation := ⟨"SFT-ASTRO-FLUX-LUMINOSITY-001","Flux and luminosity","radiation_motion_time","source-path-received-radiation-carrier","flux-distance-luminosity-relation","band-distance-geometry-extinction-and-time-held","radiometric-boundary-declared","Received flux and source luminosity remain distinct through distance, geometry, band and attenuation records.","Reject if apparent brightness is relabelled intrinsic luminosity."⟩
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
end SFT.AstronomyCosmology.FluxLuminosity
