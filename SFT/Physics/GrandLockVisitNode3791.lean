import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3791 : visit sourceDictionary534 535 visitedNode0 before3791 "SFT-PHYS-VALIDATION-DYNAMICS-SPECTRA-003" = .ok after3791 := rfl
#print axioms visitCall3791
end SFT.Physics.GrandLockDependencyTrace
