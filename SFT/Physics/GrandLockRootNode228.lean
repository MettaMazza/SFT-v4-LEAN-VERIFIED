import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents228_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state228_6 [] = .ok state228_6 := rfl
theorem parents228_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state228_5 ["SFT-MATH-COMBINATORICS-001"] = .ok state228_6 := rfl
theorem parents228_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state228_4 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state228_6 := rfl
theorem parents228_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state228_3 ["SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state228_6 := rfl
theorem parents228_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state228_2 ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state228_6 := rfl
theorem parents228_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state228_1 ["SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state228_6 := rfl
theorem parents228_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state228_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok state228_6 := by
 change (reachesOne sourceDictionary534 533 memoNode3967 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [rootCall227]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state228_1 ["SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact parents228_1
theorem rootCall228 : reachesOne sourceDictionary534 534 memoNode3967 "SFT-PHYS-HADRON-REGGE-TERMINAL-005" = .ok result228 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state228_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]; pure (result.1,put result.2 "SFT-PHYS-HADRON-REGGE-TERMINAL-005" result.1)) = _
 rewrite [parents228_0]
 rfl
#print axioms rootCall228
end SFT.Physics.GrandLockRootTrace
