import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode146
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents147_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state147_3 [] = .ok state147_3 := rfl
theorem parents147_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state147_2 ["SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = .ok state147_3 := rfl
theorem parents147_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state147_1 ["SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = .ok state147_3 := rfl
theorem parents147_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state147_0 ["SFT-PHYS-FIELD-LORENTZ-TRANSFER-003","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = .ok state147_3 := by
 change (reachesOne sourceDictionary534 531 memoNode2758 "SFT-PHYS-FIELD-LORENTZ-TRANSFER-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) next ["SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"]) = _
 rewrite [rootCall146]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state147_1 ["SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = _
 exact parents147_1
theorem rootCall147 : reachesOne sourceDictionary534 532 memoNode2758 "SFT-PHYS-FIELD-MAXWELL-PLANAR-CLOSURE-003" = .ok result147 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state147_0 ["SFT-PHYS-FIELD-LORENTZ-TRANSFER-003","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"]; pure (result.1,put result.2 "SFT-PHYS-FIELD-MAXWELL-PLANAR-CLOSURE-003" result.1)) = _
 rewrite [parents147_0]
 rfl
#print axioms rootCall147
end SFT.Physics.GrandLockRootTrace
