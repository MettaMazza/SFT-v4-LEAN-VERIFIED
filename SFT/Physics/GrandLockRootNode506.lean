import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents506_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state506_3 [] = .ok state506_3 := rfl
theorem parents506_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state506_2 ["SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001"] = .ok state506_3 := rfl
theorem parents506_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state506_1 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001"] = .ok state506_3 := rfl
theorem parents506_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state506_0 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001"] = .ok state506_3 := by
 change (reachesOne sourceDictionary534 533 memoNode7955 "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001"]) = _
 rewrite [rootCall505]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state506_1 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001"] = _
 exact parents506_1
theorem rootCall506 : reachesOne sourceDictionary534 534 memoNode7955 "SFT-PHYS-WEAK-PARITY-FIBRE-002" = .ok result506 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state506_0 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001"]; pure (result.1,put result.2 "SFT-PHYS-WEAK-PARITY-FIBRE-002" result.1)) = _
 rewrite [parents506_0]
 rfl
#print axioms rootCall506
end SFT.Physics.GrandLockRootTrace
