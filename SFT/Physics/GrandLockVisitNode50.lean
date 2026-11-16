import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitNode2
import SFT.Physics.GrandLockVisitNode5
import SFT.Physics.GrandLockVisitNode9
import SFT.Physics.GrandLockVisitNode12
import SFT.Physics.GrandLockVisitNode16
import SFT.Physics.GrandLockVisitNode25
import SFT.Physics.GrandLockVisitNode49
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children50_7 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) after49 [] = .ok after49 := rfl
theorem children50_6 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) before49 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after49 := by
 change (visit sourceDictionary534 533 visitedNode71 before49 "SFT-MATH-DYNAMICAL-SYSTEMS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) done []) = _
 rewrite [visitCall49]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) after49 [] = _
 exact children50_7
theorem children50_5 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) before25 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after49 := by
 change (visit sourceDictionary534 533 visitedNode71 before25 "SFT-MATH-EXACT-ARITHMETIC-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) done ["SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [visitCall25]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) after25 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact children50_6
theorem children50_4 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) before16 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after49 := by
 change (visit sourceDictionary534 533 visitedNode71 before16 "SFT-FOUNDATION-PART-EQUIVALENCE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) done ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [visitCall16]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) after16 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact children50_5
theorem children50_3 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) before12 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after49 := by
 change (visit sourceDictionary534 533 visitedNode71 before12 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) done ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [visitCall12]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) after12 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact children50_4
theorem children50_2 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) before9 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after49 := by
 change (visit sourceDictionary534 533 visitedNode71 before9 "SFT-FOUNDATION-FOLD-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) done ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [visitCall9]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) after9 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact children50_3
theorem children50_1 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) before5 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after49 := by
 change (visit sourceDictionary534 533 visitedNode71 before5 "SFT-FOUNDATION-PART-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) done ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [visitCall5]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) after5 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact children50_2
theorem children50_0 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) before2 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after49 := by
 change (visit sourceDictionary534 533 visitedNode71 before2 "SFT-FOUNDATION-COUNT-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) done ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [visitCall2]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) after2 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact children50_1
theorem visitCall50 : visit sourceDictionary534 534 visitedNode40 before50 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" = .ok after50 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 533 visitedNode71 done dep) before2 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]; pure (put done.1 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" (),done.2+1)) = _
 rewrite [children50_0]
 rfl
#print axioms visitCall50
end SFT.Physics.GrandLockDependencyTrace
