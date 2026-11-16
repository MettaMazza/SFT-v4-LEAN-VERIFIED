import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents268_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state268_5 [] = .ok state268_5 := rfl
theorem parents268_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state268_4 ["SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = .ok state268_5 := rfl
theorem parents268_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state268_3 ["SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = .ok state268_5 := rfl
theorem parents268_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state268_2 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = .ok state268_5 := rfl
theorem parents268_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state268_1 ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = .ok state268_5 := rfl
theorem parents268_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state268_0 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = .ok state268_5 := by
 change (reachesOne sourceDictionary534 534 memoNode4616 "SFT-PHYS-MECH-CONSERVATION-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"]) = _
 rewrite [rootCall267]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state268_1 ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = _
 exact parents268_1
theorem rootCall268 : reachesOne sourceDictionary534 535 memoNode4616 "SFT-PHYS-MATTER-MASS-ENERGY-001" = .ok result268 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state268_0 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-MASS-ENERGY-001" result.1)) = _
 rewrite [parents268_0]
 rfl
#print axioms rootCall268
end SFT.Physics.GrandLockRootTrace
