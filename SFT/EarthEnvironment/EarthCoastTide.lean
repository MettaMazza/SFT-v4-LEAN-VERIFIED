import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthCoastTide
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
def original : Obligation := ⟨"SFT-EARTH-COAST-TIDE-001","Coastal and tidal Earth-system response","ocean_coast","ocean-land-orbital-forcing-interface-carrier","periodic-forcing-propagation-and-dissipation-relation","geometry-water-level-current-sediment-time-and-handoff-held","coastal-region-bounded","A coastal tidal response consumes Astronomy-owned orbital forcing and Physics-owned wave laws while Earth Science owns the measured water, current, sediment and boundary response.","Reject if planetary tidal locking is reowned, if a local response is generalized globally, or if shoreline change is inferred from water level alone."⟩
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
end SFT.EarthEnvironment.EarthCoastTide
