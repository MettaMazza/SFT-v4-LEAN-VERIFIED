import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem rootCall11 : reachesOne sourceDictionary534 535 memoNode223 "SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001" = .ok result11 := rfl
#print axioms rootCall11
end SFT.Physics.GrandLockRootTrace
