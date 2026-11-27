import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthOcean
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
def original : Obligation := ⟨"SFT-EARTH-OCEAN-001","Ocean system identity","ocean_coast","bounded-seawater-basin-interface-carrier","storage-motion-composition-and-exchange-relation","basin-depth-composition-state-boundaries-and-time-held","ocean-observation-bounded","The ocean is a basin- and boundary-resolved seawater organization retaining composition, state, depth, motion and exchanges with atmosphere, land, ice and seabed.","Reject if a surface observation is generalized through depth or if basin and global records are mixed without weighting and provenance."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "coupled_cycle_recurs_and_closes") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthOcean
