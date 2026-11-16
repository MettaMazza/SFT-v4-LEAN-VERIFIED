import SFT.Physics.GrandLockDependencyOriginalData
namespace SFT.Physics.GrandLockDependencyProofs
open SFT.Host.Canonical SFT.Physics.GrandLockDependency SFT.Physics RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem extractOriginalRows : recordMap (fun row=>do pure ((← text (← field row "claim_id")),(← stringList (← field row "dependencies")))) original_dictionary = .ok originalRows := rfl
#print axioms extractOriginalRows
end SFT.Physics.GrandLockDependencyProofs
