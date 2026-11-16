import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents29_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state29_7 [] = .ok state29_7 := rfl
theorem parents29_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state29_6 ["SFT-MATH-ORDER-LATTICE-001"] = .ok state29_7 := rfl
theorem parents29_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state29_5 ["SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state29_7 := rfl
theorem parents29_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state29_4 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state29_7 := rfl
theorem parents29_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state29_3 ["SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state29_7 := rfl
theorem parents29_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state29_2 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state29_7 := rfl
theorem parents29_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state29_1 ["SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state29_7 := rfl
theorem parents29_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state29_0 ["SFT-PHYS-ATOMIC-CELL-ORBIT-CAPACITY-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state29_7 := by
 change (reachesOne sourceDictionary534 534 memoNode593 "SFT-PHYS-ATOMIC-CELL-ORBIT-CAPACITY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001"]) = _
 rewrite [rootCall28]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state29_1 ["SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001"] = _
 exact parents29_1
theorem rootCall29 : reachesOne sourceDictionary534 535 memoNode593 "SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005" = .ok result29 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state29_0 ["SFT-PHYS-ATOMIC-CELL-ORBIT-CAPACITY-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001"]; pure (result.1,put result.2 "SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005" result.1)) = _
 rewrite [parents29_0]
 rfl
#print axioms rootCall29
end SFT.Physics.GrandLockRootTrace
