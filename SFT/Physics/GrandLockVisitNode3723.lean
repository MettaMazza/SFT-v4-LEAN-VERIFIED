import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3723 : visit sourceDictionary534 535 visitedNode0 before3723 "SFT-PHYS-VALIDATION-CHARGED-LEPTON-KOIDE-002" = .ok after3723 := rfl
#print axioms visitCall3723
end SFT.Physics.GrandLockDependencyTrace
