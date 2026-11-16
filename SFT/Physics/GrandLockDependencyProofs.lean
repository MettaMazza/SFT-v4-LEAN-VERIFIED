import SFT.Physics.GrandLockDependencyAssembly
import SFT.Physics.GrandLockDependencyExtractRows
import SFT.Physics.GrandLockDependencyExtractOwners
import SFT.Physics.GrandLockDependencyExtractEvidence
import SFT.Physics.GrandLockDependencyExtractUnique
import SFT.Physics.GrandLockDependencyExtractOmission
import SFT.Physics.GrandLockVisitTraceComplete
import SFT.Physics.GrandLockRootTraceComplete
namespace SFT.Physics.GrandLockDependencyProofs
open SFT.Host.Canonical SFT.Physics.GrandLockDependency SFT.Physics RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem field_dictionary : field originalTarget "dependency_dictionary" = .ok (.array original_dictionary) := rfl
theorem field_physics : field originalTarget "physics_claim_ids" = .ok (snapshot1071) := rfl
theorem field_declared : field originalTarget "physics_claim_count" = .ok (.integer 347) := rfl
theorem field_claims : field originalTarget "physics_claims" = .ok (.array original_claims) := rfl
theorem parse_physics : stringList snapshot1071 = .ok originalPhysics := rfl
theorem field_transitive : field originalTarget "transitive_claim_count" = .ok (.integer 534) := rfl
theorem field_empirical : field originalTarget "empirical_claim_count" = .ok (.integer 234) := rfl
theorem field_adverse : field originalTarget "unfavorable_or_scope_boundary_count" = .ok (.integer 14) := rfl
theorem originalComplete : dependencyCertificate originalTarget = .ok (.object [("physics_claim_count",.integer 347),("transitive_claim_count",.integer 534),("no_omission",.boolean true),("acyclic",.boolean true),("all_reach_one",.boolean true),("all_evidence_hash_bound",.boolean true),("empirical_claim_count",.integer 234),("unfavorable_or_scope_boundary_count",.integer 14)]) :=
 assembleOriginalRecord originalTarget original_dictionary original_claims originalRows originalPhysics originalPhysics
 snapshot1071 (.integer 347) (.integer 234) (.integer 14) (List.replicate 347 true) 534 true true
 field_dictionary extractOriginalRows field_physics parse_physics field_declared originalUnique
 SFT.Physics.GrandLockDependencyTrace.originalTraversal SFT.Physics.GrandLockRootTrace.originalRoots
 field_claims originalOwners originalEvidence originalOmission field_transitive field_empirical field_adverse (by rfl) (by rfl)
#print axioms originalComplete
end SFT.Physics.GrandLockDependencyProofs
