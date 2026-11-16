import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode209
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents210_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state210_3 [] = .ok state210_3 := rfl
theorem parents210_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state210_2 ["SFT-PHYS-MATTER-MASS-ENERGY-001"] = .ok state210_3 := rfl
theorem parents210_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state210_1 ["SFT-PHYS-GRAVITY-FIELD-SOURCE-001","SFT-PHYS-MATTER-MASS-ENERGY-001"] = .ok state210_3 := rfl
theorem parents210_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state210_0 ["SFT-PHYS-GRAVITY-LATTICE-CURVATURE-003","SFT-PHYS-GRAVITY-FIELD-SOURCE-001","SFT-PHYS-MATTER-MASS-ENERGY-001"] = .ok state210_3 := by
 change (reachesOne sourceDictionary534 533 memoNode3595 "SFT-PHYS-GRAVITY-LATTICE-CURVATURE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-GRAVITY-FIELD-SOURCE-001","SFT-PHYS-MATTER-MASS-ENERGY-001"]) = _
 rewrite [rootCall209]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state210_1 ["SFT-PHYS-GRAVITY-FIELD-SOURCE-001","SFT-PHYS-MATTER-MASS-ENERGY-001"] = _
 exact parents210_1
theorem rootCall210 : reachesOne sourceDictionary534 534 memoNode3595 "SFT-PHYS-GRAVITY-NONLINEAR-SELF-SOURCE-003" = .ok result210 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state210_0 ["SFT-PHYS-GRAVITY-LATTICE-CURVATURE-003","SFT-PHYS-GRAVITY-FIELD-SOURCE-001","SFT-PHYS-MATTER-MASS-ENERGY-001"]; pure (result.1,put result.2 "SFT-PHYS-GRAVITY-NONLINEAR-SELF-SOURCE-003" result.1)) = _
 rewrite [parents210_0]
 rfl
#print axioms rootCall210
end SFT.Physics.GrandLockRootTrace
