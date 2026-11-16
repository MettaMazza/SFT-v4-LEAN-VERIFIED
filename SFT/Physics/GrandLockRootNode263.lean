import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents263_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state263_3 [] = .ok state263_3 := rfl
theorem parents263_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state263_2 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"] = .ok state263_3 := rfl
theorem parents263_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state263_1 ["SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"] = .ok state263_3 := rfl
theorem parents263_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state263_0 ["SFT-PHYS-MATTER-CKM-FIBRE-003","SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"] = .ok state263_3 := by
 change (reachesOne sourceDictionary534 533 memoNode4518 "SFT-PHYS-MATTER-CKM-FIBRE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"]) = _
 rewrite [rootCall262]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state263_1 ["SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"] = _
 exact parents263_1
theorem rootCall263 : reachesOne sourceDictionary534 534 memoNode4518 "SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003" = .ok result263 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state263_0 ["SFT-PHYS-MATTER-CKM-FIBRE-003","SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003" result.1)) = _
 rewrite [parents263_0]
 rfl
#print axioms rootCall263
end SFT.Physics.GrandLockRootTrace
