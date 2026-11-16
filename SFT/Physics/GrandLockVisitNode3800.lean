import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3800 : visit sourceDictionary534 535 visitedNode0 before3800 "SFT-PHYS-VALIDATION-FIELD-ELECTRIC-POTENTIAL-001" = .ok after3800 := rfl
#print axioms visitCall3800
end SFT.Physics.GrandLockDependencyTrace
