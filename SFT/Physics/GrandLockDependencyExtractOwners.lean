import SFT.Physics.GrandLockDependencyOriginalData
namespace SFT.Physics.GrandLockDependencyProofs
open SFT.Host.Canonical SFT.Physics.GrandLockDependency SFT.Physics RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem originalOwners : recordMap (fun row=>do text (← field row "claim_id")) original_claims = .ok originalPhysics := rfl
#print axioms originalOwners
end SFT.Physics.GrandLockDependencyProofs
