import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents254_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state254_6 [] = .ok state254_6 := rfl
theorem parents254_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state254_5 ["SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001"] = .ok state254_6 := rfl
theorem parents254_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state254_4 ["SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001"] = .ok state254_6 := rfl
theorem parents254_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state254_3 ["SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001"] = .ok state254_6 := rfl
theorem parents254_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state254_2 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001"] = .ok state254_6 := rfl
theorem parents254_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state254_1 ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001"] = .ok state254_6 := rfl
theorem parents254_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state254_0 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001"] = .ok state254_6 := by
 change (reachesOne sourceDictionary534 534 memoNode4398 "SFT-PHYS-MECH-CONSERVATION-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001"]) = _
 rewrite [rootCall253]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state254_1 ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001"] = _
 exact parents254_1
theorem rootCall254 : reachesOne sourceDictionary534 535 memoNode4398 "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001" = .ok result254 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state254_0 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001" result.1)) = _
 rewrite [parents254_0]
 rfl
#print axioms rootCall254
end SFT.Physics.GrandLockRootTrace
