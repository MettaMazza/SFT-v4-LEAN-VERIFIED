import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode241
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents242_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state242_3 [] = .ok state242_3 := rfl
theorem parents242_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state242_2 ["SFT-MATH-ALGEBRA-001"] = .ok state242_3 := rfl
theorem parents242_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state242_1 ["SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001","SFT-MATH-ALGEBRA-001"] = .ok state242_3 := rfl
theorem parents242_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state242_0 ["SFT-PHYS-MATTER-QUARK-INVARIANTS-003","SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001","SFT-MATH-ALGEBRA-001"] = .ok state242_3 := by
 change (reachesOne sourceDictionary534 531 memoNode4186 "SFT-PHYS-MATTER-QUARK-INVARIANTS-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) next ["SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001","SFT-MATH-ALGEBRA-001"]) = _
 rewrite [rootCall241]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state242_1 ["SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001","SFT-MATH-ALGEBRA-001"] = _
 exact parents242_1
theorem rootCall242 : reachesOne sourceDictionary534 532 memoNode4186 "SFT-PHYS-MATTER-QUARK-CUBICS-003" = .ok result242 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state242_0 ["SFT-PHYS-MATTER-QUARK-INVARIANTS-003","SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001","SFT-MATH-ALGEBRA-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-QUARK-CUBICS-003" result.1)) = _
 rewrite [parents242_0]
 rfl
#print axioms rootCall242
end SFT.Physics.GrandLockRootTrace
