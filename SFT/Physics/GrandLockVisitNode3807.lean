import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3807 : visit sourceDictionary534 535 visitedNode0 before3807 "SFT-PHYS-VALIDATION-FIELD-ELECTRIC-STRENGTH-001" = .ok after3807 := rfl
#print axioms visitCall3807
end SFT.Physics.GrandLockDependencyTrace
