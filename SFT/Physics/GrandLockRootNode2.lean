import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents2_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state2_7 [] = .ok state2_7 := rfl
theorem parents2_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state2_6 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state2_7 := rfl
theorem parents2_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state2_5 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state2_7 := rfl
theorem parents2_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state2_4 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state2_7 := rfl
theorem parents2_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state2_3 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state2_7 := rfl
theorem parents2_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state2_2 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state2_7 := rfl
theorem parents2_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state2_1 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state2_7 := rfl
theorem parents2_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state2_0 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state2_7 := by
 change (reachesOne sourceDictionary534 533 memoNode0 "SFT-FOUNDATION-COUNT-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [rootCall1]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state2_1 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact parents2_1
theorem rootCall2 : reachesOne sourceDictionary534 534 memoNode0 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" = .ok result2 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state2_0 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]; pure (result.1,put result.2 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" result.1)) = _
 rewrite [parents2_0]
 rfl
#print axioms rootCall2
end SFT.Physics.GrandLockRootTrace
