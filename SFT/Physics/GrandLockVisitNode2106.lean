import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall2106 : visit sourceDictionary534 527 visitedNode12314 before2106 "SFT-PHYS-THERMO-SECOND-LAW-001" = .ok after2106 := rfl
#print axioms visitCall2106
end SFT.Physics.GrandLockDependencyTrace
