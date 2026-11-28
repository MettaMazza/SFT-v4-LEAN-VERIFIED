import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthEnvironmentalTransport
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
def original : Obligation := ⟨"SFT-EARTH-ENVIRONMENTAL-TRANSPORT-001","Environmental contaminant transport","environmental_transport_quality","material-medium-pathway-network","advection-dispersion-partition-and-transfer-relation","species-phase-direction-boundaries-time-and-uncertainty-held","site-and-medium-bounded","Environmental transport is a carrier-resolved pathway network that cites upstream physical and material laws and retains phase, direction, boundaries, transformations and uncertainty.","Reject if a fitted transport coefficient replaces missing path evidence or if unavailable downstream observations become absence."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "boundary_transfer_is_two_sided") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthEnvironmentalTransport
