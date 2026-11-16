import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode147
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents148_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state148_3 [] = .ok state148_3 := rfl
theorem parents148_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state148_2 ["SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = .ok state148_3 := rfl
theorem parents148_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state148_1 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = .ok state148_3 := rfl
theorem parents148_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state148_0 ["SFT-PHYS-FIELD-MAXWELL-PLANAR-CLOSURE-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = .ok state148_3 := by
 change (reachesOne sourceDictionary534 532 memoNode2758 "SFT-PHYS-FIELD-MAXWELL-PLANAR-CLOSURE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"]) = _
 rewrite [rootCall147]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state148_1 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = _
 exact parents148_1
theorem rootCall148 : reachesOne sourceDictionary534 533 memoNode2758 "SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003" = .ok result148 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state148_0 ["SFT-PHYS-FIELD-MAXWELL-PLANAR-CLOSURE-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"]; pure (result.1,put result.2 "SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003" result.1)) = _
 rewrite [parents148_0]
 rfl
#print axioms rootCall148
end SFT.Physics.GrandLockRootTrace
