import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents83_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state83_5 [] = .ok state83_5 := rfl
theorem parents83_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state83_4 ["SFT-PHYS-GRAVITY-HORIZON-001"] = .ok state83_5 := rfl
theorem parents83_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state83_3 ["SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001"] = .ok state83_5 := rfl
theorem parents83_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state83_2 ["SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001"] = .ok state83_5 := rfl
theorem parents83_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state83_1 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001"] = .ok state83_5 := rfl
theorem parents83_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state83_0 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001"] = .ok state83_5 := by
 change (reachesOne sourceDictionary534 534 memoNode1489 "SFT-PHYS-SPACETIME-CAUSAL-ORDER-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001"]) = _
 rewrite [rootCall82]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state83_1 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001"] = _
 exact parents83_1
theorem rootCall83 : reachesOne sourceDictionary534 535 memoNode1489 "SFT-PHYS-COSMO-REDSHIFT-001" = .ok result83 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state83_0 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001"]; pure (result.1,put result.2 "SFT-PHYS-COSMO-REDSHIFT-001" result.1)) = _
 rewrite [parents83_0]
 rfl
#print axioms rootCall83
end SFT.Physics.GrandLockRootTrace
