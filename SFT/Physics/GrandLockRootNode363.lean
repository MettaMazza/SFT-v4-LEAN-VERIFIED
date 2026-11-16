import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents363_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state363_3 [] = .ok state363_3 := rfl
theorem parents363_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state363_2 ["SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003"] = .ok state363_3 := rfl
theorem parents363_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state363_1 ["SFT-PHYS-NEUTRINO-POSITIVE-MASS-003","SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003"] = .ok state363_3 := rfl
theorem parents363_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state363_0 ["SFT-PHYS-NEUTRINO-MAJORANA-003","SFT-PHYS-NEUTRINO-POSITIVE-MASS-003","SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003"] = .ok state363_3 := by
 change (reachesOne sourceDictionary534 534 memoNode5776 "SFT-PHYS-NEUTRINO-MAJORANA-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-NEUTRINO-POSITIVE-MASS-003","SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003"]) = _
 rewrite [rootCall362]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state363_1 ["SFT-PHYS-NEUTRINO-POSITIVE-MASS-003","SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003"] = _
 exact parents363_1
theorem rootCall363 : reachesOne sourceDictionary534 535 memoNode5776 "SFT-PHYS-NEUTRINO-ZERO-NU-BETA-BETA-003" = .ok result363 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state363_0 ["SFT-PHYS-NEUTRINO-MAJORANA-003","SFT-PHYS-NEUTRINO-POSITIVE-MASS-003","SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003"]; pure (result.1,put result.2 "SFT-PHYS-NEUTRINO-ZERO-NU-BETA-BETA-003" result.1)) = _
 rewrite [parents363_0]
 rfl
#print axioms rootCall363
end SFT.Physics.GrandLockRootTrace
