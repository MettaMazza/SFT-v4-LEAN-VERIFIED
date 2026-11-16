import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents117_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state117_3 [] = .ok state117_3 := rfl
theorem parents117_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state117_2 ["SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001"] = .ok state117_3 := rfl
theorem parents117_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state117_1 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001"] = .ok state117_3 := rfl
theorem parents117_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state117_0 ["SFT-PHYS-DYNAMICS-POTENTIAL-EVOLUTION-003","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001"] = .ok state117_3 := by
 change (reachesOne sourceDictionary534 534 memoNode2252 "SFT-PHYS-DYNAMICS-POTENTIAL-EVOLUTION-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001"]) = _
 rewrite [rootCall116]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state117_1 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001"] = _
 exact parents117_1
theorem rootCall117 : reachesOne sourceDictionary534 535 memoNode2252 "SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003" = .ok result117 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state117_0 ["SFT-PHYS-DYNAMICS-POTENTIAL-EVOLUTION-003","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001"]; pure (result.1,put result.2 "SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003" result.1)) = _
 rewrite [parents117_0]
 rfl
#print axioms rootCall117
end SFT.Physics.GrandLockRootTrace
