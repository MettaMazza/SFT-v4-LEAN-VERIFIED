import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode415
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents416_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state416_7 [] = .ok state416_7 := rfl
theorem parents416_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state416_6 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state416_7 := rfl
theorem parents416_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state416_5 ["SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state416_7 := rfl
theorem parents416_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state416_4 ["SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state416_7 := rfl
theorem parents416_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state416_3 ["SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state416_7 := rfl
theorem parents416_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state416_2 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state416_7 := rfl
theorem parents416_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state416_1 ["SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state416_7 := rfl
theorem parents416_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state416_0 ["SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state416_7 := by
 change (reachesOne sourceDictionary534 534 memoNode6577 "SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall415]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state416_1 ["SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents416_1
theorem rootCall416 : reachesOne sourceDictionary534 535 memoNode6577 "SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004" = .ok result416 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state416_0 ["SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004" result.1)) = _
 rewrite [parents416_0]
 rfl
#print axioms rootCall416
end SFT.Physics.GrandLockRootTrace
