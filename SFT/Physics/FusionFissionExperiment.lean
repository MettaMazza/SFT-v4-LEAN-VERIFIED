import SFT.Physics.FusionFissionPrediction
import SFT.Physics.FusionFissionMeasurement
import SFT.Physics.FusionFissionTerminalEvidence
import SFT.Physics.TargetCustody
namespace SFT.Physics.FusionFissionExperiment
open SFT.Host SFT.Host.Canonical FusionFissionPrediction NuclearBindingMeasuredRows RunningConvergenceMeasurement
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
def targetIds : List String := ["AME2020-COMPLETE-POSITIVE-COMPOSITE-CENSUS", "AME2020-SINGLETON-EMPTY-BINDING-BOUNDARIES", "AME2020-DEUTERIUM-HELIUM4-FUSION-ANCHORS", "AME2020-URANIUM238-PALLADIUM119-FISSION-ANCHORS", "AME2020-GLOBAL-BINDING-MAXIMUM"]
def frozenRelation : String := "Exact binary fusion and fission representatives conserve every nuclear count, increase the sealed zero-parameter binding score toward the unique unbounded maximum, retain a positive release record and use the normalized Half-One barrier."
def falsification : String := "Reject if either sealed exact binding direction is absent from AME2020 after reported uncertainties, if mass/charge coordinates differ, if the sealed global maximum is not the complete-census maximum, if any positive-composite row or singleton boundary inscription is omitted, if a reversed-direction control is accepted, if a source identity changes, or if target content enters prediction before its seal."
def sourceId : String := "AMDC-AME2020-MASS-1-BINDING-2021"
def registrationRecord : Except String Value := do
 let document ← predictionProgramDocument
 pure (.object [("claim_id",.text "SFT-PHYS-NUCLEAR-FUSION-FISSION-TERMINAL-005"),("comparison_protocol",.text "exact strict rational interval order and exact mass/charge coordinate identity"),("evidence_mode",.text "observational_derivation"),("experiment_id",.text "SFT-EXP-PHYS-NUCLEAR-FUSION-FISSION-TERMINAL-005"),("falsification_condition",.text "Reject if either sealed exact binding direction is absent from AME2020 after reported uncertainties, if mass/charge coordinates differ, if the sealed global maximum is not the complete-census maximum, if any positive-composite row or singleton boundary inscription is omitted, if a reversed-direction control is accepted, if a source identity changes, or if target content enters prediction before its seal."),("frozen_relation",.text "Exact binary fusion and fission representatives conserve every nuclear count, increase the sealed zero-parameter binding score toward the unique unbounded maximum, retain a positive release record and use the normalized Half-One barrier."),("prediction_program",document),("protocol",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("raw_snapshot_hash",.text "sha256:e8599c6d7f724fac91934e59f1b9de8fb8f63e820f4b39456b790665ed2a3307"),("raw_snapshot_path",.text "experiments/external_sources/physics/snapshots/ame2020-mass_1.mas20"),("registered_by",.text "Maria Smith"),("row_retention_policy",.text "all 2,548 positive-composite rows, every used reported uncertainty, both singleton empty-binding boundary inscriptions, exact anchors, the global rival envelope and adverse reversed directions"),("schema",.text "sft-v3-fusion-fission-experiment/1"),("source_id",.text "AMDC-AME2020-MASS-1-BINDING-2021"),("source_record_hash",.text "sha256:d10a9474253b2d29fac71ee21352039659f2e5f4b7d75395416d361878a18ddc"),("source_record_path",.text "experiments/external_sources/physics/snapshots/nuclear-binding-curve-successor-source-record.json"),("target_access_policy",.text "capability-closed prediction; distinct custody; release only after matching seal"),("withheld_target_ids",.array [.text "AME2020-COMPLETE-POSITIVE-COMPOSITE-CENSUS",.text "AME2020-SINGLETON-EMPTY-BINDING-BOUNDARIES",.text "AME2020-DEUTERIUM-HELIUM4-FUSION-ANCHORS",.text "AME2020-URANIUM238-PALLADIUM119-FISSION-ANCHORS",.text "AME2020-GLOBAL-BINDING-MAXIMUM"])])
def canonicalRow (r : Row) : Value := .object [("mass_count",.integer r.mass),("charge_count",.integer r.charge),("neutron_count",.integer r.neutrons),("element",.text r.element),("binding_keV_per_nucleon",FusionFissionTerminalEvidence.fractionValue r.binding),("uncertainty_keV_per_nucleon",FusionFissionTerminalEvidence.fractionValue r.uncertainty),("lower_keV_per_nucleon",FusionFissionTerminalEvidence.fractionValue r.lower),("upper_keV_per_nucleon",FusionFissionTerminalEvidence.fractionValue r.upper)]
structure ReleasedTargets where
 rows : List Row
 boundaries : List Value
 deuterium : Row
 helium : Row
 uranium : Row
 palladium : Row
 peak : Row
def releasedTargets (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String ReleasedTargets := do
 let record ← FusionFissionMeasurement.authoritativeRecord bytes files payload
 let rows ← FusionFissionMeasurement.measuredBindingRows bytes files payload
 let _ ← FusionFissionMeasurement.measurementAnalysis rows
 let boundaries ← array (← field (← field record "complete_numeric_binding_census") "singleton_empty_binding_boundary_rows")
 let d ← rowByCoordinate rows 2 1
 let h ← rowByCoordinate rows 4 2
 let u ← rowByCoordinate rows 238 92
 let p ← rowByCoordinate rows 119 46
 let peak ← match NuclearBindingMeasurement.ranked rows.zipIdx with
  | [] => .error "IndexError"
  | first::_ => .ok first.1
 pure ⟨rows,boundaries,d,h,u,p,peak⟩
def targetValues (t : ReleasedTargets) : List (String × Value) := [
 ("AME2020-COMPLETE-POSITIVE-COMPOSITE-CENSUS",.array (t.rows.map canonicalRow)),
 ("AME2020-SINGLETON-EMPTY-BINDING-BOUNDARIES",.array t.boundaries),
 ("AME2020-DEUTERIUM-HELIUM4-FUSION-ANCHORS",.array [canonicalRow t.deuterium,canonicalRow t.helium]),
 ("AME2020-URANIUM238-PALLADIUM119-FISSION-ANCHORS",.array [canonicalRow t.uranium,canonicalRow t.palladium]),
 ("AME2020-GLOBAL-BINDING-MAXIMUM",canonicalRow t.peak)]
def envelope (derivationSeal : String) (inputs : List (String × CapabilityValues.Value)) (registrationHash : String) : Value := .object [
 ("experiment_id",.text experimentId),("registered_inputs",.object (inputs.map (fun (key,value) => (key,.text (admissionIdentity (CapabilityValues.canonical value)))))),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text (admissionIdentity (.array [.text derivationSeal,.text frozenRelation]))),("experiment_registration_hash",.text registrationHash)]
theorem completeTargetCount : targetIds.length = 5 := rfl
end SFT.Physics.FusionFissionExperiment
