import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents371_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state371_6 [] = .ok state371_6 := rfl
theorem parents371_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state371_5 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state371_6 := rfl
theorem parents371_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state371_4 ["SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state371_6 := rfl
theorem parents371_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state371_3 ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state371_6 := rfl
theorem parents371_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state371_2 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state371_6 := rfl
theorem parents371_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state371_1 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state371_6 := rfl
theorem parents371_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state371_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state371_6 := by
 change (reachesOne sourceDictionary534 534 memoNode5889 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall370]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state371_1 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents371_1
theorem rootCall371 : reachesOne sourceDictionary534 535 memoNode5889 "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001" = .ok result371 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state371_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001" result.1)) = _
 rewrite [parents371_0]
 rfl
#print axioms rootCall371
end SFT.Physics.GrandLockRootTrace
