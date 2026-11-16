import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall1995 : visit sourceDictionary534 535 visitedNode0 before1995 "SFT-PHYS-ATOMIC-LAMB-SHIFT-TERMINAL-005" = .ok after1995 := rfl
#print axioms visitCall1995
end SFT.Physics.GrandLockDependencyTrace
