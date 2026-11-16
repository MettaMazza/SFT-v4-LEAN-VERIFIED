import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode136
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents137_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state137_3 [] = .ok state137_3 := rfl
theorem parents137_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state137_2 ["SFT-PHYS-FIELD-INVERSE-SQUARE-001"] = .ok state137_3 := rfl
theorem parents137_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state137_1 ["SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001"] = .ok state137_3 := rfl
theorem parents137_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state137_0 ["SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001"] = .ok state137_3 := by
 change (reachesOne sourceDictionary534 534 memoNode2560 "SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001"]) = _
 rewrite [rootCall136]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state137_1 ["SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001"] = _
 exact parents137_1
theorem rootCall137 : reachesOne sourceDictionary534 535 memoNode2560 "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003" = .ok result137 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state137_0 ["SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001"]; pure (result.1,put result.2 "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003" result.1)) = _
 rewrite [parents137_0]
 rfl
#print axioms rootCall137
end SFT.Physics.GrandLockRootTrace
