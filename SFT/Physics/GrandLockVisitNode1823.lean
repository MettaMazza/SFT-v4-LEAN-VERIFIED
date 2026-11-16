import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall1823 : visit sourceDictionary534 534 visitedNode9427 before1823 "SFT-CHEM-ELEM-PERIODIC-ORDER-001" = .ok after1823 := rfl
#print axioms visitCall1823
end SFT.Physics.GrandLockDependencyTrace
