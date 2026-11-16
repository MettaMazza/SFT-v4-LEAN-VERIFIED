import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode354
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents355_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state355_3 [] = .ok state355_3 := rfl
theorem parents355_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state355_2 ["SFT-PHYS-NEUTRINO-CP-PHASE-002"] = .ok state355_3 := rfl
theorem parents355_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state355_1 ["SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-PHYS-NEUTRINO-CP-PHASE-002"] = .ok state355_3 := rfl
theorem parents355_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state355_0 ["SFT-PHYS-NEUTRINO-POSITIVE-MASS-003","SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-PHYS-NEUTRINO-CP-PHASE-002"] = .ok state355_3 := by
 change (reachesOne sourceDictionary534 533 memoNode5643 "SFT-PHYS-NEUTRINO-POSITIVE-MASS-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-PHYS-NEUTRINO-CP-PHASE-002"]) = _
 rewrite [rootCall354]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state355_1 ["SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-PHYS-NEUTRINO-CP-PHASE-002"] = _
 exact parents355_1
theorem rootCall355 : reachesOne sourceDictionary534 534 memoNode5643 "SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003" = .ok result355 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state355_0 ["SFT-PHYS-NEUTRINO-POSITIVE-MASS-003","SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-PHYS-NEUTRINO-CP-PHASE-002"]; pure (result.1,put result.2 "SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003" result.1)) = _
 rewrite [parents355_0]
 rfl
#print axioms rootCall355
end SFT.Physics.GrandLockRootTrace
