import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3888 : visit sourceDictionary534 535 visitedNode0 before3888 "SFT-PHYS-VALIDATION-NEUTRINO-MASS-MIXING-003" = .ok after3888 := rfl
#print axioms visitCall3888
end SFT.Physics.GrandLockDependencyTrace
