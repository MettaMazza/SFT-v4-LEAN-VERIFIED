import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents241_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state241_3 [] = .ok state241_3 := rfl
theorem parents241_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state241_2 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"] = .ok state241_3 := rfl
theorem parents241_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state241_1 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"] = .ok state241_3 := rfl
theorem parents241_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state241_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"] = .ok state241_3 := by
 change (reachesOne sourceDictionary534 530 memoNode4186 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) next ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"]) = _
 rewrite [rootCall240]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state241_1 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"] = _
 exact parents241_1
theorem rootCall241 : reachesOne sourceDictionary534 531 memoNode4186 "SFT-PHYS-MATTER-QUARK-INVARIANTS-003" = .ok result241 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state241_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-QUARK-INVARIANTS-003" result.1)) = _
 rewrite [parents241_0]
 rfl
#print axioms rootCall241
end SFT.Physics.GrandLockRootTrace
