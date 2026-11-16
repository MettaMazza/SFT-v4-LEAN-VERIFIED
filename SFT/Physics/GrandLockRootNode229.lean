import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode228
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents229_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state229_6 [] = .ok state229_6 := rfl
theorem parents229_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state229_5 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok state229_6 := rfl
theorem parents229_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state229_4 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok state229_6 := rfl
theorem parents229_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state229_3 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok state229_6 := rfl
theorem parents229_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state229_2 ["SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok state229_6 := rfl
theorem parents229_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state229_1 ["SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok state229_6 := rfl
theorem parents229_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state229_0 ["SFT-PHYS-HADRON-REGGE-TERMINAL-005","SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok state229_6 := by
 change (reachesOne sourceDictionary534 534 memoNode3967 "SFT-PHYS-HADRON-REGGE-TERMINAL-005" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]) = _
 rewrite [rootCall228]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state229_1 ["SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = _
 exact parents229_1
theorem rootCall229 : reachesOne sourceDictionary534 535 memoNode3967 "SFT-PHYS-HADRON-REGGE-DIMENSIONAL-TERMINAL-059" = .ok result229 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state229_0 ["SFT-PHYS-HADRON-REGGE-TERMINAL-005","SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]; pure (result.1,put result.2 "SFT-PHYS-HADRON-REGGE-DIMENSIONAL-TERMINAL-059" result.1)) = _
 rewrite [parents229_0]
 rfl
#print axioms rootCall229
end SFT.Physics.GrandLockRootTrace
