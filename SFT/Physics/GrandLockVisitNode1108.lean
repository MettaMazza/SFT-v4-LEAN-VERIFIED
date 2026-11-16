import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall1108 : visit sourceDictionary534 530 visitedNode5993 before1108 "SFT-PHYS-MEAS-TARGET-CUSTODY-001" = .ok after1108 := rfl
#print axioms visitCall1108
end SFT.Physics.GrandLockDependencyTrace
