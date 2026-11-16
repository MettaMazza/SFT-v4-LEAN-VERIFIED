import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents73_8 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state73_8 [] = .ok state73_8 := rfl
theorem parents73_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state73_7 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state73_8 := rfl
theorem parents73_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state73_6 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state73_8 := rfl
theorem parents73_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state73_5 ["SFT-FOUNDATION-FOLD-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state73_8 := rfl
theorem parents73_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state73_4 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state73_8 := rfl
theorem parents73_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state73_3 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state73_8 := rfl
theorem parents73_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state73_2 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state73_8 := rfl
theorem parents73_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state73_1 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state73_8 := rfl
theorem parents73_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state73_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state73_8 := by
 change (reachesOne sourceDictionary534 534 memoNode1362 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [rootCall72]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state73_1 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact parents73_1
theorem rootCall73 : reachesOne sourceDictionary534 535 memoNode1362 "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001" = .ok result73 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state73_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]; pure (result.1,put result.2 "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001" result.1)) = _
 rewrite [parents73_0]
 rfl
#print axioms rootCall73
end SFT.Physics.GrandLockRootTrace
