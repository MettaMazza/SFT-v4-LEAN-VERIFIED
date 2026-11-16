import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents466_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state466_4 [] = .ok state466_4 := rfl
theorem parents466_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state466_3 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state466_4 := rfl
theorem parents466_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state466_2 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state466_4 := rfl
theorem parents466_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state466_1 ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state466_4 := rfl
theorem parents466_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state466_0 ["SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state466_4 := by
 change (reachesOne sourceDictionary534 534 memoNode7292 "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall465]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state466_1 ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents466_1
theorem rootCall466 : reachesOne sourceDictionary534 535 memoNode7292 "SFT-PHYS-SCALE-PROTON-PLANCK-TERMINAL-003" = .ok result466 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state466_0 ["SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-SCALE-PROTON-PLANCK-TERMINAL-003" result.1)) = _
 rewrite [parents466_0]
 rfl
#print axioms rootCall466
end SFT.Physics.GrandLockRootTrace
