import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents81_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state81_6 [] = .ok state81_6 := rfl
theorem parents81_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state81_5 ["SFT-PHYS-COSMO-BACKGROUND-001"] = .ok state81_6 := rfl
theorem parents81_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state81_4 ["SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-BACKGROUND-001"] = .ok state81_6 := rfl
theorem parents81_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state81_3 ["SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-BACKGROUND-001"] = .ok state81_6 := rfl
theorem parents81_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state81_2 ["SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-BACKGROUND-001"] = .ok state81_6 := rfl
theorem parents81_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state81_1 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-BACKGROUND-001"] = .ok state81_6 := rfl
theorem parents81_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state81_0 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-BACKGROUND-001"] = .ok state81_6 := by
 change (reachesOne sourceDictionary534 534 memoNode1467 "SFT-PHYS-SPACETIME-CAUSAL-ORDER-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-BACKGROUND-001"]) = _
 rewrite [rootCall80]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state81_1 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-BACKGROUND-001"] = _
 exact parents81_1
theorem rootCall81 : reachesOne sourceDictionary534 535 memoNode1467 "SFT-PHYS-COSMO-LENSING-001" = .ok result81 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state81_0 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-BACKGROUND-001"]; pure (result.1,put result.2 "SFT-PHYS-COSMO-LENSING-001" result.1)) = _
 rewrite [parents81_0]
 rfl
#print axioms rootCall81
end SFT.Physics.GrandLockRootTrace
