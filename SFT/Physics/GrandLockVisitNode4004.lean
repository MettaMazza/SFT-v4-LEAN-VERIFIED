import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall4004 : visit sourceDictionary534 535 visitedNode0 before4004 "SFT-PHYS-VALIDATION-THERMAL-HISTORY-RECOMBINATION-038" = .ok after4004 := rfl
#print axioms visitCall4004
end SFT.Physics.GrandLockDependencyTrace
