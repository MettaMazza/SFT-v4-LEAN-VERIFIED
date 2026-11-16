import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents8_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state8_7 [] = .ok state8_7 := rfl
theorem parents8_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state8_6 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state8_7 := rfl
theorem parents8_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state8_5 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state8_7 := rfl
theorem parents8_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state8_4 ["SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state8_7 := rfl
theorem parents8_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state8_3 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state8_7 := rfl
theorem parents8_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state8_2 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state8_7 := rfl
theorem parents8_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state8_1 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state8_7 := rfl
theorem parents8_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state8_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state8_7 := by
 change (reachesOne sourceDictionary534 533 memoNode170 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [rootCall7]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state8_1 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact parents8_1
theorem rootCall8 : reachesOne sourceDictionary534 534 memoNode170 "SFT-PHYS-SPACE-DIMENSION-THREE-001" = .ok result8 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state8_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]; pure (result.1,put result.2 "SFT-PHYS-SPACE-DIMENSION-THREE-001" result.1)) = _
 rewrite [parents8_0]
 rfl
#print axioms rootCall8
end SFT.Physics.GrandLockRootTrace
