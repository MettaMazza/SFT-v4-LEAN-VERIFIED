import SFT.Physics.GrandLockObservationTail
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
def missingRowTarget : Value := .object [("empirical_claim_count",.integer (234)),("empirical_claims",.array original_rows.tail),("formal_grand_lock",snapshot703),("legacy_empirical_materialization_without_separate_measurement_receipt",snapshot704),("methodological_boundary",snapshot705),("physics_claim_count",.integer (347)),("physics_claim_ids",snapshot706),("prelock_input_path",.text "census/physics_grand_lock_input_v1.json"),("prelock_input_sha256",.text "sha256:325248e4081b287fbacd125efe18a9d5fbba05f1fbd459eaa2a61a225120b3ca"),("schema",.text "sft-v3-physics-grand-lock-empirical-reconciliation/1"),("unfavorable_or_scope_boundary_ids",snapshot707),("unique_external_source_id_count",.integer (147)),("unique_external_source_ids",snapshot708)]
theorem missingRow_field_rows : field missingRowTarget "empirical_claims" = .ok (.array (original_rows.tail)) := rfl
#print axioms missingRow_field_rows
theorem missingRow_field_legacy : field missingRowTarget "legacy_empirical_materialization_without_separate_measurement_receipt" = .ok (snapshot704) := rfl
#print axioms missingRow_field_legacy
theorem missingRow_field_adverse : field missingRowTarget "unfavorable_or_scope_boundary_ids" = .ok (snapshot707) := rfl
#print axioms missingRow_field_adverse
theorem missingRow_field_physics : field missingRowTarget "physics_claim_ids" = .ok (snapshot706) := rfl
#print axioms missingRow_field_physics
theorem missingRow_field_sources : field missingRowTarget "unique_external_source_ids" = .ok (snapshot708) := rfl
#print axioms missingRow_field_sources
theorem missingRow_field_boundary : field missingRowTarget "methodological_boundary" = .ok (original_boundary) := rfl
#print axioms missingRow_field_boundary
theorem missingRow_field_empiricalCount : field missingRowTarget "empirical_claim_count" = .ok (original_empiricalCount) := rfl
#print axioms missingRow_field_empiricalCount
theorem missingRow_field_sourceCount : field missingRowTarget "unique_external_source_id_count" = .ok (original_sourceCount) := rfl
#print axioms missingRow_field_sourceCount
theorem missingRow_field_formal : field missingRowTarget "formal_grand_lock" = .ok (snapshot703) := rfl
#print axioms missingRow_field_formal
theorem missingRow_parse_ids : recordMap (fun row=>do text (← field row "claim_id")) (original_rows.tail) = .ok (original_ids.tail) := by
 have whole := parse_ids
 rewrite [originalRowsCons, originalIdsCons] at whole
 exact sourceMapTail (fun row=>do text (← field row "claim_id")) (original_rows.headD .null) original_rows.tail (original_ids.headD "") original_ids.tail (by rfl) whole
#print axioms missingRow_parse_ids
theorem missingRow_parse_hashes : recordMap (fun row=>do pure (SymmetricRecords.truthy (← field row "empirical_validation_hash") && SymmetricRecords.truthy (← field row "external_validation_hash"))) (original_rows.tail) = .ok (original_hashes.tail) := hashesStep1
#print axioms missingRow_parse_hashes
theorem missingRow_parse_measurements : recordMap (fun row=>do pure (SymmetricRecords.truthy (getDefault row "measurement_receipt_hash") || member (← text (← field row "claim_id")) original_legacy)) (original_rows.tail) = .ok (original_measurements.tail) := by
 have whole := parse_measurements
 rewrite [originalRowsCons, originalMeasurementsCons] at whole
 exact sourceMapTail (fun row=>do pure (SymmetricRecords.truthy (getDefault row "measurement_receipt_hash") || member (← text (← field row "claim_id")) original_legacy)) (original_rows.headD .null) original_rows.tail (original_measurements.headD false) original_measurements.tail (by rfl) whole
#print axioms missingRow_parse_measurements
theorem missingRow_parse_legacyRows : recordMap (fun row=>do text (← field row "claim_id")) (recordFilter (fun row=> !SymmetricRecords.truthy (getDefault row "measurement_receipt_hash")) (original_rows.tail)) = .ok original_legacyRows := parse_legacyRows
#print axioms missingRow_parse_legacyRows
end SFT.Physics.GrandLockObservationAnalysisProofs
