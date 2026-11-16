import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode149
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents150_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state150_3 [] = .ok state150_3 := rfl
theorem parents150_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state150_2 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state150_3 := rfl
theorem parents150_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state150_1 ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state150_3 := rfl
theorem parents150_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state150_0 ["SFT-PHYS-WAVE-EXACT-OPERATIONS-003","SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state150_3 := by
 change (reachesOne sourceDictionary534 534 memoNode2758 "SFT-PHYS-WAVE-EXACT-OPERATIONS-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall149]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state150_1 ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents150_1
theorem rootCall150 : reachesOne sourceDictionary534 535 memoNode2758 "SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003" = .ok result150 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state150_0 ["SFT-PHYS-WAVE-EXACT-OPERATIONS-003","SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003" result.1)) = _
 rewrite [parents150_0]
 rfl
#print axioms rootCall150
end SFT.Physics.GrandLockRootTrace
