import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode242
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents243_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state243_3 [] = .ok state243_3 := rfl
theorem parents243_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state243_2 ["SFT-PHYS-VALIDATION-INVERSE-FINE-STRUCTURE-001"] = .ok state243_3 := rfl
theorem parents243_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state243_1 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-VALIDATION-INVERSE-FINE-STRUCTURE-001"] = .ok state243_3 := rfl
theorem parents243_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state243_0 ["SFT-PHYS-MATTER-QUARK-CUBICS-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-VALIDATION-INVERSE-FINE-STRUCTURE-001"] = .ok state243_3 := by
 change (reachesOne sourceDictionary534 532 memoNode4186 "SFT-PHYS-MATTER-QUARK-CUBICS-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-VALIDATION-INVERSE-FINE-STRUCTURE-001"]) = _
 rewrite [rootCall242]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state243_1 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-VALIDATION-INVERSE-FINE-STRUCTURE-001"] = _
 exact parents243_1
theorem rootCall243 : reachesOne sourceDictionary534 533 memoNode4186 "SFT-PHYS-MATTER-QUARK-DRESSING-003" = .ok result243 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state243_0 ["SFT-PHYS-MATTER-QUARK-CUBICS-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-VALIDATION-INVERSE-FINE-STRUCTURE-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-QUARK-DRESSING-003" result.1)) = _
 rewrite [parents243_0]
 rfl
#print axioms rootCall243
end SFT.Physics.GrandLockRootTrace
