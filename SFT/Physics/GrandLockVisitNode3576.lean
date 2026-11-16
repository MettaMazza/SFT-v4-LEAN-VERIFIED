import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3576 : visit sourceDictionary534 535 visitedNode0 before3576 "SFT-PHYS-STATIC-EXTERIOR-CLOCK-TERMINAL-011" = .ok after3576 := rfl
#print axioms visitCall3576
end SFT.Physics.GrandLockDependencyTrace
