import SFT.Physics.GrandLockObservationAnalysis
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical GrandLockDependency GrandLockObservationAnalysis RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem assembleRecord (record : Value) (rows : List Value)
 (ids legacy adverse physics sources : List String) (boundaryFields : List (String × Value))
 (hashes measurements : List Bool) (legacyRows : List String) (empiricalCount sourceCount formal formalReceipt legacyValue adverseValue physicsValue sourcesValue : Value)
 (h0 : field record "empirical_claims" = .ok (.array rows))
 (h1 : recordMap (fun row=>do text (← field row "claim_id")) rows = .ok ids)
 (h2 : field record "legacy_empirical_materialization_without_separate_measurement_receipt" = .ok legacyValue)
 (h2parse : stringList legacyValue = .ok legacy)
 (h3 : field record "unfavorable_or_scope_boundary_ids" = .ok adverseValue)
 (h3parse : stringList adverseValue = .ok adverse)
 (h4 : field record "physics_claim_ids" = .ok physicsValue)
 (h4parse : stringList physicsValue = .ok physics)
 (h5 : field record "unique_external_source_ids" = .ok sourcesValue)
 (h5parse : stringList sourcesValue = .ok sources)
 (h6 : field record "methodological_boundary" = .ok (.object boundaryFields))
 (h7 : recordMap (fun row=>do pure (SymmetricRecords.truthy (← field row "empirical_validation_hash") && SymmetricRecords.truthy (← field row "external_validation_hash"))) rows = .ok hashes)
 (h8 : recordMap (fun row=>do pure (SymmetricRecords.truthy (getDefault row "measurement_receipt_hash") || member (← text (← field row "claim_id")) legacy)) rows = .ok measurements)
 (h9 : recordMap (fun row=>do text (← field row "claim_id")) (recordFilter (fun row=> !SymmetricRecords.truthy (getDefault row "measurement_receipt_hash")) rows) = .ok legacyRows)
 (h10 : field record "empirical_claim_count" = .ok empiricalCount)
 (h11 : field record "unique_external_source_id_count" = .ok sourceCount)
 (h12 : field record "formal_grand_lock" = .ok formal)
 (h13 : field formal "receipt_hash" = .ok formalReceipt) :
 recordCertificate record = .ok (certificateFields ids legacy adverse physics sources hashes measurements legacyRows empiricalCount sourceCount (.object boundaryFields) (recordFilter (fun (key,_)=> !SFT.Host.Text.equal key "measurements_select_formal_survivor") boundaryFields) formalReceipt) := by
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure] at h1 h7 h8 h9
 unfold recordCertificate
 rewrite [h0]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, array]
 rewrite [h1]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h2]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h2parse]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h3]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h3parse]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h4]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h4parse]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h5]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h5parse]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h6]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h7]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h8]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h9]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h10]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h11]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h12]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [h13]
 rfl
#print axioms assembleRecord
end SFT.Physics.GrandLockObservationAnalysisProofs
