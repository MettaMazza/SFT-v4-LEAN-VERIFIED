import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall2344 : visit sourceDictionary534 533 visitedNode13882 before2344 "SFT-PHYS-FLUID-TURBULENCE-001" = .ok after2344 := rfl
#print axioms visitCall2344
end SFT.Physics.GrandLockDependencyTrace
