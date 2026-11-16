import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents421_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state421_5 [] = .ok state421_5 := rfl
theorem parents421_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state421_4 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state421_5 := rfl
theorem parents421_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state421_3 ["SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state421_5 := rfl
theorem parents421_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state421_2 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state421_5 := rfl
theorem parents421_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state421_1 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state421_5 := rfl
theorem parents421_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state421_0 ["SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state421_5 := by
 change (reachesOne sourceDictionary534 534 memoNode6663 "SFT-FOUNDATION-EXACT-OPERATIONS-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall420]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state421_1 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents421_1
theorem rootCall421 : reachesOne sourceDictionary534 535 memoNode6663 "SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004" = .ok result421 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state421_0 ["SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004" result.1)) = _
 rewrite [parents421_0]
 rfl
#print axioms rootCall421
end SFT.Physics.GrandLockRootTrace
