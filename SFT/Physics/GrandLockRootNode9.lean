import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode8
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents9_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state9_4 [] = .ok state9_4 := rfl
theorem parents9_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state9_3 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state9_4 := rfl
theorem parents9_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state9_2 ["SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state9_4 := rfl
theorem parents9_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state9_1 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state9_4 := rfl
theorem parents9_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state9_0 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state9_4 := by
 change (reachesOne sourceDictionary534 534 memoNode170 "SFT-PHYS-SPACE-DIMENSION-THREE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall8]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state9_1 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents9_1
theorem rootCall9 : reachesOne sourceDictionary534 535 memoNode170 "SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004" = .ok result9 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state9_0 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004" result.1)) = _
 rewrite [parents9_0]
 rfl
#print axioms rootCall9
end SFT.Physics.GrandLockRootTrace
