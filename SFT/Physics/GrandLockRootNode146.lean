import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode145
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents146_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state146_3 [] = .ok state146_3 := rfl
theorem parents146_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state146_2 ["SFT-PHYS-MECH-CONSERVATION-001"] = .ok state146_3 := rfl
theorem parents146_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state146_1 ["SFT-PHYS-MECH-FORCE-001","SFT-PHYS-MECH-CONSERVATION-001"] = .ok state146_3 := rfl
theorem parents146_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state146_0 ["SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-MECH-FORCE-001","SFT-PHYS-MECH-CONSERVATION-001"] = .ok state146_3 := by
 change (reachesOne sourceDictionary534 530 memoNode2758 "SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) next ["SFT-PHYS-MECH-FORCE-001","SFT-PHYS-MECH-CONSERVATION-001"]) = _
 rewrite [rootCall145]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state146_1 ["SFT-PHYS-MECH-FORCE-001","SFT-PHYS-MECH-CONSERVATION-001"] = _
 exact parents146_1
theorem rootCall146 : reachesOne sourceDictionary534 531 memoNode2758 "SFT-PHYS-FIELD-LORENTZ-TRANSFER-003" = .ok result146 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state146_0 ["SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-MECH-FORCE-001","SFT-PHYS-MECH-CONSERVATION-001"]; pure (result.1,put result.2 "SFT-PHYS-FIELD-LORENTZ-TRANSFER-003" result.1)) = _
 rewrite [parents146_0]
 rfl
#print axioms rootCall146
end SFT.Physics.GrandLockRootTrace
