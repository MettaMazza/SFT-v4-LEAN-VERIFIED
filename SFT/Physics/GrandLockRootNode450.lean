import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents450_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state450_6 [] = .ok state450_6 := rfl
theorem parents450_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state450_5 ["SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001"] = .ok state450_6 := rfl
theorem parents450_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state450_4 ["SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001"] = .ok state450_6 := rfl
theorem parents450_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state450_3 ["SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001"] = .ok state450_6 := rfl
theorem parents450_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state450_2 ["SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001"] = .ok state450_6 := rfl
theorem parents450_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state450_1 ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001"] = .ok state450_6 := rfl
theorem parents450_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state450_0 ["SFT-INFO-QUANTUM-CORRESPONDENCE-001","SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001"] = .ok state450_6 := by
 change (reachesOne sourceDictionary534 534 memoNode7075 "SFT-INFO-QUANTUM-CORRESPONDENCE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001"]) = _
 rewrite [rootCall449]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state450_1 ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001"] = _
 exact parents450_1
theorem rootCall450 : reachesOne sourceDictionary534 535 memoNode7075 "SFT-PHYS-QUANTUM-PHYSICAL-STATE-001" = .ok result450 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state450_0 ["SFT-INFO-QUANTUM-CORRESPONDENCE-001","SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001"]; pure (result.1,put result.2 "SFT-PHYS-QUANTUM-PHYSICAL-STATE-001" result.1)) = _
 rewrite [parents450_0]
 rfl
#print axioms rootCall450
end SFT.Physics.GrandLockRootTrace
