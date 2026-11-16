import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode121
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents122_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state122_3 [] = .ok state122_3 := rfl
theorem parents122_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state122_2 ["SFT-MATH-EXACT-RELATIONS-002"] = .ok state122_3 := rfl
theorem parents122_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state122_1 ["SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001","SFT-MATH-EXACT-RELATIONS-002"] = .ok state122_3 := rfl
theorem parents122_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state122_0 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001","SFT-MATH-EXACT-RELATIONS-002"] = .ok state122_3 := by
 change (reachesOne sourceDictionary534 534 memoNode2334 "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001","SFT-MATH-EXACT-RELATIONS-002"]) = _
 rewrite [rootCall121]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state122_1 ["SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001","SFT-MATH-EXACT-RELATIONS-002"] = _
 exact parents122_1
theorem rootCall122 : reachesOne sourceDictionary534 535 memoNode2334 "SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002" = .ok result122 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state122_0 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001","SFT-MATH-EXACT-RELATIONS-002"]; pure (result.1,put result.2 "SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002" result.1)) = _
 rewrite [parents122_0]
 rfl
#print axioms rootCall122
end SFT.Physics.GrandLockRootTrace
