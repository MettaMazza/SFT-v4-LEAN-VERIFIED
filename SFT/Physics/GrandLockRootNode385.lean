import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents385_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state385_6 [] = .ok state385_6 := rfl
theorem parents385_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state385_5 ["SFT-PHYS-NUCLEAR-LEVELS-001"] = .ok state385_6 := rfl
theorem parents385_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state385_4 ["SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-NUCLEAR-LEVELS-001"] = .ok state385_6 := rfl
theorem parents385_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state385_3 ["SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-NUCLEAR-LEVELS-001"] = .ok state385_6 := rfl
theorem parents385_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state385_2 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-NUCLEAR-LEVELS-001"] = .ok state385_6 := rfl
theorem parents385_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state385_1 ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-NUCLEAR-LEVELS-001"] = .ok state385_6 := rfl
theorem parents385_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state385_0 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-NUCLEAR-LEVELS-001"] = .ok state385_6 := by
 change (reachesOne sourceDictionary534 533 memoNode6090 "SFT-PHYS-MECH-CONSERVATION-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-NUCLEAR-LEVELS-001"]) = _
 rewrite [rootCall384]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state385_1 ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-NUCLEAR-LEVELS-001"] = _
 exact parents385_1
theorem rootCall385 : reachesOne sourceDictionary534 534 memoNode6090 "SFT-PHYS-NUCLEAR-RADIOACTIVITY-001" = .ok result385 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state385_0 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-NUCLEAR-LEVELS-001"]; pure (result.1,put result.2 "SFT-PHYS-NUCLEAR-RADIOACTIVITY-001" result.1)) = _
 rewrite [parents385_0]
 rfl
#print axioms rootCall385
end SFT.Physics.GrandLockRootTrace
