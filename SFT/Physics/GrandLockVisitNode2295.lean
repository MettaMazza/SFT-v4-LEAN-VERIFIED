import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall2295 : visit sourceDictionary534 533 visitedNode13882 before2295 "SFT-PHYS-THERMO-RESPONSE-001" = .ok after2295 := rfl
#print axioms visitCall2295
end SFT.Physics.GrandLockDependencyTrace
