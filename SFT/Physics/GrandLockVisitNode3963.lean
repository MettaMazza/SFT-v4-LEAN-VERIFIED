import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3963 : visit sourceDictionary534 535 visitedNode0 before3963 "SFT-PHYS-VALIDATION-SPIN-STATISTICS-CONDENSATION-046" = .ok after3963 := rfl
#print axioms visitCall3963
end SFT.Physics.GrandLockDependencyTrace
