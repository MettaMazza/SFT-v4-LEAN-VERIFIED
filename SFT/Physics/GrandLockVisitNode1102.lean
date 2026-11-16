import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall1102 : visit sourceDictionary534 530 visitedNode5993 before1102 "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001" = .ok after1102 := rfl
#print axioms visitCall1102
end SFT.Physics.GrandLockDependencyTrace
