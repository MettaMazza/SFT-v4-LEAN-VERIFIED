import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents19_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state19_6 [] = .ok state19_6 := rfl
theorem parents19_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state19_5 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state19_6 := rfl
theorem parents19_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state19_4 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state19_6 := rfl
theorem parents19_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state19_3 ["SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state19_6 := rfl
theorem parents19_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state19_2 ["SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004","SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state19_6 := rfl
theorem parents19_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state19_1 ["SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004","SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004","SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state19_6 := rfl
theorem parents19_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state19_0 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004","SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004","SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state19_6 := by
 change (reachesOne sourceDictionary534 534 memoNode399 "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004","SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004","SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall18]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state19_1 ["SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004","SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004","SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents19_1
theorem rootCall19 : reachesOne sourceDictionary534 535 memoNode399 "SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005" = .ok result19 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state19_0 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004","SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004","SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005" result.1)) = _
 rewrite [parents19_0]
 rfl
#print axioms rootCall19
end SFT.Physics.GrandLockRootTrace
