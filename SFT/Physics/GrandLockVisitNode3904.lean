import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3904 : visit sourceDictionary534 535 visitedNode0 before3904 "SFT-PHYS-VALIDATION-NUCLEAR-CLOSURES-001" = .ok after3904 := rfl
#print axioms visitCall3904
end SFT.Physics.GrandLockDependencyTrace
