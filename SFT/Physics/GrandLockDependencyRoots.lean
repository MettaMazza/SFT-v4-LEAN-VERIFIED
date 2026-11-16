import SFT.Physics.GrandLockRootTraceComplete
namespace SFT.Physics.GrandLockDependencyProofs
open SFT.Physics.GrandLockDependency
theorem originalRoots : allRooted originalRows originalPhysics = .ok true := SFT.Physics.GrandLockRootTrace.originalRoots
#print axioms originalRoots
end SFT.Physics.GrandLockDependencyProofs
