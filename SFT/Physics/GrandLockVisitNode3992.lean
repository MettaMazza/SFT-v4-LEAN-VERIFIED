import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3992 : visit sourceDictionary534 535 visitedNode0 before3992 "SFT-PHYS-VALIDATION-THERMAL-EQUILIBRIUM-044" = .ok after3992 := rfl
#print axioms visitCall3992
end SFT.Physics.GrandLockDependencyTrace
