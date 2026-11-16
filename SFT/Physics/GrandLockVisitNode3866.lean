import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3866 : visit sourceDictionary534 535 visitedNode0 before3866 "SFT-PHYS-VALIDATION-MECHANICS-FORCE-001" = .ok after3866 := rfl
#print axioms visitCall3866
end SFT.Physics.GrandLockDependencyTrace
