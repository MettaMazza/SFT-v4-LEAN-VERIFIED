import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall1895 : visit sourceDictionary534 535 visitedNode0 before1895 "SFT-PHYS-ATOMIC-FINE-STRUCTURE-TERMINAL-005" = .ok after1895 := rfl
#print axioms visitCall1895
end SFT.Physics.GrandLockDependencyTrace
