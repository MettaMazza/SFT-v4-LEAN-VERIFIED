import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents22_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state22_7 [] = .ok state22_7 := rfl
theorem parents22_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state22_6 ["SFT-MATH-ALGEBRA-001"] = .ok state22_7 := rfl
theorem parents22_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state22_5 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = .ok state22_7 := rfl
theorem parents22_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state22_4 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = .ok state22_7 := rfl
theorem parents22_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state22_3 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = .ok state22_7 := rfl
theorem parents22_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state22_2 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = .ok state22_7 := rfl
theorem parents22_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state22_1 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = .ok state22_7 := rfl
theorem parents22_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state22_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = .ok state22_7 := by
 change (reachesOne sourceDictionary534 531 memoNode430 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) next ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"]) = _
 rewrite [rootCall21]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state22_1 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = _
 exact parents22_1
theorem rootCall22 : reachesOne sourceDictionary534 532 memoNode430 "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001" = .ok result22 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state22_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"]; pure (result.1,put result.2 "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001" result.1)) = _
 rewrite [parents22_0]
 rfl
#print axioms rootCall22
end SFT.Physics.GrandLockRootTrace
