import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits1
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children101_5 : recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) after100 [] = .ok after100 := rfl
theorem children101_4 : recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) before100 ["SFT-INFO-QUANTITY-001"] = .ok after100 := by
 change (visit sourceDictionary534 530 visitedNode1124 before100 "SFT-INFO-QUANTITY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) done []) = _
 rewrite [visitCall100]
 change recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) after100 [] = _
 exact children101_5
theorem children101_3 : recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) before99 ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"] = .ok after100 := by
 change (visit sourceDictionary534 530 visitedNode1124 before99 "SFT-INFO-ENCODING-DECODING-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) done ["SFT-INFO-QUANTITY-001"]) = _
 rewrite [visitCall99]
 change recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) after99 ["SFT-INFO-QUANTITY-001"] = _
 exact children101_4
theorem children101_2 : recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) before98 ["SFT-MATH-OPTIMIZATION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"] = .ok after100 := by
 change (visit sourceDictionary534 530 visitedNode1124 before98 "SFT-MATH-OPTIMIZATION-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) done ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"]) = _
 rewrite [visitCall98]
 change recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) after98 ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"] = _
 exact children101_3
theorem children101_1 : recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) before97 ["SFT-MATH-COMBINATORICS-001","SFT-MATH-OPTIMIZATION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"] = .ok after100 := by
 change (visit sourceDictionary534 530 visitedNode1124 before97 "SFT-MATH-COMBINATORICS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) done ["SFT-MATH-OPTIMIZATION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"]) = _
 rewrite [visitCall97]
 change recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) after97 ["SFT-MATH-OPTIMIZATION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"] = _
 exact children101_2
theorem children101_0 : recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) before96 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-OPTIMIZATION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"] = .ok after100 := by
 change (visit sourceDictionary534 530 visitedNode1124 before96 "SFT-MATH-GRAPH-NETWORK-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) done ["SFT-MATH-COMBINATORICS-001","SFT-MATH-OPTIMIZATION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"]) = _
 rewrite [visitCall96]
 change recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) after96 ["SFT-MATH-COMBINATORICS-001","SFT-MATH-OPTIMIZATION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"] = _
 exact children101_1
theorem visitCall101 : visit sourceDictionary534 531 visitedNode1108 before101 "SFT-INFO-CHANNEL-CAPACITY-001" = .ok after101 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1124 done dep) before96 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-OPTIMIZATION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-QUANTITY-001"]; pure (put done.1 "SFT-INFO-CHANNEL-CAPACITY-001" (),done.2+1)) = _
 rewrite [children101_0]
 rfl
#print axioms visitCall101
end SFT.Physics.GrandLockDependencyTrace
