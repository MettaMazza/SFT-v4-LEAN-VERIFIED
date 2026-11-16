import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents106_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state106_6 [] = .ok state106_6 := rfl
theorem parents106_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state106_5 ["SFT-MATH-COMBINATORICS-001"] = .ok state106_6 := rfl
theorem parents106_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state106_4 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state106_6 := rfl
theorem parents106_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state106_3 ["SFT-PHYS-MATTER-MIXING-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state106_6 := rfl
theorem parents106_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state106_2 ["SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-MATTER-MIXING-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state106_6 := rfl
theorem parents106_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state106_1 ["SFT-PHYS-STRONG-RUNNING-DIRECTION-002","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-MATTER-MIXING-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state106_6 := rfl
theorem parents106_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state106_0 ["SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002","SFT-PHYS-STRONG-RUNNING-DIRECTION-002","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-MATTER-MIXING-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state106_6 := by
 change (reachesOne sourceDictionary534 533 memoNode2024 "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-STRONG-RUNNING-DIRECTION-002","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-MATTER-MIXING-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [rootCall105]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state106_1 ["SFT-PHYS-STRONG-RUNNING-DIRECTION-002","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-MATTER-MIXING-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact parents106_1
theorem rootCall106 : reachesOne sourceDictionary534 534 memoNode2024 "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003" = .ok result106 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state106_0 ["SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002","SFT-PHYS-STRONG-RUNNING-DIRECTION-002","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-MATTER-MIXING-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]; pure (result.1,put result.2 "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003" result.1)) = _
 rewrite [parents106_0]
 rfl
#print axioms rootCall106
end SFT.Physics.GrandLockRootTrace
