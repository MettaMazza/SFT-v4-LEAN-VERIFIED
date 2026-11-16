import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents145_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) state145_3 [] = .ok state145_3 := rfl
theorem parents145_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) state145_2 ["SFT-PHYS-SPACETIME-LIMIT-SPEED-001"] = .ok state145_3 := rfl
theorem parents145_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) state145_1 ["SFT-PHYS-FIELD-MAGNETIC-001","SFT-PHYS-SPACETIME-LIMIT-SPEED-001"] = .ok state145_3 := rfl
theorem parents145_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) state145_0 ["SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003","SFT-PHYS-FIELD-MAGNETIC-001","SFT-PHYS-SPACETIME-LIMIT-SPEED-001"] = .ok state145_3 := by
 change (reachesOne sourceDictionary534 529 memoNode2758 "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) next ["SFT-PHYS-FIELD-MAGNETIC-001","SFT-PHYS-SPACETIME-LIMIT-SPEED-001"]) = _
 rewrite [rootCall144]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) state145_1 ["SFT-PHYS-FIELD-MAGNETIC-001","SFT-PHYS-SPACETIME-LIMIT-SPEED-001"] = _
 exact parents145_1
theorem rootCall145 : reachesOne sourceDictionary534 530 memoNode2758 "SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003" = .ok result145 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 529 cache dep) state145_0 ["SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003","SFT-PHYS-FIELD-MAGNETIC-001","SFT-PHYS-SPACETIME-LIMIT-SPEED-001"]; pure (result.1,put result.2 "SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003" result.1)) = _
 rewrite [parents145_0]
 rfl
#print axioms rootCall145
end SFT.Physics.GrandLockRootTrace
