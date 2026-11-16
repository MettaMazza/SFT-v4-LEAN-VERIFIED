import SFT.Physics.GrandLockObservationMissingRowComponents
import SFT.Physics.GrandLockObservationRecordAssembly
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem missingRowExtraction : recordCertificate missingRowTarget = .ok (certificateFields (original_ids.tail) original_legacy original_adverse original_physics original_sources (original_hashes.tail) (original_measurements.tail) original_legacyRows original_empiricalCount original_sourceCount original_boundary original_requiredTrue original_formalReceipt) := by
 have assembled := assembleRecord missingRowTarget original_rows.tail original_ids.tail original_legacy original_adverse original_physics original_sources _ original_hashes.tail original_measurements.tail original_legacyRows original_empiricalCount original_sourceCount snapshot703 original_formalReceipt snapshot704 snapshot707 snapshot706 snapshot708
   missingRow_field_rows missingRow_parse_ids missingRow_field_legacy parse_legacy
   missingRow_field_adverse parse_adverse missingRow_field_physics parse_physics missingRow_field_sources parse_sources
   missingRow_field_boundary missingRow_parse_hashes missingRow_parse_measurements missingRow_parse_legacyRows
   missingRow_field_empiricalCount missingRow_field_sourceCount missingRow_field_formal parse_formal
 exact assembled
#print axioms missingRowExtraction
theorem missingRow_uniqueVector : uniqueVector (original_ids.tail) original_empiricalCount = false := by
 unfold uniqueVector
 have count : (original_ids.tail.length == 234) = false := rfl
 rewrite [count, Bool.and_false]
 rfl
#print axioms missingRow_uniqueVector
theorem missingRow_hashesRetained : hashesRetained (original_hashes.tail) = true := rfl
#print axioms missingRow_hashesRetained
theorem missingRow_measurementsRetained : measurementsRetained (original_measurements.tail) = true := rfl
#print axioms missingRow_measurementsRetained
theorem missingRowComplete : GrandLockObservationAnalysis.recordCertificate missingRowTarget=.ok (.object [("unique_complete_empirical_vector",.boolean false),("all_empirical_and_external_hashes",.boolean true),("all_available_measurement_receipts_retained",.boolean true),("legacy_shape_exact",.boolean true),("adverse_scope_vector_exact",.boolean true),("external_source_vector_exact",.boolean true),("methodological_boundary",.boolean true),("formal_receipt_bound",.boolean true)]) := by
 rewrite [missingRowExtraction]
 unfold certificateFields
 rewrite [missingRow_uniqueVector, missingRow_hashesRetained, missingRow_measurementsRetained, original_legacyExact, original_adverseExact, original_sourcesExact, original_boundaryExact, original_receiptBound]
 rfl
#print axioms missingRowComplete
end SFT.Physics.GrandLockObservationAnalysisProofs
