import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall1803 : visit sourceDictionary534 534 visitedNode9427 before1803 "SFT-CHEM-ELEM-ATOMIC-NUMBER-001" = .ok after1803 := rfl
#print axioms visitCall1803
end SFT.Physics.GrandLockDependencyTrace
