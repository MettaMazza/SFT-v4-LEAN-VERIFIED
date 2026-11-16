import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents415_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state415_3 [] = .ok state415_3 := rfl
theorem parents415_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state415_2 ["SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"] = .ok state415_3 := rfl
theorem parents415_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state415_1 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"] = .ok state415_3 := rfl
theorem parents415_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state415_0 ["SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"] = .ok state415_3 := by
 change (reachesOne sourceDictionary534 533 memoNode6577 "SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"]) = _
 rewrite [rootCall414]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state415_1 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"] = _
 exact parents415_1
theorem rootCall415 : reachesOne sourceDictionary534 534 memoNode6577 "SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003" = .ok result415 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state415_0 ["SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"]; pure (result.1,put result.2 "SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003" result.1)) = _
 rewrite [parents415_0]
 rfl
#print axioms rootCall415
end SFT.Physics.GrandLockRootTrace
