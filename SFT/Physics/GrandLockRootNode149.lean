import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode148
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents149_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state149_4 [] = .ok state149_4 := rfl
theorem parents149_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state149_3 ["SFT-PHYS-WAVE-RESONANCE-001"] = .ok state149_4 := rfl
theorem parents149_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state149_2 ["SFT-PHYS-WAVE-POLARIZATION-001","SFT-PHYS-WAVE-RESONANCE-001"] = .ok state149_4 := rfl
theorem parents149_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state149_1 ["SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-WAVE-POLARIZATION-001","SFT-PHYS-WAVE-RESONANCE-001"] = .ok state149_4 := rfl
theorem parents149_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state149_0 ["SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-WAVE-POLARIZATION-001","SFT-PHYS-WAVE-RESONANCE-001"] = .ok state149_4 := by
 change (reachesOne sourceDictionary534 533 memoNode2758 "SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-WAVE-POLARIZATION-001","SFT-PHYS-WAVE-RESONANCE-001"]) = _
 rewrite [rootCall148]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state149_1 ["SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-WAVE-POLARIZATION-001","SFT-PHYS-WAVE-RESONANCE-001"] = _
 exact parents149_1
theorem rootCall149 : reachesOne sourceDictionary534 534 memoNode2758 "SFT-PHYS-WAVE-EXACT-OPERATIONS-003" = .ok result149 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state149_0 ["SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-PHYS-WAVE-POLARIZATION-001","SFT-PHYS-WAVE-RESONANCE-001"]; pure (result.1,put result.2 "SFT-PHYS-WAVE-EXACT-OPERATIONS-003" result.1)) = _
 rewrite [parents149_0]
 rfl
#print axioms rootCall149
end SFT.Physics.GrandLockRootTrace
