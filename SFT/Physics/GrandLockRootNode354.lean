import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode353
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents354_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state354_3 [] = .ok state354_3 := rfl
theorem parents354_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state354_2 ["SFT-PHYS-NEUTRINO-PMNS-ANGLES-002"] = .ok state354_3 := rfl
theorem parents354_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state354_1 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-PHYS-NEUTRINO-PMNS-ANGLES-002"] = .ok state354_3 := rfl
theorem parents354_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state354_0 ["SFT-PHYS-NEUTRINO-SPLITTING-003","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-PHYS-NEUTRINO-PMNS-ANGLES-002"] = .ok state354_3 := by
 change (reachesOne sourceDictionary534 532 memoNode5643 "SFT-PHYS-NEUTRINO-SPLITTING-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-PHYS-NEUTRINO-PMNS-ANGLES-002"]) = _
 rewrite [rootCall353]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state354_1 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-PHYS-NEUTRINO-PMNS-ANGLES-002"] = _
 exact parents354_1
theorem rootCall354 : reachesOne sourceDictionary534 533 memoNode5643 "SFT-PHYS-NEUTRINO-POSITIVE-MASS-003" = .ok result354 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state354_0 ["SFT-PHYS-NEUTRINO-SPLITTING-003","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-PHYS-NEUTRINO-PMNS-ANGLES-002"]; pure (result.1,put result.2 "SFT-PHYS-NEUTRINO-POSITIVE-MASS-003" result.1)) = _
 rewrite [parents354_0]
 rfl
#print axioms rootCall354
end SFT.Physics.GrandLockRootTrace
