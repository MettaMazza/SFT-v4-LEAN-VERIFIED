import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents99_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state99_5 [] = .ok state99_5 := rfl
theorem parents99_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state99_4 ["SFT-MATH-COMBINATORICS-001"] = .ok state99_5 := rfl
theorem parents99_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state99_3 ["SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-COMBINATORICS-001"] = .ok state99_5 := rfl
theorem parents99_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state99_2 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-COMBINATORICS-001"] = .ok state99_5 := rfl
theorem parents99_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state99_1 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-COMBINATORICS-001"] = .ok state99_5 := rfl
theorem parents99_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state99_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-COMBINATORICS-001"] = .ok state99_5 := by
 change (reachesOne sourceDictionary534 532 memoNode1832 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [rootCall98]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state99_1 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-COMBINATORICS-001"] = _
 exact parents99_1
theorem rootCall99 : reachesOne sourceDictionary534 533 memoNode1832 "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002" = .ok result99 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state99_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-COMBINATORICS-001"]; pure (result.1,put result.2 "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002" result.1)) = _
 rewrite [parents99_0]
 rfl
#print axioms rootCall99
end SFT.Physics.GrandLockRootTrace
