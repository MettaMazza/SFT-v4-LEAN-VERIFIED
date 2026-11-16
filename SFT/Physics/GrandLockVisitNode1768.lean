import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall1768 : visit sourceDictionary534 533 visitedNode9869 before1768 "SFT-CHEM-MEAS-CHEMICAL-SPECIES-001" = .ok after1768 := rfl
#print axioms visitCall1768
end SFT.Physics.GrandLockDependencyTrace
