import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem visitCall1983 : visit sourceDictionary534 534 visitedNode10970 before1983 "SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005" = .ok after1983 := rfl
#print axioms visitCall1983
end SFT.Physics.GrandLockDependencyTrace
