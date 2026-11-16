import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode347
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents348_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state348_7 [] = .ok state348_7 := rfl
theorem parents348_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state348_6 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state348_7 := rfl
theorem parents348_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state348_5 ["SFT-CHEM-BOND-COVALENT-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state348_7 := rfl
theorem parents348_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state348_4 ["SFT-PHYS-WAVE-RESONANCE-001","SFT-CHEM-BOND-COVALENT-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state348_7 := rfl
theorem parents348_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state348_3 ["SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-CHEM-BOND-COVALENT-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state348_7 := rfl
theorem parents348_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state348_2 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-CHEM-BOND-COVALENT-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state348_7 := rfl
theorem parents348_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state348_1 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-CHEM-BOND-COVALENT-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state348_7 := rfl
theorem parents348_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state348_0 ["SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-CHEM-BOND-COVALENT-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state348_7 := by
 change (reachesOne sourceDictionary534 534 memoNode5561 "SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-CHEM-BOND-COVALENT-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall347]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state348_1 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-CHEM-BOND-COVALENT-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents348_1
theorem rootCall348 : reachesOne sourceDictionary534 535 memoNode5561 "SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005" = .ok result348 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state348_0 ["SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-CHEM-BOND-COVALENT-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005" result.1)) = _
 rewrite [parents348_0]
 rfl
#print axioms rootCall348
end SFT.Physics.GrandLockRootTrace
