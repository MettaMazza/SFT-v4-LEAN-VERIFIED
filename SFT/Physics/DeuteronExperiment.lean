import SFT.Physics.DeuteronPrediction
import SFT.Physics.DeuteronMeasurement
namespace SFT.Physics.DeuteronExperiment
open SFT.Host SFT.Host.Canonical DeuteronPrediction NuclearBindingMeasuredRows RunningConvergenceMeasurement
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
def targetIds : List String := ["AME2020-COMPLETE-MASS-COORDINATE-CENSUS", "NUBASE2020-COMPLETE-STATE-CENSUS", "NIST-CODATA-NUCLEON-DEUTERON-MASS-ENERGY-VECTOR", "IAEA-JENDL-COMPLETE-NP-SPIN-CHANNEL-TABLE", "IAEA-DEUTERON-SPIN-DEPENDENCE-RECORD"]
def frozenRelation : String := "Complete two-label exchange support forces a three-reading preserving channel with positive half-One binding remainder, a one-reading alternating channel with empty remainder, proton-neutron binding with spin One and exclusion of proton-proton and neutron-neutron ground binding."
def falsification : String := "Reject if the complete AME2020 or NUBASE2020 census contains a different A=2 bound-state inventory; if the directly measured deuteron spin/parity is not 1+; if the exact CODATA proton-plus-neutron taking deuteron interval does not overlap the complete AME2020 deuteron binding interval; if IAEA does not retain distinct singlet/triplet support, a bound parallel-spin deuteron or the reported spin-channel separation; if any source, uncertainty, row or unfavorable control is omitted; or if target content enters before seal."
def registrationRecord : Except String Value := do
 let document ← predictionProgramDocument
 pure (.object [("claim_id",.text "SFT-PHYS-NUCLEAR-DEUTERON-DINUCLEON-TERMINAL-006"),("comparison_protocol",.text "exact rational uncertainty propagation, full A=2 inventory, exact spin inscription, complete singlet/triplet table identity and deliberately reversed binding controls"),("evidence_mode",.text "observational_derivation"),("experiment_id",.text "SFT-EXP-PHYS-NUCLEAR-DEUTERON-DINUCLEON-TERMINAL-006"),("falsification_condition",.text "Reject if the complete AME2020 or NUBASE2020 census contains a different A=2 bound-state inventory; if the directly measured deuteron spin/parity is not 1+; if the exact CODATA proton-plus-neutron taking deuteron interval does not overlap the complete AME2020 deuteron binding interval; if IAEA does not retain distinct singlet/triplet support, a bound parallel-spin deuteron or the reported spin-channel separation; if any source, uncertainty, row or unfavorable control is omitted; or if target content enters before seal."),("frozen_relation",.text "Complete two-label exchange support forces a three-reading preserving channel with positive half-One binding remainder, a one-reading alternating channel with empty remainder, proton-neutron binding with spin One and exclusion of proton-proton and neutron-neutron ground binding."),("prediction_program",document),("protocol",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("registered_by",.text "Maria Smith"),("row_retention_policy",.text "all 3,558 AME2020 numeric coordinates, all 5,843 NUBASE2020 states, all three CODATA mass-energy rows, both complete JENDL singlet/triplet parameter sets and every registered IAEA spin-dependence row"),("schema",.text "sft-v3-deuteron-dinucleon-experiment/1"),("source_hashes",.object [("experiments/external_sources/physics/snapshots/ame2020-mass_1.mas20",.text "sha256:e8599c6d7f724fac91934e59f1b9de8fb8f63e820f4b39456b790665ed2a3307"),("experiments/external_sources/physics/snapshots/deuteron-dinucleon-terminal-source-record.json",.text "sha256:b54be2810599c91e9e4ab7839d8cb4ac84eae6caf5f5aea1b2cb3c3562d5ba7d"),("experiments/external_sources/physics/snapshots/iaea-jendl-np-data.pdf",.text "sha256:f504aca94fab528cc9ddcdfbdad79b7390fd2ba955642ed755c9b774f341ad76"),("experiments/external_sources/physics/snapshots/iaea-nuclear-theory.pdf",.text "sha256:74f7d06bc8b3c6ba719f5b6afb2e0a39fe9bf521f3b7a11bcafb666f1fe1761c"),("experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt",.text "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("experiments/external_sources/physics/snapshots/nubase2020-nubase_4.mas20",.text "sha256:1585a5eea86c5e17e90307c7e6e786d060049c4039e392a261ff6db977df9859")]),("source_id",.text "AMDC-NIST-IAEA-DEUTERON-DINUCLEON-2026"),("source_ids",.array [.text "AMDC-AME2020-MASS-1-2021",.text "AMDC-NUBASE2020-2021",.text "NIST-CODATA-2022",.text "IAEA-NDS-JENDL1-INDC-JAP-45",.text "IAEA-THEORY-NUCLEAR-STRUCTURE-STI-PUB-249"]),("source_record_hash",.text "sha256:b54be2810599c91e9e4ab7839d8cb4ac84eae6caf5f5aea1b2cb3c3562d5ba7d"),("source_record_path",.text "experiments/external_sources/physics/snapshots/deuteron-dinucleon-terminal-source-record.json"),("target_access_policy",.text "capability-closed prediction; release only after matching seal"),("withheld_target_ids",.array [.text "AME2020-COMPLETE-MASS-COORDINATE-CENSUS",.text "NUBASE2020-COMPLETE-STATE-CENSUS",.text "NIST-CODATA-NUCLEON-DEUTERON-MASS-ENERGY-VECTOR",.text "IAEA-JENDL-COMPLETE-NP-SPIN-CHANNEL-TABLE",.text "IAEA-DEUTERON-SPIN-DEPENDENCE-RECORD"])])
structure ReleasedTargets where
 ameRows : List String
 nubaseRows : List String
 codataRows : List String
 jendl : Value
 theory : Value
 sourceRecord : Value
def releasedTargets (files : List (String × ByteArray)) (payload : Value) : Except String ReleasedTargets := do
 let record ← DeuteronMeasurement.authoritativeRecord files payload
 let scope ← field record "measurement_scope"
 pure ⟨← DeuteronMeasurement.ameNumericCoordinateRows files payload,← DeuteronMeasurement.nubaseStateRows files payload,← DeuteronMeasurement.codataMassEnergyRows files,← field scope "iaea_jendl1",← field scope "iaea_nuclear_theory",record⟩
def targetValues (t : ReleasedTargets) : List (String × Value) := [
 ("AME2020-COMPLETE-MASS-COORDINATE-CENSUS",.array (t.ameRows.map Value.text)),
 ("NUBASE2020-COMPLETE-STATE-CENSUS",.array (t.nubaseRows.map Value.text)),
 ("NIST-CODATA-NUCLEON-DEUTERON-MASS-ENERGY-VECTOR",.array (t.codataRows.map Value.text)),
 ("IAEA-JENDL-COMPLETE-NP-SPIN-CHANNEL-TABLE",t.jendl),
 ("IAEA-DEUTERON-SPIN-DEPENDENCE-RECORD",t.theory)]
def envelope (derivationSeal : String) (inputs : List (String × CapabilityValues.Value)) (registrationHash : String) : Value := .object [
 ("experiment_id",.text experimentId),("registered_inputs",.object (inputs.map (fun (key,value) => (key,.text (admissionIdentity (CapabilityValues.canonical value)))))),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text (admissionIdentity (.array [.text derivationSeal,.text frozenRelation]))),("experiment_registration_hash",.text registrationHash)]
theorem completeTargetCount : targetIds.length = 5 := rfl
end SFT.Physics.DeuteronExperiment
