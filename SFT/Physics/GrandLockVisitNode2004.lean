import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall2004 : visit sourceDictionary534 535 visitedNode0 before2004 "SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005" = .ok after2004 := rfl
#print axioms visitCall2004
end SFT.Physics.GrandLockDependencyTrace
