import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents351_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state351_3 [] = .ok state351_3 := rfl
theorem parents351_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state351_2 ["SFT-PHYS-QUANTUM-OBSERVABLE-001"] = .ok state351_3 := rfl
theorem parents351_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state351_1 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-OBSERVABLE-001"] = .ok state351_3 := rfl
theorem parents351_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state351_0 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-OBSERVABLE-001"] = .ok state351_3 := by
 change (reachesOne sourceDictionary534 534 memoNode5618 "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-OBSERVABLE-001"]) = _
 rewrite [rootCall350]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state351_1 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-OBSERVABLE-001"] = _
 exact parents351_1
theorem rootCall351 : reachesOne sourceDictionary534 535 memoNode5618 "SFT-PHYS-NEUTRINO-CP-PHASE-002" = .ok result351 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state351_0 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-OBSERVABLE-001"]; pure (result.1,put result.2 "SFT-PHYS-NEUTRINO-CP-PHASE-002" result.1)) = _
 rewrite [parents351_0]
 rfl
#print axioms rootCall351
end SFT.Physics.GrandLockRootTrace
