import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents121_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state121_4 [] = .ok state121_4 := rfl
theorem parents121_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state121_3 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state121_4 := rfl
theorem parents121_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state121_2 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state121_4 := rfl
theorem parents121_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state121_1 ["SFT-FOUNDATION-PART-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state121_4 := rfl
theorem parents121_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state121_0 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-PART-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state121_4 := by
 change (reachesOne sourceDictionary534 533 memoNode2334 "SFT-FOUNDATION-FOLD-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-FOUNDATION-PART-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall120]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state121_1 ["SFT-FOUNDATION-PART-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents121_1
theorem rootCall121 : reachesOne sourceDictionary534 534 memoNode2334 "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002" = .ok result121 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state121_0 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-PART-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002" result.1)) = _
 rewrite [parents121_0]
 rfl
#print axioms rootCall121
end SFT.Physics.GrandLockRootTrace
