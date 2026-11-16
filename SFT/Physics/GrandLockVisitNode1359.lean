import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockTraceFoldStep
import SFT.Physics.GrandLockVisitUnfold533
import SFT.Physics.GrandLockVisitHits14
import SFT.Physics.GrandLockVisitNode1272
import SFT.Physics.GrandLockVisitNode1338
import SFT.Physics.GrandLockVisitNode1358
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
noncomputable def step1359 (state : Complete) (dep : String) : Except String Complete := visit sourceDictionary534 532 (put visitedNode834 "SFT-PHYS-WAVE-INTERFERENCE-001" ()) state dep
theorem children1359_5 : recordFold step1359 after1358 [] = .ok after1358 := rfl
theorem children1359_4 : recordFold step1359 before1358 ["SFT-PHYS-WAVE-SUPERPOSITION-001"] = .ok after1358 := sourceFoldCall step1359 before1358 after1358 after1358 "SFT-PHYS-WAVE-SUPERPOSITION-001" [] visitCall1358 children1359_5
theorem children1359_3 : recordFold step1359 before1338 ["SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SUPERPOSITION-001"] = .ok after1358 := sourceFoldCall step1359 before1338 after1338 after1358 "SFT-PHYS-FIELD-RADIATION-001" ["SFT-PHYS-WAVE-SUPERPOSITION-001"] visitCall1338 children1359_4
theorem children1359_2 : recordFold step1359 before1272 ["SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SUPERPOSITION-001"] = .ok after1358 := sourceFoldCall step1359 before1272 after1272 after1358 "SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001" ["SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SUPERPOSITION-001"] visitCall1272 children1359_3
theorem children1359_1 : recordFold step1359 before1084 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SUPERPOSITION-001"] = .ok after1358 := sourceFoldCall step1359 before1084 after1084 after1358 "SFT-INFO-CHANNEL-CAPACITY-001" ["SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SUPERPOSITION-001"] visitCall1084 children1359_2
theorem children1359_0 : recordFold step1359 before1083 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SUPERPOSITION-001"] = .ok after1358 := sourceFoldCall step1359 before1083 after1083 after1358 "SFT-MATH-DYNAMICAL-SYSTEMS-001" ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SUPERPOSITION-001"] visitCall1083 children1359_1
theorem visitCall1359 : visit sourceDictionary534 533 visitedNode834 before1359 "SFT-PHYS-WAVE-INTERFERENCE-001" = .ok after1359 :=
 visitCallFromFold533 sourceDictionary534 visitedNode834 before1359 after1358 "SFT-PHYS-WAVE-INTERFERENCE-001" ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SUPERPOSITION-001"] (by rfl) (by rfl) (by rfl) children1359_0
#print axioms visitCall1359
end SFT.Physics.GrandLockDependencyTrace
