import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode13
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents14_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state14_5 [] = .ok state14_5 := rfl
theorem parents14_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state14_4 ["SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state14_5 := rfl
theorem parents14_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state14_3 ["SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state14_5 := rfl
theorem parents14_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state14_2 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state14_5 := rfl
theorem parents14_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state14_1 ["SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state14_5 := rfl
theorem parents14_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state14_0 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state14_5 := by
 change (reachesOne sourceDictionary534 533 memoNode256 "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"]) = _
 rewrite [rootCall13]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state14_1 ["SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = _
 exact parents14_1
theorem rootCall14 : reachesOne sourceDictionary534 534 memoNode256 "SFT-PHYS-ATOMIC-TRANSITION-SELECTION-004" = .ok result14 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state14_0 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-FIELD-MAGNETIC-RELATIVITY-003","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"]; pure (result.1,put result.2 "SFT-PHYS-ATOMIC-TRANSITION-SELECTION-004" result.1)) = _
 rewrite [parents14_0]
 rfl
#print axioms rootCall14
end SFT.Physics.GrandLockRootTrace
