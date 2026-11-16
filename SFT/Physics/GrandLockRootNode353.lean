import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents353_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state353_3 [] = .ok state353_3 := rfl
theorem parents353_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state353_2 ["SFT-MATH-ORBIT-NUMBER-THEORY-002"] = .ok state353_3 := rfl
theorem parents353_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state353_1 ["SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-MATH-ORBIT-NUMBER-THEORY-002"] = .ok state353_3 := rfl
theorem parents353_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state353_0 ["SFT-PHYS-MATTER-QUARK-INVARIANTS-003","SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-MATH-ORBIT-NUMBER-THEORY-002"] = .ok state353_3 := by
 change (reachesOne sourceDictionary534 531 memoNode5643 "SFT-PHYS-MATTER-QUARK-INVARIANTS-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) next ["SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-MATH-ORBIT-NUMBER-THEORY-002"]) = _
 rewrite [rootCall352]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state353_1 ["SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-MATH-ORBIT-NUMBER-THEORY-002"] = _
 exact parents353_1
theorem rootCall353 : reachesOne sourceDictionary534 532 memoNode5643 "SFT-PHYS-NEUTRINO-SPLITTING-003" = .ok result353 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state353_0 ["SFT-PHYS-MATTER-QUARK-INVARIANTS-003","SFT-PHYS-NEUTRINO-PMNS-ANGLES-002","SFT-MATH-ORBIT-NUMBER-THEORY-002"]; pure (result.1,put result.2 "SFT-PHYS-NEUTRINO-SPLITTING-003" result.1)) = _
 rewrite [parents353_0]
 rfl
#print axioms rootCall353
end SFT.Physics.GrandLockRootTrace
