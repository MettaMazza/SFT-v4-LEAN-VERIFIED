import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents17_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state17_6 [] = .ok state17_6 := rfl
theorem parents17_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state17_5 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state17_6 := rfl
theorem parents17_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state17_4 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state17_6 := rfl
theorem parents17_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state17_3 ["SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state17_6 := rfl
theorem parents17_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state17_2 ["SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state17_6 := rfl
theorem parents17_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state17_1 ["SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state17_6 := rfl
theorem parents17_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state17_0 ["SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004","SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state17_6 := by
 change (reachesOne sourceDictionary534 534 memoNode369 "SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall16]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state17_1 ["SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents17_1
theorem rootCall17 : reachesOne sourceDictionary534 535 memoNode369 "SFT-PHYS-ATOMIC-FINE-STRUCTURE-TERMINAL-005" = .ok result17 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state17_0 ["SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004","SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-ATOMIC-FINE-STRUCTURE-TERMINAL-005" result.1)) = _
 rewrite [parents17_0]
 rfl
#print axioms rootCall17
end SFT.Physics.GrandLockRootTrace
