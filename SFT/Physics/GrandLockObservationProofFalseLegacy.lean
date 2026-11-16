import SFT.Physics.GrandLockObservationFalseLegacyComponents
import SFT.Physics.GrandLockObservationRecordAssembly
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem falseLegacyExtraction : recordCertificate falseLegacyTarget = .ok (certificateFields original_ids (([] : List String)) original_adverse original_physics original_sources original_hashes (falseLegacy_measurements) original_legacyRows original_empiricalCount original_sourceCount original_boundary original_requiredTrue original_formalReceipt) := by
 have assembled := assembleRecord falseLegacyTarget original_rows original_ids ([] : List String) original_adverse original_physics original_sources _ original_hashes falseLegacy_measurements original_legacyRows original_empiricalCount original_sourceCount snapshot703 original_formalReceipt (.array []) snapshot707 snapshot706 snapshot708
   falseLegacy_field_rows parse_ids falseLegacy_field_legacy falseLegacy_parse_legacy
   falseLegacy_field_adverse parse_adverse falseLegacy_field_physics parse_physics falseLegacy_field_sources parse_sources
   falseLegacy_field_boundary parse_hashes falseLegacy_parse_measurements parse_legacyRows
   falseLegacy_field_empiricalCount falseLegacy_field_sourceCount falseLegacy_field_formal parse_formal
 exact assembled
#print axioms falseLegacyExtraction
theorem falseLegacy_measurementsRetained : measurementsRetained (falseLegacy_measurements) = false := rfl
#print axioms falseLegacy_measurementsRetained
theorem falseLegacy_legacyExact : legacyExact (([] : List String)) original_legacyRows = false := rfl
#print axioms falseLegacy_legacyExact
theorem falseLegacyComplete : GrandLockObservationAnalysis.recordCertificate falseLegacyTarget=.ok (.object [("unique_complete_empirical_vector",.boolean true),("all_empirical_and_external_hashes",.boolean true),("all_available_measurement_receipts_retained",.boolean false),("legacy_shape_exact",.boolean false),("adverse_scope_vector_exact",.boolean true),("external_source_vector_exact",.boolean true),("methodological_boundary",.boolean true),("formal_receipt_bound",.boolean true)]) := by
 rewrite [falseLegacyExtraction]
 unfold certificateFields
 rewrite [original_uniqueVector, original_hashesRetained, falseLegacy_measurementsRetained, falseLegacy_legacyExact, original_adverseExact, original_sourcesExact, original_boundaryExact, original_receiptBound]
 rfl
#print axioms falseLegacyComplete
end SFT.Physics.GrandLockObservationAnalysisProofs
