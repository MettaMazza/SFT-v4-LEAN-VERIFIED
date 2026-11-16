import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3896 : visit sourceDictionary534 535 visitedNode0 before3896 "SFT-PHYS-VALIDATION-NONSTANDARD-SPACETIME-003" = .ok after3896 := rfl
#print axioms visitCall3896
end SFT.Physics.GrandLockDependencyTrace
