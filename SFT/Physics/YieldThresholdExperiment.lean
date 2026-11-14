import SFT.Physics.YieldThresholdPrediction
import SFT.Physics.YieldThresholdMeasurement
namespace SFT.Physics.YieldThresholdExperiment
open SFT.Host SFT.Host.Canonical YieldThresholdPrediction NuclearBindingMeasuredRows RunningConvergenceMeasurement
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
def targetIds : List String := ["AME2020-COMPLETE-POSITIVE-COMPOSITE-CENSUS", "AME2020-FUSION-FISSION-YIELD-ANCHORS", "IAEA-COMPLETE-FUSION-REACTION-ENERGY-TABLE", "IAEA-FISSION-ENERGY-LEDGER", "IAEA-FUSION-FISSION-THRESHOLD-CLASSES"]
def frozenRelation : String := "The exact light representative has greater release per conserved nucleon; the heavy representative has greater total release; fusion has a charged two-boundary approach carrier; fission has neutral capture or an internal surface carrier; normalized structure does not select one dimensional threshold."
def falsification : String := "Reject if the sealed fusion-greater-per-nucleon relation or fission-greater-total relation fails the exact AME2020 uncertainty intervals or the registered IAEA D-T/U-235 energy comparison; if the IAEA charged effective-barrier, neutron-trigger, spontaneous/internal-barrier or captured-particle class is absent; if per-nucleon and total metrics are conflated; if any AME, fusion-table, fission-ledger, threshold or limitation row is omitted; if a source identity changes; or if target content enters prediction before its seal."
def registrationRecord : Except String Value := do
 let document ← predictionProgramDocument
 pure (.object [("claim_id",.text "SFT-PHYS-NUCLEAR-FUSION-FISSION-YIELD-THRESHOLD-006"),("comparison_protocol",.text "exact rational uncertainty intervals, exact reported-energy fractions, complete class/row identity and separate per-nucleon versus total ordering"),("evidence_mode",.text "observational_derivation"),("experiment_id",.text "SFT-EXP-PHYS-NUCLEAR-FUSION-FISSION-YIELD-THRESHOLD-006"),("falsification_condition",.text "Reject if the sealed fusion-greater-per-nucleon relation or fission-greater-total relation fails the exact AME2020 uncertainty intervals or the registered IAEA D-T/U-235 energy comparison; if the IAEA charged effective-barrier, neutron-trigger, spontaneous/internal-barrier or captured-particle class is absent; if per-nucleon and total metrics are conflated; if any AME, fusion-table, fission-ledger, threshold or limitation row is omitted; if a source identity changes; or if target content enters prediction before its seal."),("frozen_relation",.text "The exact light representative has greater release per conserved nucleon; the heavy representative has greater total release; fusion has a charged two-boundary approach carrier; fission has neutral capture or an internal surface carrier; normalized structure does not select one dimensional threshold."),("prediction_program",document),("protocol",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("registered_by",.text "Maria Smith"),("row_retention_policy",.text "all 2548 AME2020 positive-composite rows, all twelve IAEA fusion rows, all seven fission energy components, every reported total and interval, both LEXFOR fission classes, all threshold clauses and the rounded-mass limitation"),("schema",.text "sft-v3-fusion-fission-yield-threshold-experiment/1"),("source_hashes",.object [("experiments/external_sources/physics/snapshots/ame2020-mass_1.mas20",.text "sha256:e8599c6d7f724fac91934e59f1b9de8fb8f63e820f4b39456b790665ed2a3307"),("experiments/external_sources/physics/snapshots/fusion-fission-yield-threshold-source-record.json",.text "sha256:034898757fe8e5613f2291f8fdb0369a1ec6d706df03861490eb58141a774dc9"),("experiments/external_sources/physics/snapshots/iaea-endf-102-manual.pdf",.text "sha256:77a0fee413c3b1d5d74a161ed9fe7f77bbcbc58a654304851b7b2b400183d022"),("experiments/external_sources/physics/snapshots/iaea-lexfor-fission-2006.pdf",.text "sha256:d9bfc53a63fe4cf307e1ba46c952d52dcca6c95f964dd672a3acee3bb93a0297"),("experiments/external_sources/physics/snapshots/iaea-tecdoc-2024-nuclear-cogeneration.pdf",.text "sha256:712bbd5d6ad97c16f816d0f869626ded196c0ddbeece3f7a4a3f5d00f0db059a"),("experiments/external_sources/physics/snapshots/iaea-world-fusion-outlook-2023.pdf",.text "sha256:6fbe70d3943dc9d7ab1e6e9f94cb4ea81eb1431467d79bee02ce1cfaac33aa64")]),("source_id",.text "IAEA-AMDC-FUSION-FISSION-YIELD-THRESHOLD-2026"),("source_ids",.array [.text "AMDC-AME2020-MASS-1-BINDING-2021",.text "IAEA-WORLD-FUSION-OUTLOOK-2023",.text "IAEA-TECDOC-2024-NUCLEAR-COGENERATION",.text "IAEA-ENDF-102-DATA-FORMATS-PROCEDURES",.text "IAEA-NDS-LEXFOR-FISSION-2006"]),("source_record_hash",.text "sha256:034898757fe8e5613f2291f8fdb0369a1ec6d706df03861490eb58141a774dc9"),("source_record_path",.text "experiments/external_sources/physics/snapshots/fusion-fission-yield-threshold-source-record.json"),("target_access_policy",.text "capability-closed prediction; distinct custody; release only after a matching seal"),("withheld_target_ids",.array [.text "AME2020-COMPLETE-POSITIVE-COMPOSITE-CENSUS",.text "AME2020-FUSION-FISSION-YIELD-ANCHORS",.text "IAEA-COMPLETE-FUSION-REACTION-ENERGY-TABLE",.text "IAEA-FISSION-ENERGY-LEDGER",.text "IAEA-FUSION-FISSION-THRESHOLD-CLASSES"])])
structure ReleasedTargets where
 rows : List Row
 anchors : List Row
 fusionRows : List Value
 fissionRecord : Value
 thresholdRecord : Value
 sourceRecord : Value
def releasedTargets (files : List (String × ByteArray)) (payload amePayload : Value) : Except String ReleasedTargets := do
 let record ← YieldThresholdMeasurement.authoritativeRecord files payload
 let ameBytes ← match files.find? (fun p => Text.equal p.1 "experiments/external_sources/physics/snapshots/nuclear-binding-curve-successor-source-record.json") with
  | none => .error "AME source record absent" | some p => .ok p.2
 let rows ← FusionFissionMeasurement.measuredBindingRows ameBytes files amePayload
 let binding ← YieldThresholdMeasurement.exactBindingMeasurementAnalysis rows
 let scope ← field record "measurement_scope"
 let fusion ← array (← field (← field scope "iaea_fusion_energy") "reaction_rows")
 let fission ← field scope "iaea_fission_energy"
 let endf ← field scope "iaea_endf_threshold_protocol"
 let lexfor ← field scope "iaea_lexfor_fission_classes"
 pure ⟨rows,binding.anchors,fusion,fission,.object [("endf",endf),("lexfor",lexfor)],record⟩
def targetValues (t : ReleasedTargets) : List (String × Value) := [
 ("AME2020-COMPLETE-POSITIVE-COMPOSITE-CENSUS",.array (t.rows.map FusionFissionExperiment.canonicalRow)),
 ("AME2020-FUSION-FISSION-YIELD-ANCHORS",.array (t.anchors.map FusionFissionExperiment.canonicalRow)),
 ("IAEA-COMPLETE-FUSION-REACTION-ENERGY-TABLE",.array t.fusionRows),
 ("IAEA-FISSION-ENERGY-LEDGER",t.fissionRecord),
 ("IAEA-FUSION-FISSION-THRESHOLD-CLASSES",t.thresholdRecord)]
def envelope (derivationSeal : String) (inputs : List (String × CapabilityValues.Value)) (registrationHash : String) : Value := .object [
 ("experiment_id",.text experimentId),("registered_inputs",.object (inputs.map (fun (key,value) => (key,.text (admissionIdentity (CapabilityValues.canonical value)))))),
 ("withheld_target_ids",.array (targetIds.map Value.text)),("frozen_relation_hash",.text (admissionIdentity (.array [.text derivationSeal,.text frozenRelation]))),("experiment_registration_hash",.text registrationHash)]
theorem completeTargetCount : targetIds.length = 5 := rfl
end SFT.Physics.YieldThresholdExperiment
