import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents256_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state256_3 [] = .ok state256_3 := rfl
theorem parents256_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state256_2 ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001"] = .ok state256_3 := rfl
theorem parents256_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state256_1 ["SFT-PHYS-MATTER-QUARK-INVARIANTS-003","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001"] = .ok state256_3 := rfl
theorem parents256_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state256_0 ["SFT-PHYS-MATTER-QUARK-CUBICS-003","SFT-PHYS-MATTER-QUARK-INVARIANTS-003","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001"] = .ok state256_3 := by
 change (reachesOne sourceDictionary534 534 memoNode4428 "SFT-PHYS-MATTER-QUARK-CUBICS-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MATTER-QUARK-INVARIANTS-003","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001"]) = _
 rewrite [rootCall255]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state256_1 ["SFT-PHYS-MATTER-QUARK-INVARIANTS-003","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001"] = _
 exact parents256_1
theorem rootCall256 : reachesOne sourceDictionary534 535 memoNode4428 "SFT-PHYS-MATTER-CONFINEMENT-LIFT-003" = .ok result256 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state256_0 ["SFT-PHYS-MATTER-QUARK-CUBICS-003","SFT-PHYS-MATTER-QUARK-INVARIANTS-003","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-CONFINEMENT-LIFT-003" result.1)) = _
 rewrite [parents256_0]
 rfl
#print axioms rootCall256
end SFT.Physics.GrandLockRootTrace
