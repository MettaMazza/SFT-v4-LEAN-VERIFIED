import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3601 : visit sourceDictionary534 535 visitedNode0 before3601 "SFT-PHYS-STRONG-CP-BARYON-STABILITY-TERMINAL-063" = .ok after3601 := rfl
#print axioms visitCall3601
end SFT.Physics.GrandLockDependencyTrace
