import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents31_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state31_7 [] = .ok state31_7 := rfl
theorem parents31_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state31_6 ["SFT-MATH-COMBINATORICS-001"] = .ok state31_7 := rfl
theorem parents31_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state31_5 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state31_7 := rfl
theorem parents31_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state31_4 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state31_7 := rfl
theorem parents31_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state31_3 ["SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state31_7 := rfl
theorem parents31_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state31_2 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state31_7 := rfl
theorem parents31_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state31_1 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state31_7 := rfl
theorem parents31_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state31_0 ["SFT-PHYS-ATOMIC-TRANSITION-SELECTION-004","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state31_7 := by
 change (reachesOne sourceDictionary534 534 memoNode626 "SFT-PHYS-ATOMIC-TRANSITION-SELECTION-004" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [rootCall30]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state31_1 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact parents31_1
theorem rootCall31 : reachesOne sourceDictionary534 535 memoNode626 "SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005" = .ok result31 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state31_0 ["SFT-PHYS-ATOMIC-TRANSITION-SELECTION-004","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]; pure (result.1,put result.2 "SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005" result.1)) = _
 rewrite [parents31_0]
 rfl
#print axioms rootCall31
end SFT.Physics.GrandLockRootTrace
