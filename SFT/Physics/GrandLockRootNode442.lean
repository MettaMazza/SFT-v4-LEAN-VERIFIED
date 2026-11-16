import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents442_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state442_7 [] = .ok state442_7 := rfl
theorem parents442_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state442_6 ["SFT-PHYS-QUANTUM-WEIGHT-001"] = .ok state442_7 := rfl
theorem parents442_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state442_5 ["SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-WEIGHT-001"] = .ok state442_7 := rfl
theorem parents442_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state442_4 ["SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-WEIGHT-001"] = .ok state442_7 := rfl
theorem parents442_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state442_3 ["SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-WEIGHT-001"] = .ok state442_7 := rfl
theorem parents442_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state442_2 ["SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-WEIGHT-001"] = .ok state442_7 := rfl
theorem parents442_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state442_1 ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-WEIGHT-001"] = .ok state442_7 := rfl
theorem parents442_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state442_0 ["SFT-INFO-QUANTUM-CORRESPONDENCE-001","SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-WEIGHT-001"] = .ok state442_7 := by
 change (reachesOne sourceDictionary534 534 memoNode6965 "SFT-INFO-QUANTUM-CORRESPONDENCE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-WEIGHT-001"]) = _
 rewrite [rootCall441]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state442_1 ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-WEIGHT-001"] = _
 exact parents442_1
theorem rootCall442 : reachesOne sourceDictionary534 535 memoNode6965 "SFT-PHYS-QUANTUM-INCOMPATIBILITY-001" = .ok result442 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state442_0 ["SFT-INFO-QUANTUM-CORRESPONDENCE-001","SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-WEIGHT-001"]; pure (result.1,put result.2 "SFT-PHYS-QUANTUM-INCOMPATIBILITY-001" result.1)) = _
 rewrite [parents442_0]
 rfl
#print axioms rootCall442
end SFT.Physics.GrandLockRootTrace
