import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents279_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state279_6 [] = .ok state279_6 := rfl
theorem parents279_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state279_5 ["SFT-PHYS-MATTER-CONSERVED-LABELS-001"] = .ok state279_6 := rfl
theorem parents279_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state279_4 ["SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001"] = .ok state279_6 := rfl
theorem parents279_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state279_3 ["SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001"] = .ok state279_6 := rfl
theorem parents279_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state279_2 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001"] = .ok state279_6 := rfl
theorem parents279_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state279_1 ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001"] = .ok state279_6 := rfl
theorem parents279_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state279_0 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001"] = .ok state279_6 := by
 change (reachesOne sourceDictionary534 534 memoNode4758 "SFT-PHYS-MECH-CONSERVATION-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001"]) = _
 rewrite [rootCall278]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state279_1 ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001"] = _
 exact parents279_1
theorem rootCall279 : reachesOne sourceDictionary534 535 memoNode4758 "SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001" = .ok result279 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state279_0 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001" result.1)) = _
 rewrite [parents279_0]
 rfl
#print axioms rootCall279
end SFT.Physics.GrandLockRootTrace
