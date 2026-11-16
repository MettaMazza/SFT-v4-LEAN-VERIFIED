import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3712 : visit sourceDictionary534 535 visitedNode0 before3712 "SFT-PHYS-VALIDATION-CHARGED-LEPTON-KOIDE-001" = .ok after3712 := rfl
#print axioms visitCall3712
end SFT.Physics.GrandLockDependencyTrace
