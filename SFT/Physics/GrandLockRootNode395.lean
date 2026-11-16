import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents395_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state395_5 [] = .ok state395_5 := rfl
theorem parents395_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state395_4 ["SFT-MATH-COMBINATORICS-001"] = .ok state395_5 := rfl
theorem parents395_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state395_3 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state395_5 := rfl
theorem parents395_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state395_2 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state395_5 := rfl
theorem parents395_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state395_1 ["SFT-FOUNDATION-FOLD-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state395_5 := rfl
theorem parents395_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state395_0 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state395_5 := by
 change (reachesOne sourceDictionary534 532 memoNode6218 "SFT-FOUNDATION-PART-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-FOUNDATION-FOLD-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [rootCall394]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state395_1 ["SFT-FOUNDATION-FOLD-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact parents395_1
theorem rootCall395 : reachesOne sourceDictionary534 533 memoNode6218 "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003" = .ok result395 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state395_0 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]; pure (result.1,put result.2 "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003" result.1)) = _
 rewrite [parents395_0]
 rfl
#print axioms rootCall395
end SFT.Physics.GrandLockRootTrace
