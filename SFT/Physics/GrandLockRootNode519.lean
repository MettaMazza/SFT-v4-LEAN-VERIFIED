import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode518
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents519_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state519_6 [] = .ok state519_6 := rfl
theorem parents519_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state519_5 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok state519_6 := rfl
theorem parents519_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state519_4 ["SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok state519_6 := rfl
theorem parents519_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state519_3 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok state519_6 := rfl
theorem parents519_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state519_2 ["SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok state519_6 := rfl
theorem parents519_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state519_1 ["SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok state519_6 := rfl
theorem parents519_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state519_0 ["SFT-PHYS-THERMAL-HISTORY-RECOMBINATION-TERMINAL-037","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok state519_6 := by
 change (reachesOne sourceDictionary534 534 memoNode8214 "SFT-PHYS-THERMAL-HISTORY-RECOMBINATION-TERMINAL-037" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]) = _
 rewrite [rootCall518]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state519_1 ["SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = _
 exact parents519_1
theorem rootCall519 : reachesOne sourceDictionary534 535 memoNode8214 "SFT-PHYS-THERMAL-HELIUM-ISOTOPE-TERMINAL-057" = .ok result519 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state519_0 ["SFT-PHYS-THERMAL-HISTORY-RECOMBINATION-TERMINAL-037","SFT-PHYS-MATTER-COMPOSITE-HADRONS-001","SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]; pure (result.1,put result.2 "SFT-PHYS-THERMAL-HELIUM-ISOTOPE-TERMINAL-057" result.1)) = _
 rewrite [parents519_0]
 rfl
#print axioms rootCall519
end SFT.Physics.GrandLockRootTrace
