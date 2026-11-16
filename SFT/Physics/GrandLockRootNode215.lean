import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents215_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state215_3 [] = .ok state215_3 := rfl
theorem parents215_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state215_2 ["SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003"] = .ok state215_3 := rfl
theorem parents215_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state215_1 ["SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003"] = .ok state215_3 := rfl
theorem parents215_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state215_0 ["SFT-PHYS-GRAVITY-GRAVITON-POLARIZATION-003","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003"] = .ok state215_3 := by
 change (reachesOne sourceDictionary534 532 memoNode3847 "SFT-PHYS-GRAVITY-GRAVITON-POLARIZATION-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003"]) = _
 rewrite [rootCall214]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state215_1 ["SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003"] = _
 exact parents215_1
theorem rootCall215 : reachesOne sourceDictionary534 533 memoNode3847 "SFT-PHYS-GRAVITY-WAVE-QUADRUPOLE-003" = .ok result215 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state215_0 ["SFT-PHYS-GRAVITY-GRAVITON-POLARIZATION-003","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003"]; pure (result.1,put result.2 "SFT-PHYS-GRAVITY-WAVE-QUADRUPOLE-003" result.1)) = _
 rewrite [parents215_0]
 rfl
#print axioms rootCall215
end SFT.Physics.GrandLockRootTrace
