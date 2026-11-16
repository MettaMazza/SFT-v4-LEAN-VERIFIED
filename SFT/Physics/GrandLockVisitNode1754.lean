import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall1754 : visit sourceDictionary534 533 visitedNode9869 before1754 "SFT-CHEM-MEAS-CHEMICAL-ENTITY-001" = .ok after1754 := rfl
#print axioms visitCall1754
end SFT.Physics.GrandLockDependencyTrace
