import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockTraceFoldStep
import SFT.Physics.GrandLockVisitUnfold534
import SFT.Physics.GrandLockVisitHits42
import SFT.Physics.GrandLockVisitNode3328
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
noncomputable def step3329 (state : Complete) (dep : String) : Except String Complete := visit sourceDictionary534 533 (put visitedNode18859 "SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004" ()) state dep
theorem children3329_4 : recordFold step3329 after3328 [] = .ok after3328 := rfl
theorem children3329_3 : recordFold step3329 before3328 ["SFT-CHEM-BOND-COVALENT-001"] = .ok after3328 := sourceFoldCall step3329 before3328 after3328 after3328 "SFT-CHEM-BOND-COVALENT-001" [] visitCall3328 children3329_4
theorem children3329_2 : recordFold step3329 before3132 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-CHEM-BOND-COVALENT-001"] = .ok after3328 := sourceFoldCall step3329 before3132 after3132 after3328 "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003" ["SFT-CHEM-BOND-COVALENT-001"] visitCall3132 children3329_3
theorem children3329_1 : recordFold step3329 before3131 ["SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-CHEM-BOND-COVALENT-001"] = .ok after3328 := sourceFoldCall step3329 before3131 after3131 after3328 "SFT-PHYS-WAVE-RESONANCE-001" ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-CHEM-BOND-COVALENT-001"] visitCall3131 children3329_2
theorem children3329_0 : recordFold step3329 before3130 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-CHEM-BOND-COVALENT-001"] = .ok after3328 := sourceFoldCall step3329 before3130 after3130 after3328 "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004" ["SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-CHEM-BOND-COVALENT-001"] visitCall3130 children3329_1
theorem visitCall3329 : visit sourceDictionary534 534 visitedNode18859 before3329 "SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004" = .ok after3329 :=
 visitCallFromFold534 sourceDictionary534 visitedNode18859 before3329 after3328 "SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004" ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-CHEM-BOND-COVALENT-001"] (by rfl) (by rfl) (by rfl) children3329_0
#print axioms visitCall3329
end SFT.Physics.GrandLockDependencyTrace
