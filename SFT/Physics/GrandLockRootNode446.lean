import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents446_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state446_7 [] = .ok state446_7 := rfl
theorem parents446_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state446_6 ["SFT-PHYS-QUANTUM-CLASSICAL-LIMIT-001"] = .ok state446_7 := rfl
theorem parents446_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state446_5 ["SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CLASSICAL-LIMIT-001"] = .ok state446_7 := rfl
theorem parents446_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state446_4 ["SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CLASSICAL-LIMIT-001"] = .ok state446_7 := rfl
theorem parents446_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state446_3 ["SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CLASSICAL-LIMIT-001"] = .ok state446_7 := rfl
theorem parents446_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state446_2 ["SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CLASSICAL-LIMIT-001"] = .ok state446_7 := rfl
theorem parents446_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state446_1 ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CLASSICAL-LIMIT-001"] = .ok state446_7 := rfl
theorem parents446_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state446_0 ["SFT-INFO-QUANTUM-CORRESPONDENCE-001","SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CLASSICAL-LIMIT-001"] = .ok state446_7 := by
 change (reachesOne sourceDictionary534 534 memoNode7024 "SFT-INFO-QUANTUM-CORRESPONDENCE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CLASSICAL-LIMIT-001"]) = _
 rewrite [rootCall445]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state446_1 ["SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CLASSICAL-LIMIT-001"] = _
 exact parents446_1
theorem rootCall446 : reachesOne sourceDictionary534 535 memoNode7024 "SFT-PHYS-QUANTUM-NO-SIGNALLING-001" = .ok result446 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state446_0 ["SFT-INFO-QUANTUM-CORRESPONDENCE-001","SFT-QUANTUM-INFORMATION-UNIT-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-WAVE-INTERFERENCE-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-CLASSICAL-LIMIT-001"]; pure (result.1,put result.2 "SFT-PHYS-QUANTUM-NO-SIGNALLING-001" result.1)) = _
 rewrite [parents446_0]
 rfl
#print axioms rootCall446
end SFT.Physics.GrandLockRootTrace
