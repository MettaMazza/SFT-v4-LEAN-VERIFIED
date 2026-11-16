import SFT.Physics.GrandLockObservationOriginalStep0
import SFT.Physics.GrandLockObservationOriginalStep1
import SFT.Physics.GrandLockObservationOriginalStep2
import SFT.Physics.GrandLockObservationOriginalStep3
import SFT.Physics.GrandLockObservationOriginalStep4
import SFT.Physics.GrandLockObservationOriginalStep5
import SFT.Physics.GrandLockObservationOriginalStep6
import SFT.Physics.GrandLockObservationOriginalStep7
import SFT.Physics.GrandLockObservationOriginalStep8
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics.GrandLockObservationAnalysis
theorem originalComplete : recordCertificate originalTarget = .ok (.object [("unique_complete_empirical_vector",.boolean true),("all_empirical_and_external_hashes",.boolean true),("all_available_measurement_receipts_retained",.boolean true),("legacy_shape_exact",.boolean true),("adverse_scope_vector_exact",.boolean true),("external_source_vector_exact",.boolean true),("methodological_boundary",.boolean true),("formal_receipt_bound",.boolean true)]) := by
 rw [originalExtraction]
 unfold certificateFields
 rw [original_uniqueVector, original_hashesRetained, original_measurementsRetained, original_legacyExact, original_adverseExact, original_sourcesExact, original_boundaryExact, original_receiptBound]
#print axioms originalComplete
end SFT.Physics.GrandLockObservationAnalysisProofs
