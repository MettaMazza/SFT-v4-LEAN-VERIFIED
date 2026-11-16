import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits1
import SFT.Physics.GrandLockVisitNode101
import SFT.Physics.GrandLockVisitNode114
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children115_5 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) after114 [] = .ok after114 := rfl
theorem children115_4 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) before114 ["SFT-INFO-MUTUAL-CONDITIONAL-001"] = .ok after114 := by
 change (visit sourceDictionary534 531 visitedNode1108 before114 "SFT-INFO-MUTUAL-CONDITIONAL-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) done []) = _
 rewrite [visitCall114]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) after114 [] = _
 exact children115_5
theorem children115_3 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) before101 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001"] = .ok after114 := by
 change (visit sourceDictionary534 531 visitedNode1108 before101 "SFT-INFO-CHANNEL-CAPACITY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) done ["SFT-INFO-MUTUAL-CONDITIONAL-001"]) = _
 rewrite [visitCall101]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) after101 ["SFT-INFO-MUTUAL-CONDITIONAL-001"] = _
 exact children115_4
theorem children115_2 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) before95 ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001"] = .ok after114 := by
 change (visit sourceDictionary534 531 visitedNode1108 before95 "SFT-INFO-ENCODING-DECODING-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) done ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001"]) = _
 rewrite [visitCall95]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) after95 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001"] = _
 exact children115_3
theorem children115_1 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) before94 ["SFT-MATH-LOGIC-PROOF-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001"] = .ok after114 := by
 change (visit sourceDictionary534 531 visitedNode1108 before94 "SFT-MATH-LOGIC-PROOF-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) done ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001"]) = _
 rewrite [visitCall94]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) after94 ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001"] = _
 exact children115_2
theorem children115_0 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) before93 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001"] = .ok after114 := by
 change (visit sourceDictionary534 531 visitedNode1108 before93 "SFT-MATH-DYNAMICAL-SYSTEMS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) done ["SFT-MATH-LOGIC-PROOF-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001"]) = _
 rewrite [visitCall93]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) after93 ["SFT-MATH-LOGIC-PROOF-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001"] = _
 exact children115_1
theorem visitCall115 : visit sourceDictionary534 532 visitedNode861 before115 "SFT-INFO-CONSERVATION-LOSS-001" = .ok after115 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 531 visitedNode1108 done dep) before93 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-INFO-MUTUAL-CONDITIONAL-001"]; pure (put done.1 "SFT-INFO-CONSERVATION-LOSS-001" (),done.2+1)) = _
 rewrite [children115_0]
 rfl
#print axioms visitCall115
end SFT.Physics.GrandLockDependencyTrace
