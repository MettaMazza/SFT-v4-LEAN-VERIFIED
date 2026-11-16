import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents125_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state125_5 [] = .ok state125_5 := rfl
theorem parents125_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state125_4 ["SFT-MATH-COMBINATORICS-001"] = .ok state125_5 := rfl
theorem parents125_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state125_3 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state125_5 := rfl
theorem parents125_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state125_2 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state125_5 := rfl
theorem parents125_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state125_1 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state125_5 := rfl
theorem parents125_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state125_0 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state125_5 := by
 change (reachesOne sourceDictionary534 534 memoNode2397 "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [rootCall124]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state125_1 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact parents125_1
theorem rootCall125 : reachesOne sourceDictionary534 535 memoNode2397 "SFT-PHYS-ELECTROWEAK-TERMINAL-ON-SHELL-003" = .ok result125 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state125_0 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]; pure (result.1,put result.2 "SFT-PHYS-ELECTROWEAK-TERMINAL-ON-SHELL-003" result.1)) = _
 rewrite [parents125_0]
 rfl
#print axioms rootCall125
end SFT.Physics.GrandLockRootTrace
