import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents432_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state432_7 [] = .ok state432_7 := rfl
theorem parents432_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state432_6 ["SFT-PHYS-QUANTUM-CONTEXTUALITY-001"] = .ok state432_7 := rfl
theorem parents432_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state432_5 ["SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CONTEXTUALITY-001"] = .ok state432_7 := rfl
theorem parents432_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state432_4 ["SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CONTEXTUALITY-001"] = .ok state432_7 := rfl
theorem parents432_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state432_3 ["SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CONTEXTUALITY-001"] = .ok state432_7 := rfl
theorem parents432_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state432_2 ["SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CONTEXTUALITY-001"] = .ok state432_7 := rfl
theorem parents432_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state432_1 ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CONTEXTUALITY-001"] = .ok state432_7 := rfl
theorem parents432_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state432_0 ["SFT-INFO-QUANTUM-CORRESPONDENCE-001","SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CONTEXTUALITY-001"] = .ok state432_7 := by
 change (reachesOne sourceDictionary534 534 memoNode6843 "SFT-INFO-QUANTUM-CORRESPONDENCE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CONTEXTUALITY-001"]) = _
 rewrite [rootCall431]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state432_1 ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CONTEXTUALITY-001"] = _
 exact parents432_1
theorem rootCall432 : reachesOne sourceDictionary534 535 memoNode6843 "SFT-PHYS-QUANTUM-DECOHERENCE-001" = .ok result432 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state432_0 ["SFT-INFO-QUANTUM-CORRESPONDENCE-001","SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CONTEXTUALITY-001"]; pure (result.1,put result.2 "SFT-PHYS-QUANTUM-DECOHERENCE-001" result.1)) = _
 rewrite [parents432_0]
 rfl
#print axioms rootCall432
end SFT.Physics.GrandLockRootTrace
