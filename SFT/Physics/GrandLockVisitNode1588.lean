import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall1588 : visit sourceDictionary534 532 visitedNode8541 before1588 "SFT-PHYS-FIELD-INVERSE-SQUARE-001" = .ok after1588 := rfl
#print axioms visitCall1588
end SFT.Physics.GrandLockDependencyTrace
