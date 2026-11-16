import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents75_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state75_6 [] = .ok state75_6 := rfl
theorem parents75_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state75_5 ["SFT-PHYS-COSMO-LENSING-001"] = .ok state75_6 := rfl
theorem parents75_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state75_4 ["SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-LENSING-001"] = .ok state75_6 := rfl
theorem parents75_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state75_3 ["SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-LENSING-001"] = .ok state75_6 := rfl
theorem parents75_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state75_2 ["SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-LENSING-001"] = .ok state75_6 := rfl
theorem parents75_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state75_1 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-LENSING-001"] = .ok state75_6 := rfl
theorem parents75_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state75_0 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-LENSING-001"] = .ok state75_6 := by
 change (reachesOne sourceDictionary534 534 memoNode1396 "SFT-PHYS-SPACETIME-CAUSAL-ORDER-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-LENSING-001"]) = _
 rewrite [rootCall74]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state75_1 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-LENSING-001"] = _
 exact parents75_1
theorem rootCall75 : reachesOne sourceDictionary534 535 memoNode1396 "SFT-PHYS-COSMO-DISTANCE-001" = .ok result75 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state75_0 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-LENSING-001"]; pure (result.1,put result.2 "SFT-PHYS-COSMO-DISTANCE-001" result.1)) = _
 rewrite [parents75_0]
 rfl
#print axioms rootCall75
end SFT.Physics.GrandLockRootTrace
