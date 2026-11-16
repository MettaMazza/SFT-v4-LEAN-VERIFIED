import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3770 : visit sourceDictionary534 535 visitedNode0 before3770 "SFT-PHYS-VALIDATION-CRITICALITY-MEASURED-VALUE-056" = .ok after3770 := rfl
#print axioms visitCall3770
end SFT.Physics.GrandLockDependencyTrace
