import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents649_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state649_6 [] = .ok state649_6 := rfl
theorem parents649_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state649_5 ["SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = .ok state649_6 := rfl
theorem parents649_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state649_4 ["SFT-PHYS-QUANTUM-BELL-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = .ok state649_6 := rfl
theorem parents649_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state649_3 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-QUANTUM-BELL-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = .ok state649_6 := rfl
theorem parents649_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state649_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-QUANTUM-BELL-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = .ok state649_6 := rfl
theorem parents649_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state649_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-QUANTUM-BELL-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = .ok state649_6 := rfl
theorem parents649_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state649_0 ["SFT-PHYS-QUANTUM-SUPPORT-UNCERTAINTY-TERMINAL-049","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-QUANTUM-BELL-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = .ok state649_6 := by
 change (reachesOne sourceDictionary534 534 memoNode10497 "SFT-PHYS-QUANTUM-SUPPORT-UNCERTAINTY-TERMINAL-049" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-QUANTUM-BELL-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"]) = _
 rewrite [rootCall648]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state649_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-QUANTUM-BELL-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"] = _
 exact parents649_1
theorem rootCall649 : reachesOne sourceDictionary534 535 memoNode10497 "SFT-PHYS-VALIDATION-QUANTUM-SUPPORT-UNCERTAINTY-050" = .ok result649 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state649_0 ["SFT-PHYS-QUANTUM-SUPPORT-UNCERTAINTY-TERMINAL-049","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-QUANTUM-BELL-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-QUANTUM-SUPPORT-UNCERTAINTY-050" result.1)) = _
 rewrite [parents649_0]
 rfl
#print axioms rootCall649
end SFT.Physics.GrandLockRootTrace
