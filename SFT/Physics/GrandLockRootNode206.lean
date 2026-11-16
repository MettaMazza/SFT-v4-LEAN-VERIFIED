import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode205
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents206_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) state206_3 [] = .ok state206_3 := rfl
theorem parents206_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) state206_2 ["SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003"] = .ok state206_3 := rfl
theorem parents206_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) state206_1 ["SFT-PHYS-SPACETIME-INTERVAL-001","SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003"] = .ok state206_3 := rfl
theorem parents206_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) state206_0 ["SFT-PHYS-GRAVITY-WEAK-FIELD-FLUX-003","SFT-PHYS-SPACETIME-INTERVAL-001","SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003"] = .ok state206_3 := by
 change (reachesOne sourceDictionary534 529 memoNode3595 "SFT-PHYS-GRAVITY-WEAK-FIELD-FLUX-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) next ["SFT-PHYS-SPACETIME-INTERVAL-001","SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003"]) = _
 rewrite [rootCall205]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) state206_1 ["SFT-PHYS-SPACETIME-INTERVAL-001","SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003"] = _
 exact parents206_1
theorem rootCall206 : reachesOne sourceDictionary534 530 memoNode3595 "SFT-PHYS-SPACETIME-EXACT-INTERVAL-003" = .ok result206 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) state206_0 ["SFT-PHYS-GRAVITY-WEAK-FIELD-FLUX-003","SFT-PHYS-SPACETIME-INTERVAL-001","SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003"]; pure (result.1,put result.2 "SFT-PHYS-SPACETIME-EXACT-INTERVAL-003" result.1)) = _
 rewrite [parents206_0]
 rfl
#print axioms rootCall206
end SFT.Physics.GrandLockRootTrace
