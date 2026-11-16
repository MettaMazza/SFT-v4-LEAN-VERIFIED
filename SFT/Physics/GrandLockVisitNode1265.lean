import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall1265 : visit sourceDictionary534 525 visitedNode6604 before1265 "SFT-PHYS-MECH-FORCE-001" = .ok after1265 := rfl
#print axioms visitCall1265
end SFT.Physics.GrandLockDependencyTrace
