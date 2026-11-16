import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents358_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state358_4 [] = .ok state358_4 := rfl
theorem parents358_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state358_3 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state358_4 := rfl
theorem parents358_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state358_2 ["SFT-PHYS-QUANTUM-PHYSICAL-STATE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state358_4 := rfl
theorem parents358_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state358_1 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-QUANTUM-PHYSICAL-STATE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state358_4 := rfl
theorem parents358_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state358_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-QUANTUM-PHYSICAL-STATE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state358_4 := by
 change (reachesOne sourceDictionary534 534 memoNode5748 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-QUANTUM-PHYSICAL-STATE-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall357]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state358_1 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-QUANTUM-PHYSICAL-STATE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents358_1
theorem rootCall358 : reachesOne sourceDictionary534 535 memoNode5748 "SFT-PHYS-NEUTRINO-PMNS-ANGLES-002" = .ok result358 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state358_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-QUANTUM-PHYSICAL-STATE-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-NEUTRINO-PMNS-ANGLES-002" result.1)) = _
 rewrite [parents358_0]
 rfl
#print axioms rootCall358
end SFT.Physics.GrandLockRootTrace
