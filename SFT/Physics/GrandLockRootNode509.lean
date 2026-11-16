import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents509_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state509_4 [] = .ok state509_4 := rfl
theorem parents509_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state509_3 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state509_4 := rfl
theorem parents509_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state509_2 ["SFT-PHYS-FIELD-SOURCE-RESPONSE-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state509_4 := rfl
theorem parents509_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state509_1 ["SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state509_4 := rfl
theorem parents509_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state509_0 ["SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state509_4 := by
 change (reachesOne sourceDictionary534 533 memoNode8027 "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [rootCall508]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state509_1 ["SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact parents509_1
theorem rootCall509 : reachesOne sourceDictionary534 534 memoNode8027 "SFT-PHYS-STRONG-RUNNING-DIRECTION-002" = .ok result509 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state509_0 ["SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]; pure (result.1,put result.2 "SFT-PHYS-STRONG-RUNNING-DIRECTION-002" result.1)) = _
 rewrite [parents509_0]
 rfl
#print axioms rootCall509
end SFT.Physics.GrandLockRootTrace
