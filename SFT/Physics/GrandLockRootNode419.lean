import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents419_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state419_6 [] = .ok state419_6 := rfl
theorem parents419_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state419_5 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state419_6 := rfl
theorem parents419_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state419_4 ["SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state419_6 := rfl
theorem parents419_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state419_3 ["SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state419_6 := rfl
theorem parents419_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state419_2 ["SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001","SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state419_6 := rfl
theorem parents419_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state419_1 ["SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001","SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state419_6 := rfl
theorem parents419_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state419_0 ["SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001","SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state419_6 := by
 change (reachesOne sourceDictionary534 534 memoNode6648 "SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001","SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall418]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state419_1 ["SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001","SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents419_1
theorem rootCall419 : reachesOne sourceDictionary534 535 memoNode6648 "SFT-PHYS-QED-MUON-MAGNETIC-ANOMALY-004" = .ok result419 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state419_0 ["SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001","SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-QED-MUON-MAGNETIC-ANOMALY-004" result.1)) = _
 rewrite [parents419_0]
 rfl
#print axioms rootCall419
end SFT.Physics.GrandLockRootTrace
