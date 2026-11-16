import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall2021 : visit sourceDictionary534 533 visitedNode12120 before2021 "SFT-PHYS-WAVE-ENERGY-MOMENTUM-001" = .ok after2021 := rfl
#print axioms visitCall2021
end SFT.Physics.GrandLockDependencyTrace
