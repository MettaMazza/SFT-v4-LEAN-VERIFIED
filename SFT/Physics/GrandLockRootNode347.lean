import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents347_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state347_4 [] = .ok state347_4 := rfl
theorem parents347_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state347_3 ["SFT-CHEM-BOND-COVALENT-001"] = .ok state347_4 := rfl
theorem parents347_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state347_2 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-CHEM-BOND-COVALENT-001"] = .ok state347_4 := rfl
theorem parents347_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state347_1 ["SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-CHEM-BOND-COVALENT-001"] = .ok state347_4 := rfl
theorem parents347_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state347_0 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-CHEM-BOND-COVALENT-001"] = .ok state347_4 := by
 change (reachesOne sourceDictionary534 533 memoNode5561 "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-CHEM-BOND-COVALENT-001"]) = _
 rewrite [rootCall346]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state347_1 ["SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-CHEM-BOND-COVALENT-001"] = _
 exact parents347_1
theorem rootCall347 : reachesOne sourceDictionary534 534 memoNode5561 "SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004" = .ok result347 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state347_0 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-CHEM-BOND-COVALENT-001"]; pure (result.1,put result.2 "SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004" result.1)) = _
 rewrite [parents347_0]
 rfl
#print axioms rootCall347
end SFT.Physics.GrandLockRootTrace
