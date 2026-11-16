import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents272_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state272_3 [] = .ok state272_3 := rfl
theorem parents272_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state272_2 ["SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"] = .ok state272_3 := rfl
theorem parents272_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state272_1 ["SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"] = .ok state272_3 := rfl
theorem parents272_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state272_0 ["SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"] = .ok state272_3 := by
 change (reachesOne sourceDictionary534 534 memoNode4673 "SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"]) = _
 rewrite [rootCall271]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state272_1 ["SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"] = _
 exact parents272_1
theorem rootCall272 : reachesOne sourceDictionary534 535 memoNode4673 "SFT-PHYS-MATTER-MIRROR-MASS-CLOSURE-003" = .ok result272 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state272_0 ["SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-MIRROR-MASS-CLOSURE-003" result.1)) = _
 rewrite [parents272_0]
 rfl
#print axioms rootCall272
end SFT.Physics.GrandLockRootTrace
