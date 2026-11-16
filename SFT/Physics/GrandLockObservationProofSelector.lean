import SFT.Physics.GrandLockObservationProofOriginal
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
def selector_boundary : Value := .object [("current_evidence_closed_lawful_extensions_open",.boolean true),("every_available_measurement_receipt_hash_retained",.boolean true),("every_empirical_validation_hash_retained",.boolean true),("every_external_validation_hash_retained",.boolean true),("every_unfavorable_result_and_scope_boundary_retained",.boolean true),("formal_survivor_sealed_before_this_aggregate_reconciliation",.boolean true),("legacy_receipt_shape_explicit",.boolean true),("measurements_select_formal_survivor",.boolean true),("observation_is_empirical_evidence",.boolean true),("prior_observations_not_relabelled_as_unseen_predictions",.boolean true)]
def selectorTarget : Value := .object [("empirical_claim_count",.integer (234)),("empirical_claims",snapshot702),("formal_grand_lock",snapshot703),("legacy_empirical_materialization_without_separate_measurement_receipt",snapshot704),("methodological_boundary",selector_boundary),("physics_claim_count",.integer (347)),("physics_claim_ids",snapshot706),("prelock_input_path",.text "census/physics_grand_lock_input_v1.json"),("prelock_input_sha256",.text "sha256:325248e4081b287fbacd125efe18a9d5fbba05f1fbd459eaa2a61a225120b3ca"),("schema",.text "sft-v3-physics-grand-lock-empirical-reconciliation/1"),("unfavorable_or_scope_boundary_ids",snapshot707),("unique_external_source_id_count",.integer (147)),("unique_external_source_ids",snapshot708)]
theorem selector_field_rows : field selectorTarget "empirical_claims" = .ok (.array original_rows) := rfl
#print axioms selector_field_rows
theorem selector_field_legacy : field selectorTarget "legacy_empirical_materialization_without_separate_measurement_receipt" = .ok (snapshot704) := rfl
#print axioms selector_field_legacy
theorem selector_field_adverse : field selectorTarget "unfavorable_or_scope_boundary_ids" = .ok (snapshot707) := rfl
#print axioms selector_field_adverse
theorem selector_field_physics : field selectorTarget "physics_claim_ids" = .ok (snapshot706) := rfl
#print axioms selector_field_physics
theorem selector_field_sources : field selectorTarget "unique_external_source_ids" = .ok (snapshot708) := rfl
#print axioms selector_field_sources
theorem selector_field_boundary : field selectorTarget "methodological_boundary" = .ok ((selector_boundary)) := rfl
#print axioms selector_field_boundary
theorem selector_field_empiricalCount : field selectorTarget "empirical_claim_count" = .ok (original_empiricalCount) := rfl
#print axioms selector_field_empiricalCount
theorem selector_field_sourceCount : field selectorTarget "unique_external_source_id_count" = .ok (original_sourceCount) := rfl
#print axioms selector_field_sourceCount
theorem selector_field_formal : field selectorTarget "formal_grand_lock" = .ok (snapshot703) := rfl
#print axioms selector_field_formal
theorem selectorExtraction : recordCertificate selectorTarget = .ok (certificateFields original_ids original_legacy original_adverse original_physics original_sources original_hashes original_measurements original_legacyRows original_empiricalCount original_sourceCount (selector_boundary) original_requiredTrue original_formalReceipt) := by
 unfold recordCertificate
 have h0 := selector_field_rows
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h0
 rewrite [h0]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h1 := parse_ids
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h1
 rewrite [h1]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h2 := selector_field_legacy
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h2
 rewrite [h2]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h3 := parse_legacy
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h3
 rewrite [h3]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h4 := selector_field_adverse
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h4
 rewrite [h4]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h5 := parse_adverse
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h5
 rewrite [h5]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h6 := selector_field_physics
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h6
 rewrite [h6]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h7 := parse_physics
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h7
 rewrite [h7]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h8 := selector_field_sources
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h8
 rewrite [h8]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h9 := parse_sources
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h9
 rewrite [h9]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h10 := selector_field_boundary
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h10
 rewrite [h10]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, selector_boundary]
 have h11 := parse_hashes
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h11
 rewrite [h11]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, selector_boundary]
 have h12 := parse_measurements
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h12
 rewrite [h12]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, selector_boundary]
 have h13 := parse_legacyRows
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h13
 rewrite [h13]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, selector_boundary]
 have h14 := selector_field_empiricalCount
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h14
 rewrite [h14]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, selector_boundary]
 have h15 := selector_field_sourceCount
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h15
 rewrite [h15]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, selector_boundary]
 have h16 := selector_field_formal
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h16
 rewrite [h16]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, selector_boundary]
 have h17 := parse_formal
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h17
 rewrite [h17]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, selector_boundary]
 rfl
#print axioms selectorExtraction
theorem selector_boundaryExact : boundaryExact (selector_boundary) original_requiredTrue = false := rfl
#print axioms selector_boundaryExact
theorem selectorComplete : GrandLockObservationAnalysis.recordCertificate selectorTarget=.ok (.object [("unique_complete_empirical_vector",.boolean true),("all_empirical_and_external_hashes",.boolean true),("all_available_measurement_receipts_retained",.boolean true),("legacy_shape_exact",.boolean true),("adverse_scope_vector_exact",.boolean true),("external_source_vector_exact",.boolean true),("methodological_boundary",.boolean false),("formal_receipt_bound",.boolean true)]) := by
 rw [selectorExtraction]
 unfold certificateFields
 rw [original_uniqueVector, original_hashesRetained, original_measurementsRetained, original_legacyExact, original_adverseExact, original_sourcesExact, selector_boundaryExact, original_receiptBound]
#print axioms selectorComplete
end SFT.Physics.GrandLockObservationAnalysisProofs
