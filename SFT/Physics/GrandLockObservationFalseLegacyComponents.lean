import SFT.Physics.GrandLockObservationLegacyProjection
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
def falseLegacy_measurements : List Bool := original_rows.map (fun row => SymmetricRecords.truthy (getDefault row "measurement_receipt_hash"))
def falseLegacyTarget : Value := .object [("empirical_claim_count",.integer (234)),("empirical_claims",snapshot702),("formal_grand_lock",snapshot703),("legacy_empirical_materialization_without_separate_measurement_receipt",.array []),("methodological_boundary",snapshot705),("physics_claim_count",.integer (347)),("physics_claim_ids",snapshot706),("prelock_input_path",.text "census/physics_grand_lock_input_v1.json"),("prelock_input_sha256",.text "sha256:325248e4081b287fbacd125efe18a9d5fbba05f1fbd459eaa2a61a225120b3ca"),("schema",.text "sft-v3-physics-grand-lock-empirical-reconciliation/1"),("unfavorable_or_scope_boundary_ids",snapshot707),("unique_external_source_id_count",.integer (147)),("unique_external_source_ids",snapshot708)]
theorem falseLegacy_field_rows : field falseLegacyTarget "empirical_claims" = .ok (.array original_rows) := rfl
#print axioms falseLegacy_field_rows
theorem falseLegacy_field_legacy : field falseLegacyTarget "legacy_empirical_materialization_without_separate_measurement_receipt" = .ok ((.array [])) := rfl
#print axioms falseLegacy_field_legacy
theorem falseLegacy_field_adverse : field falseLegacyTarget "unfavorable_or_scope_boundary_ids" = .ok (snapshot707) := rfl
#print axioms falseLegacy_field_adverse
theorem falseLegacy_field_physics : field falseLegacyTarget "physics_claim_ids" = .ok (snapshot706) := rfl
#print axioms falseLegacy_field_physics
theorem falseLegacy_field_sources : field falseLegacyTarget "unique_external_source_ids" = .ok (snapshot708) := rfl
#print axioms falseLegacy_field_sources
theorem falseLegacy_field_boundary : field falseLegacyTarget "methodological_boundary" = .ok (original_boundary) := rfl
#print axioms falseLegacy_field_boundary
theorem falseLegacy_field_empiricalCount : field falseLegacyTarget "empirical_claim_count" = .ok (original_empiricalCount) := rfl
#print axioms falseLegacy_field_empiricalCount
theorem falseLegacy_field_sourceCount : field falseLegacyTarget "unique_external_source_id_count" = .ok (original_sourceCount) := rfl
#print axioms falseLegacy_field_sourceCount
theorem falseLegacy_field_formal : field falseLegacyTarget "formal_grand_lock" = .ok (snapshot703) := rfl
#print axioms falseLegacy_field_formal
theorem falseLegacy_parse_legacy : stringList (.array []) = .ok (([] : List String)) := rfl
#print axioms falseLegacy_parse_legacy
theorem falseLegacy_parse_measurements : recordMap (fun row=>do pure (SymmetricRecords.truthy (getDefault row "measurement_receipt_hash") || member (← text (← field row "claim_id")) (([] : List String)))) original_rows = .ok (falseLegacy_measurements) := sourceMapIgnore (fun row=>do text (← field row "claim_id")) (fun row=>SymmetricRecords.truthy (getDefault row "measurement_receipt_hash")) original_rows original_ids parse_ids
#print axioms falseLegacy_parse_measurements
end SFT.Physics.GrandLockObservationAnalysisProofs
