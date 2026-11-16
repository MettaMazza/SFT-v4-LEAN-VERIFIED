import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents87_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state87_6 [] = .ok state87_6 := rfl
theorem parents87_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state87_5 ["SFT-PHYS-COSMO-DISTANCE-001"] = .ok state87_6 := rfl
theorem parents87_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state87_4 ["SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-DISTANCE-001"] = .ok state87_6 := rfl
theorem parents87_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state87_3 ["SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-DISTANCE-001"] = .ok state87_6 := rfl
theorem parents87_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state87_2 ["SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-DISTANCE-001"] = .ok state87_6 := rfl
theorem parents87_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state87_1 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-DISTANCE-001"] = .ok state87_6 := rfl
theorem parents87_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state87_0 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-DISTANCE-001"] = .ok state87_6 := by
 change (reachesOne sourceDictionary534 534 memoNode1541 "SFT-PHYS-SPACETIME-CAUSAL-ORDER-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-DISTANCE-001"]) = _
 rewrite [rootCall86]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state87_1 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-DISTANCE-001"] = _
 exact parents87_1
theorem rootCall87 : reachesOne sourceDictionary534 535 memoNode1541 "SFT-PHYS-COSMO-STRUCTURE-GROWTH-001" = .ok result87 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state87_0 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-DISTANCE-001"]; pure (result.1,put result.2 "SFT-PHYS-COSMO-STRUCTURE-GROWTH-001" result.1)) = _
 rewrite [parents87_0]
 rfl
#print axioms rootCall87
end SFT.Physics.GrandLockRootTrace
