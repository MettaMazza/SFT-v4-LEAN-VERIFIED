import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode263
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents264_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state264_3 [] = .ok state264_3 := rfl
theorem parents264_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state264_2 ["SFT-FOUNDATION-FOLD-DYNAMICS-001"] = .ok state264_3 := rfl
theorem parents264_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state264_1 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-FOLD-DYNAMICS-001"] = .ok state264_3 := rfl
theorem parents264_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state264_0 ["SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-FOLD-DYNAMICS-001"] = .ok state264_3 := by
 change (reachesOne sourceDictionary534 534 memoNode4518 "SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-FOLD-DYNAMICS-001"]) = _
 rewrite [rootCall263]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state264_1 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-FOLD-DYNAMICS-001"] = _
 exact parents264_1
theorem rootCall264 : reachesOne sourceDictionary534 535 memoNode4518 "SFT-PHYS-MATTER-GENERATION-DEPTH-003" = .ok result264 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state264_0 ["SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-FOLD-DYNAMICS-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-GENERATION-DEPTH-003" result.1)) = _
 rewrite [parents264_0]
 rfl
#print axioms rootCall264
end SFT.Physics.GrandLockRootTrace
