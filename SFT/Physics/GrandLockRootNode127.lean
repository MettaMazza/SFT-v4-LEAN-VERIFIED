import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents127_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state127_3 [] = .ok state127_3 := rfl
theorem parents127_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state127_2 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state127_3 := rfl
theorem parents127_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state127_1 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state127_3 := rfl
theorem parents127_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state127_0 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state127_3 := by
 change (reachesOne sourceDictionary534 534 memoNode2435 "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall126]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state127_1 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents127_1
theorem rootCall127 : reachesOne sourceDictionary534 535 memoNode2435 "SFT-PHYS-ELECTROWEAK-WZ-RATIO-002" = .ok result127 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state127_0 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-ELECTROWEAK-WZ-RATIO-002" result.1)) = _
 rewrite [parents127_0]
 rfl
#print axioms rootCall127
end SFT.Physics.GrandLockRootTrace
