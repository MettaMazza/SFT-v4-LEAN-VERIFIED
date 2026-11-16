import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3940 : visit sourceDictionary534 535 visitedNode0 before3940 "SFT-PHYS-VALIDATION-PROTON-PLANCK-TERMINAL-003" = .ok after3940 := rfl
#print axioms visitCall3940
end SFT.Physics.GrandLockDependencyTrace
