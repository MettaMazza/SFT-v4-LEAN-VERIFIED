import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3999 : visit sourceDictionary534 535 visitedNode0 before3999 "SFT-PHYS-VALIDATION-THERMAL-HISTORY-MEASURED-VALUE-058" = .ok after3999 := rfl
#print axioms visitCall3999
end SFT.Physics.GrandLockDependencyTrace
