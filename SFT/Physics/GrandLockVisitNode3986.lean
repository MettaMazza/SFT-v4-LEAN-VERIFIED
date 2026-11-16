import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall3986 : visit sourceDictionary534 535 visitedNode0 before3986 "SFT-PHYS-VALIDATION-STRONG-CP-BARYON-STABILITY-064" = .ok after3986 := rfl
#print axioms visitCall3986
end SFT.Physics.GrandLockDependencyTrace
