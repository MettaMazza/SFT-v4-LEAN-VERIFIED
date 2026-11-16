import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits1
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children120_4 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) after119 [] = .ok after119 := rfl
theorem children120_3 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) before119 ["SFT-INFO-CONSERVATION-LOSS-001"] = .ok after119 := by
 change (visit sourceDictionary534 531 visitedNode1288 before119 "SFT-INFO-CONSERVATION-LOSS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) done []) = _
 rewrite [visitCall119]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) after119 [] = _
 exact children120_4
theorem children120_2 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) before118 ["SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after119 := by
 change (visit sourceDictionary534 531 visitedNode1288 before118 "SFT-INFO-MUTUAL-CONDITIONAL-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) done ["SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall118]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) after118 ["SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children120_3
theorem children120_1 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) before117 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after119 := by
 change (visit sourceDictionary534 531 visitedNode1288 before117 "SFT-INFO-ENTROPY-UNCERTAINTY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) done ["SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall117]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) after117 ["SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children120_2
theorem children120_0 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) before116 ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after119 := by
 change (visit sourceDictionary534 531 visitedNode1288 before116 "SFT-MATH-PROBABILITY-STATISTICS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) done ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall116]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) after116 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children120_1
theorem visitCall120 : visit sourceDictionary534 532 visitedNode861 before120 "SFT-INFO-CLASSICAL-PROBABILISTIC-001" = .ok after120 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1288 done dep) before116 ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-INFO-CONSERVATION-LOSS-001"]; pure (put done.1 "SFT-INFO-CLASSICAL-PROBABILISTIC-001" (),done.2+1)) = _
 rewrite [children120_0]
 rfl
#print axioms visitCall120
end SFT.Physics.GrandLockDependencyTrace
