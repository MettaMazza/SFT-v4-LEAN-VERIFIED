import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents266_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state266_3 [] = .ok state266_3 := rfl
theorem parents266_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state266_2 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"] = .ok state266_3 := rfl
theorem parents266_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state266_1 ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"] = .ok state266_3 := rfl
theorem parents266_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state266_0 ["SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"] = .ok state266_3 := by
 change (reachesOne sourceDictionary534 534 memoNode4583 "SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"]) = _
 rewrite [rootCall265]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state266_1 ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"] = _
 exact parents266_1
theorem rootCall266 : reachesOne sourceDictionary534 535 memoNode4583 "SFT-PHYS-MATTER-INTER-ENTRY-COUPLING-003" = .ok result266 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state266_0 ["SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-INTER-ENTRY-COUPLING-003" result.1)) = _
 rewrite [parents266_0]
 rfl
#print axioms rootCall266
end SFT.Physics.GrandLockRootTrace
