import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents13_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state13_4 [] = .ok state13_4 := rfl
theorem parents13_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state13_3 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state13_4 := rfl
theorem parents13_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state13_2 ["SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state13_4 := rfl
theorem parents13_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state13_1 ["SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003","SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state13_4 := rfl
theorem parents13_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state13_0 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003","SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state13_4 := by
 change (reachesOne sourceDictionary534 532 memoNode256 "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003","SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall12]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state13_1 ["SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003","SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents13_1
theorem rootCall13 : reachesOne sourceDictionary534 533 memoNode256 "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004" = .ok result13 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state13_0 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003","SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004" result.1)) = _
 rewrite [parents13_0]
 rfl
#print axioms rootCall13
end SFT.Physics.GrandLockRootTrace
