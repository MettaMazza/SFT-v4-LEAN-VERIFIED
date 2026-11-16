import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents57_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state57_7 [] = .ok state57_7 := rfl
theorem parents57_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state57_6 ["SFT-MATH-ALGEBRA-001"] = .ok state57_7 := rfl
theorem parents57_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state57_5 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = .ok state57_7 := rfl
theorem parents57_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state57_4 ["SFT-FOUNDATION-PART-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = .ok state57_7 := rfl
theorem parents57_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state57_3 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = .ok state57_7 := rfl
theorem parents57_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state57_2 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = .ok state57_7 := rfl
theorem parents57_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state57_1 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = .ok state57_7 := rfl
theorem parents57_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state57_0 ["SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = .ok state57_7 := by
 change (reachesOne sourceDictionary534 534 memoNode1095 "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"]) = _
 rewrite [rootCall56]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state57_1 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"] = _
 exact parents57_1
theorem rootCall57 : reachesOne sourceDictionary534 535 memoNode1095 "SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001" = .ok result57 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state57_0 ["SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ALGEBRA-001"]; pure (result.1,put result.2 "SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001" result.1)) = _
 rewrite [parents57_0]
 rfl
#print axioms rootCall57
end SFT.Physics.GrandLockRootTrace
