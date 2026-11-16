import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents452_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state452_7 [] = .ok state452_7 := rfl
theorem parents452_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state452_6 ["SFT-PHYS-QUANTUM-INCOMPATIBILITY-001"] = .ok state452_7 := rfl
theorem parents452_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state452_5 ["SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-INCOMPATIBILITY-001"] = .ok state452_7 := rfl
theorem parents452_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state452_4 ["SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-INCOMPATIBILITY-001"] = .ok state452_7 := rfl
theorem parents452_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state452_3 ["SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-INCOMPATIBILITY-001"] = .ok state452_7 := rfl
theorem parents452_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state452_2 ["SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-INCOMPATIBILITY-001"] = .ok state452_7 := rfl
theorem parents452_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state452_1 ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-INCOMPATIBILITY-001"] = .ok state452_7 := rfl
theorem parents452_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state452_0 ["SFT-INFO-QUANTUM-CORRESPONDENCE-001","SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-INCOMPATIBILITY-001"] = .ok state452_7 := by
 change (reachesOne sourceDictionary534 534 memoNode7105 "SFT-INFO-QUANTUM-CORRESPONDENCE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-INCOMPATIBILITY-001"]) = _
 rewrite [rootCall451]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state452_1 ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-INCOMPATIBILITY-001"] = _
 exact parents452_1
theorem rootCall452 : reachesOne sourceDictionary534 535 memoNode7105 "SFT-PHYS-QUANTUM-SPIN-001" = .ok result452 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state452_0 ["SFT-INFO-QUANTUM-CORRESPONDENCE-001","SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-INCOMPATIBILITY-001"]; pure (result.1,put result.2 "SFT-PHYS-QUANTUM-SPIN-001" result.1)) = _
 rewrite [parents452_0]
 rfl
#print axioms rootCall452
end SFT.Physics.GrandLockRootTrace
