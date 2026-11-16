import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents250_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state250_3 [] = .ok state250_3 := rfl
theorem parents250_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state250_2 ["SFT-MATH-COMBINATORICS-001"] = .ok state250_3 := rfl
theorem parents250_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state250_1 ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-MATH-COMBINATORICS-001"] = .ok state250_3 := rfl
theorem parents250_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state250_0 ["SFT-PHYS-MATTER-QUARK-INVARIANTS-003","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-MATH-COMBINATORICS-001"] = .ok state250_3 := by
 change (reachesOne sourceDictionary534 534 memoNode4375 "SFT-PHYS-MATTER-QUARK-INVARIANTS-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [rootCall249]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state250_1 ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-MATH-COMBINATORICS-001"] = _
 exact parents250_1
theorem rootCall250 : reachesOne sourceDictionary534 535 memoNode4375 "SFT-PHYS-MATTER-CKM-FIBRE-003" = .ok result250 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state250_0 ["SFT-PHYS-MATTER-QUARK-INVARIANTS-003","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-MATH-COMBINATORICS-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-CKM-FIBRE-003" result.1)) = _
 rewrite [parents250_0]
 rfl
#print axioms rootCall250
end SFT.Physics.GrandLockRootTrace
