import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents27_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state27_6 [] = .ok state27_6 := rfl
theorem parents27_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state27_5 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state27_6 := rfl
theorem parents27_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state27_4 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state27_6 := rfl
theorem parents27_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state27_3 ["SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state27_6 := rfl
theorem parents27_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state27_2 ["SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state27_6 := rfl
theorem parents27_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state27_1 ["SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state27_6 := rfl
theorem parents27_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state27_0 ["SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state27_6 := by
 change (reachesOne sourceDictionary534 534 memoNode567 "SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall26]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state27_1 ["SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents27_1
theorem rootCall27 : reachesOne sourceDictionary534 535 memoNode567 "SFT-PHYS-ATOMIC-LAMB-SHIFT-TERMINAL-005" = .ok result27 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state27_0 ["SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-ATOMIC-LAMB-SHIFT-TERMINAL-005" result.1)) = _
 rewrite [parents27_0]
 rfl
#print axioms rootCall27
end SFT.Physics.GrandLockRootTrace
