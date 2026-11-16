import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents464_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state464_3 [] = .ok state464_3 := rfl
theorem parents464_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state464_2 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state464_3 := rfl
theorem parents464_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state464_1 ["SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state464_3 := rfl
theorem parents464_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state464_0 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state464_3 := by
 change (reachesOne sourceDictionary534 534 memoNode7254 "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall463]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state464_1 ["SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents464_1
theorem rootCall464 : reachesOne sourceDictionary534 535 memoNode7254 "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002" = .ok result464 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state464_0 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002" result.1)) = _
 rewrite [parents464_0]
 rfl
#print axioms rootCall464
end SFT.Physics.GrandLockRootTrace
