import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthVolcanicProcess
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
def original : Obligation := ⟨"SFT-EARTH-VOLCANIC-PROCESS-001","Volcanic process and eruption record","seismic_volcanic","magma-pathway-eruption-carrier","generation-storage-transport-release-transition","composition-pressure-geometry-time-products-and-failures-held","volcanic-system-bounded","A volcanic process is a complete material and state-transition record from generation through storage, transport and release, including failed and non-eruptive paths.","Reject if surface products uniquely determine an unobserved pathway without alternative reconstructions."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "unit_exponent_is_uniquely_enumerated") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthVolcanicProcess
