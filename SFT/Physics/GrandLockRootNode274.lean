import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents274_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state274_6 [] = .ok state274_6 := rfl
theorem parents274_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state274_5 ["SFT-PHYS-MATTER-DECAY-001"] = .ok state274_6 := rfl
theorem parents274_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state274_4 ["SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-DECAY-001"] = .ok state274_6 := rfl
theorem parents274_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state274_3 ["SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-DECAY-001"] = .ok state274_6 := rfl
theorem parents274_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state274_2 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-DECAY-001"] = .ok state274_6 := rfl
theorem parents274_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state274_1 ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-DECAY-001"] = .ok state274_6 := rfl
theorem parents274_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state274_0 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-DECAY-001"] = .ok state274_6 := by
 change (reachesOne sourceDictionary534 534 memoNode4698 "SFT-PHYS-MECH-CONSERVATION-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-DECAY-001"]) = _
 rewrite [rootCall273]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state274_1 ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-DECAY-001"] = _
 exact parents274_1
theorem rootCall274 : reachesOne sourceDictionary534 535 memoNode4698 "SFT-PHYS-MATTER-MIXING-001" = .ok result274 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state274_0 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-DECAY-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-MIXING-001" result.1)) = _
 rewrite [parents274_0]
 rfl
#print axioms rootCall274
end SFT.Physics.GrandLockRootTrace
