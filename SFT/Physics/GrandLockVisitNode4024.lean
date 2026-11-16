import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall4024 : visit sourceDictionary534 535 visitedNode0 before4024 "SFT-PHYS-VALIDATION-VACUUM-EXTRACTION-003" = .ok after4024 := rfl
#print axioms visitCall4024
end SFT.Physics.GrandLockDependencyTrace
