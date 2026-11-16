import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall4050 : visit sourceDictionary534 535 visitedNode0 before4050 "SFT-PHYS-VALIDATION-WAVE-ENERGY-001" = .ok after4050 := rfl
#print axioms visitCall4050
end SFT.Physics.GrandLockDependencyTrace
