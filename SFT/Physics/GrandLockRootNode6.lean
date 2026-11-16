import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents6_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state6_4 [] = .ok state6_4 := rfl
theorem parents6_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state6_3 ["SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"] = .ok state6_4 := rfl
theorem parents6_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state6_2 ["SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"] = .ok state6_4 := rfl
theorem parents6_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state6_1 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"] = .ok state6_4 := rfl
theorem parents6_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state6_0 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"] = .ok state6_4 := by
 change (reachesOne sourceDictionary534 534 memoNode91 "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"]) = _
 rewrite [rootCall5]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state6_1 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"] = _
 exact parents6_1
theorem rootCall6 : reachesOne sourceDictionary534 535 memoNode91 "SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004" = .ok result6 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state6_0 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"]; pure (result.1,put result.2 "SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004" result.1)) = _
 rewrite [parents6_0]
 rfl
#print axioms rootCall6
end SFT.Physics.GrandLockRootTrace
