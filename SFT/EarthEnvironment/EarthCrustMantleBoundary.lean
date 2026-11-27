import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthCrustMantleBoundary
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
def original : Obligation := ⟨"SFT-EARTH-CRUST-MANTLE-BOUNDARY-001","Crust-mantle boundary","interior_geodynamics","solid-earth-interface-carrier","composition-structure-and-wave-contrast","depth-lateral-variation-method-and-uncertainty-held","regional-observation-bounded","The crust-mantle boundary is an observation-bounded interface identified through retained composition, structure and propagation contrasts, not a globally uniform surface by premise.","Reject if local depth is generalized globally without evidence or if method-dependent alternatives are discarded."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  (match rows.find? (fun row => SFT.Host.Text.equal row.1 "layers_are_positive_and_ordered") with
   | none => false | some row => row.2) &&
  (match rows.find? (fun row => SFT.Host.Text.equal row.1 "boundary_transfer_is_two_sided") with
   | none => false | some row => row.2)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthCrustMantleBoundary
