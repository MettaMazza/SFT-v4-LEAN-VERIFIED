import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents67_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state67_6 [] = .ok state67_6 := rfl
theorem parents67_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state67_5 ["SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = .ok state67_6 := rfl
theorem parents67_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state67_4 ["SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = .ok state67_6 := rfl
theorem parents67_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state67_3 ["SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = .ok state67_6 := rfl
theorem parents67_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state67_2 ["SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = .ok state67_6 := rfl
theorem parents67_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state67_1 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = .ok state67_6 := rfl
theorem parents67_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state67_0 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = .ok state67_6 := by
 change (reachesOne sourceDictionary534 534 memoNode1265 "SFT-PHYS-SPACETIME-CAUSAL-ORDER-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"]) = _
 rewrite [rootCall66]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state67_1 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = _
 exact parents67_1
theorem rootCall67 : reachesOne sourceDictionary534 535 memoNode1265 "SFT-PHYS-COSMO-BRANCH-BOUNDARY-001" = .ok result67 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state67_0 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"]; pure (result.1,put result.2 "SFT-PHYS-COSMO-BRANCH-BOUNDARY-001" result.1)) = _
 rewrite [parents67_0]
 rfl
#print axioms rootCall67
end SFT.Physics.GrandLockRootTrace
