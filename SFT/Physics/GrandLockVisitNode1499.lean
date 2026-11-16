import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall1499 : visit sourceDictionary534 533 visitedNode834 before1499 "SFT-PHYS-QUANTUM-INCOMPATIBILITY-001" = .ok after1499 := rfl
#print axioms visitCall1499
end SFT.Physics.GrandLockDependencyTrace
