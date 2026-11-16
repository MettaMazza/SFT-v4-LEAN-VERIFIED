import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockTraceFoldStep
import SFT.Physics.GrandLockVisitUnfold534
import SFT.Physics.GrandLockVisitHits21
import SFT.Physics.GrandLockVisitNode1666
import SFT.Physics.GrandLockVisitNode1684
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
noncomputable def step1685 (state : Complete) (dep : String) : Except String Complete := visit sourceDictionary534 533 (put visitedNode9427 "SFT-PHYS-MATTER-CONSERVED-LABELS-001" ()) state dep
theorem children1685_6 : recordFold step1685 after1684 [] = .ok after1684 := rfl
theorem children1685_5 : recordFold step1685 before1684 ["SFT-PHYS-MATTER-FERMION-BOSON-001"] = .ok after1684 := sourceFoldCall step1685 before1684 after1684 after1684 "SFT-PHYS-MATTER-FERMION-BOSON-001" [] visitCall1684 children1685_6
theorem children1685_4 : recordFold step1685 before1666 ["SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-FERMION-BOSON-001"] = .ok after1684 := sourceFoldCall step1685 before1666 after1666 after1684 "SFT-PHYS-QUANTUM-NO-SIGNALLING-001" ["SFT-PHYS-MATTER-FERMION-BOSON-001"] visitCall1666 children1685_5
theorem children1685_3 : recordFold step1685 before1623 ["SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-FERMION-BOSON-001"] = .ok after1684 := sourceFoldCall step1685 before1623 after1623 after1684 "SFT-PHYS-QUANTUM-EXCLUSION-001" ["SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-FERMION-BOSON-001"] visitCall1623 children1685_4
theorem children1685_2 : recordFold step1685 before1622 ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-FERMION-BOSON-001"] = .ok after1684 := sourceFoldCall step1685 before1622 after1622 after1684 "SFT-PHYS-QUANTUM-SPIN-001" ["SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-FERMION-BOSON-001"] visitCall1622 children1685_3
theorem children1685_1 : recordFold step1685 before1621 ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-FERMION-BOSON-001"] = .ok after1684 := sourceFoldCall step1685 before1621 after1621 after1684 "SFT-PHYS-FIELD-INTERACTION-CLASSES-001" ["SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-FERMION-BOSON-001"] visitCall1621 children1685_2
theorem children1685_0 : recordFold step1685 before1620 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-FERMION-BOSON-001"] = .ok after1684 := sourceFoldCall step1685 before1620 after1620 after1684 "SFT-PHYS-MECH-CONSERVATION-001" ["SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-FERMION-BOSON-001"] visitCall1620 children1685_1
theorem visitCall1685 : visit sourceDictionary534 534 visitedNode9427 before1685 "SFT-PHYS-MATTER-CONSERVED-LABELS-001" = .ok after1685 :=
 visitCallFromFold534 sourceDictionary534 visitedNode9427 before1685 after1684 "SFT-PHYS-MATTER-CONSERVED-LABELS-001" ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-INTERACTION-CLASSES-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-NO-SIGNALLING-001","SFT-PHYS-MATTER-FERMION-BOSON-001"] (by rfl) (by rfl) (by rfl) children1685_0
#print axioms visitCall1685
end SFT.Physics.GrandLockDependencyTrace
