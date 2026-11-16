import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode100
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents101_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state101_4 [] = .ok state101_4 := rfl
theorem parents101_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state101_3 ["SFT-FOUNDATION-COUNT-001"] = .ok state101_4 := rfl
theorem parents101_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state101_2 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-COUNT-001"] = .ok state101_4 := rfl
theorem parents101_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state101_1 ["SFT-MATH-SELF-SIMILAR-CONVERGENCE-002","SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-COUNT-001"] = .ok state101_4 := rfl
theorem parents101_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state101_0 ["SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006","SFT-MATH-SELF-SIMILAR-CONVERGENCE-002","SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-COUNT-001"] = .ok state101_4 := by
 change (reachesOne sourceDictionary534 534 memoNode1832 "SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-SELF-SIMILAR-CONVERGENCE-002","SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-COUNT-001"]) = _
 rewrite [rootCall100]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state101_1 ["SFT-MATH-SELF-SIMILAR-CONVERGENCE-002","SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-COUNT-001"] = _
 exact parents101_1
theorem rootCall101 : reachesOne sourceDictionary534 535 memoNode1832 "SFT-PHYS-COUPLING-ACCUMULATED-SEPARATION-TERMINAL-015" = .ok result101 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state101_0 ["SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006","SFT-MATH-SELF-SIMILAR-CONVERGENCE-002","SFT-MATH-EXACT-ARITHMETIC-001","SFT-FOUNDATION-COUNT-001"]; pure (result.1,put result.2 "SFT-PHYS-COUPLING-ACCUMULATED-SEPARATION-TERMINAL-015" result.1)) = _
 rewrite [parents101_0]
 rfl
#print axioms rootCall101
end SFT.Physics.GrandLockRootTrace
