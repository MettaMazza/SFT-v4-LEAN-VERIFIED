import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents710_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state710_6 [] = .ok state710_6 := rfl
theorem parents710_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state710_5 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state710_6 := rfl
theorem parents710_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state710_4 ["SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state710_6 := rfl
theorem parents710_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state710_3 ["SFT-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014","SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state710_6 := rfl
theorem parents710_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state710_2 ["SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013","SFT-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014","SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state710_6 := rfl
theorem parents710_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state710_1 ["SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003","SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013","SFT-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014","SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state710_6 := rfl
theorem parents710_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state710_0 ["SFT-FOUNDATION-FOLD-DYNAMICS-001","SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003","SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013","SFT-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014","SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state710_6 := by
 change (reachesOne sourceDictionary534 533 memoNode11468 "SFT-FOUNDATION-FOLD-DYNAMICS-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003","SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013","SFT-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014","SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall709]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state710_1 ["SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003","SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013","SFT-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014","SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents710_1
theorem rootCall710 : reachesOne sourceDictionary534 534 memoNode11468 "SFT-PHYS-YANG-MILLS-SINGLET-GAP-TERMINAL-026" = .ok result710 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state710_0 ["SFT-FOUNDATION-FOLD-DYNAMICS-001","SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003","SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013","SFT-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014","SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-YANG-MILLS-SINGLET-GAP-TERMINAL-026" result.1)) = _
 rewrite [parents710_0]
 rfl
#print axioms rootCall710
end SFT.Physics.GrandLockRootTrace
