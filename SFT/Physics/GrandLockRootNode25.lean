import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode24
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents25_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state25_7 [] = .ok state25_7 := rfl
theorem parents25_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state25_6 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state25_7 := rfl
theorem parents25_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state25_5 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state25_7 := rfl
theorem parents25_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state25_4 ["SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state25_7 := rfl
theorem parents25_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state25_3 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state25_7 := rfl
theorem parents25_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state25_2 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state25_7 := rfl
theorem parents25_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state25_1 ["SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state25_7 := rfl
theorem parents25_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state25_0 ["SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state25_7 := by
 change (reachesOne sourceDictionary534 534 memoNode430 "SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall24]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state25_1 ["SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents25_1
theorem rootCall25 : reachesOne sourceDictionary534 535 memoNode430 "SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005" = .ok result25 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state25_0 ["SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004","SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005" result.1)) = _
 rewrite [parents25_0]
 rfl
#print axioms rootCall25
end SFT.Physics.GrandLockRootTrace
