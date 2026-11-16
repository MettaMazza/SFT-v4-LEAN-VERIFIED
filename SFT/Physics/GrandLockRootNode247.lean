import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents247_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state247_3 [] = .ok state247_3 := rfl
theorem parents247_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state247_2 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"] = .ok state247_3 := rfl
theorem parents247_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state247_1 ["SFT-PHYS-MATTER-QUARK-DRESSING-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"] = .ok state247_3 := rfl
theorem parents247_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state247_0 ["SFT-PHYS-MATTER-CKM-PHYSICAL-003","SFT-PHYS-MATTER-QUARK-DRESSING-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"] = .ok state247_3 := by
 change (reachesOne sourceDictionary534 533 memoNode4327 "SFT-PHYS-MATTER-CKM-PHYSICAL-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-MATTER-QUARK-DRESSING-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"]) = _
 rewrite [rootCall246]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state247_1 ["SFT-PHYS-MATTER-QUARK-DRESSING-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"] = _
 exact parents247_1
theorem rootCall247 : reachesOne sourceDictionary534 534 memoNode4327 "SFT-PHYS-MATTER-CKM-TERMINAL-004" = .ok result247 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state247_0 ["SFT-PHYS-MATTER-CKM-PHYSICAL-003","SFT-PHYS-MATTER-QUARK-DRESSING-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-CKM-TERMINAL-004" result.1)) = _
 rewrite [parents247_0]
 rfl
#print axioms rootCall247
end SFT.Physics.GrandLockRootTrace
