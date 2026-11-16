import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitNode185
import SFT.Physics.GrandLockVisitHits2
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children193_8 : recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) after192 [] = .ok after192 := rfl
theorem children193_7 : recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) before192 ["SFT-INFO-CONSERVATION-LOSS-001"] = .ok after192 := by
 change (visit sourceDictionary534 426 visitedNode3759 before192 "SFT-INFO-CONSERVATION-LOSS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) done []) = _
 rewrite [visitCall192]
 change recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) after192 [] = _
 exact children193_8
theorem children193_6 : recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) before191 ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after192 := by
 change (visit sourceDictionary534 426 visitedNode3759 before191 "SFT-INFO-ENCODING-DECODING-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) done ["SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall191]
 change recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) after191 ["SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children193_7
theorem children193_5 : recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) before190 ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after192 := by
 change (visit sourceDictionary534 426 visitedNode3759 before190 "SFT-MATH-CATEGORY-TYPE-COMPOSITION-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) done ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall190]
 change recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) after190 ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children193_6
theorem children193_4 : recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) before189 ["SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after192 := by
 change (visit sourceDictionary534 426 visitedNode3759 before189 "SFT-MATH-LOGIC-PROOF-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) done ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall189]
 change recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) after189 ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children193_5
theorem children193_3 : recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) before188 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after192 := by
 change (visit sourceDictionary534 426 visitedNode3759 before188 "SFT-MATH-GRAPH-NETWORK-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) done ["SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall188]
 change recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) after188 ["SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children193_4
theorem children193_2 : recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) before187 ["SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after192 := by
 change (visit sourceDictionary534 426 visitedNode3759 before187 "SFT-MATH-DISCRETE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) done ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall187]
 change recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) after187 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children193_3
theorem children193_1 : recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) before186 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after192 := by
 change (visit sourceDictionary534 426 visitedNode3759 before186 "SFT-FOUNDATION-FORM-ENFORCEMENT-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) done ["SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall186]
 change recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) after186 ["SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children193_2
theorem children193_0 : recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) before185 ["SFT-COMP-FORM-CIRCUIT-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after192 := by
 change (visit sourceDictionary534 426 visitedNode3759 before185 "SFT-COMP-FORM-CIRCUIT-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) done ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall185]
 change recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) after185 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children193_1
theorem visitCall193 : visit sourceDictionary534 427 visitedNode3729 before193 "SFT-COMP-FORM-OPERATIONAL-PROCESS-001" = .ok after193 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 426 visitedNode3759 done dep) before185 ["SFT-COMP-FORM-CIRCUIT-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]; pure (put done.1 "SFT-COMP-FORM-OPERATIONAL-PROCESS-001" (),done.2+1)) = _
 rewrite [children193_0]
 rfl
#print axioms visitCall193
end SFT.Physics.GrandLockDependencyTrace
