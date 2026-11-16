import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode14
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents15_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state15_7 [] = .ok state15_7 := rfl
theorem parents15_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state15_6 ["SFT-MATH-ORDER-LATTICE-001"] = .ok state15_7 := rfl
theorem parents15_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state15_5 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state15_7 := rfl
theorem parents15_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state15_4 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state15_7 := rfl
theorem parents15_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state15_3 ["SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state15_7 := rfl
theorem parents15_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state15_2 ["SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state15_7 := rfl
theorem parents15_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state15_1 ["SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005","SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state15_7 := rfl
theorem parents15_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state15_0 ["SFT-PHYS-ATOMIC-TRANSITION-SELECTION-004","SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005","SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state15_7 := by
 change (reachesOne sourceDictionary534 534 memoNode256 "SFT-PHYS-ATOMIC-TRANSITION-SELECTION-004" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005","SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"]) = _
 rewrite [rootCall14]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state15_1 ["SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005","SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"] = _
 exact parents15_1
theorem rootCall15 : reachesOne sourceDictionary534 535 memoNode256 "SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005" = .ok result15 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state15_0 ["SFT-PHYS-ATOMIC-TRANSITION-SELECTION-004","SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005","SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001"]; pure (result.1,put result.2 "SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005" result.1)) = _
 rewrite [parents15_0]
 rfl
#print axioms rootCall15
end SFT.Physics.GrandLockRootTrace
