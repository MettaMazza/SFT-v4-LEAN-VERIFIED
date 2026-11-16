import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3733 : visit sourceDictionary534 535 visitedNode0 before3733 "SFT-PHYS-VALIDATION-CHARGED-LEPTON-TERMINAL-002" = .ok after3733 := rfl
#print axioms visitCall3733
end SFT.Physics.GrandLockDependencyTrace
