import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall4036 : visit sourceDictionary534 535 visitedNode0 before4036 "SFT-PHYS-VALIDATION-VACUUM-INERTIA-003" = .ok after4036 := rfl
#print axioms visitCall4036
end SFT.Physics.GrandLockDependencyTrace
