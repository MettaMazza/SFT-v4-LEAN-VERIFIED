import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall2 : visit sourceDictionary534 533 visitedNode71 before2 "SFT-FOUNDATION-COUNT-001" = .ok after2 := rfl
#print axioms visitCall2
end SFT.Physics.GrandLockDependencyTrace
