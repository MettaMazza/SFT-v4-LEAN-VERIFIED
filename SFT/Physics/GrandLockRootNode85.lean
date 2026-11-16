import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents85_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state85_7 [] = .ok state85_7 := rfl
theorem parents85_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state85_6 ["SFT-MATH-ORDER-LATTICE-001"] = .ok state85_7 := rfl
theorem parents85_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state85_5 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state85_7 := rfl
theorem parents85_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state85_4 ["SFT-PHYS-COSMO-BRANCH-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state85_7 := rfl
theorem parents85_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state85_3 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-COSMO-BRANCH-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state85_7 := rfl
theorem parents85_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state85_2 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-COSMO-BRANCH-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state85_7 := rfl
theorem parents85_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state85_1 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-COSMO-BRANCH-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state85_7 := rfl
theorem parents85_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state85_0 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-COSMO-BRANCH-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state85_7 := by
 change (reachesOne sourceDictionary534 534 memoNode1511 "SFT-FOUNDATION-ONE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-COSMO-BRANCH-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"]) = _
 rewrite [rootCall84]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state85_1 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-COSMO-BRANCH-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = _
 exact parents85_1
theorem rootCall85 : reachesOne sourceDictionary534 535 memoNode1511 "SFT-PHYS-COSMO-SPATIAL-FLATNESS-001" = .ok result85 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state85_0 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-COSMO-BRANCH-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"]; pure (result.1,put result.2 "SFT-PHYS-COSMO-SPATIAL-FLATNESS-001" result.1)) = _
 rewrite [parents85_0]
 rfl
#print axioms rootCall85
end SFT.Physics.GrandLockRootTrace
