import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitNode169
import SFT.Physics.GrandLockVisitHits2
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children177_8 : recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) after176 [] = .ok after176 := rfl
theorem children177_7 : recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) before176 ["SFT-INFO-CONSERVATION-LOSS-001"] = .ok after176 := by
 change (visit sourceDictionary534 424 visitedNode3800 before176 "SFT-INFO-CONSERVATION-LOSS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) done []) = _
 rewrite [visitCall176]
 change recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) after176 [] = _
 exact children177_8
theorem children177_6 : recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) before175 ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after176 := by
 change (visit sourceDictionary534 424 visitedNode3800 before175 "SFT-INFO-ENCODING-DECODING-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) done ["SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall175]
 change recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) after175 ["SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children177_7
theorem children177_5 : recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) before174 ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after176 := by
 change (visit sourceDictionary534 424 visitedNode3800 before174 "SFT-MATH-CATEGORY-TYPE-COMPOSITION-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) done ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall174]
 change recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) after174 ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children177_6
theorem children177_4 : recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) before173 ["SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after176 := by
 change (visit sourceDictionary534 424 visitedNode3800 before173 "SFT-MATH-LOGIC-PROOF-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) done ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall173]
 change recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) after173 ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children177_5
theorem children177_3 : recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) before172 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after176 := by
 change (visit sourceDictionary534 424 visitedNode3800 before172 "SFT-MATH-GRAPH-NETWORK-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) done ["SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall172]
 change recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) after172 ["SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children177_4
theorem children177_2 : recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) before171 ["SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after176 := by
 change (visit sourceDictionary534 424 visitedNode3800 before171 "SFT-MATH-DISCRETE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) done ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall171]
 change recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) after171 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children177_3
theorem children177_1 : recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) before170 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after176 := by
 change (visit sourceDictionary534 424 visitedNode3800 before170 "SFT-FOUNDATION-FORM-ENFORCEMENT-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) done ["SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall170]
 change recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) after170 ["SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children177_2
theorem children177_0 : recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) before169 ["SFT-COMP-FORM-LAMBDA-CALCULUS-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after176 := by
 change (visit sourceDictionary534 424 visitedNode3800 before169 "SFT-COMP-FORM-LAMBDA-CALCULUS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) done ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall169]
 change recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) after169 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children177_1
theorem visitCall177 : visit sourceDictionary534 425 visitedNode3778 before177 "SFT-COMP-FORM-ABSTRACT-MACHINE-001" = .ok after177 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 424 visitedNode3800 done dep) before169 ["SFT-COMP-FORM-LAMBDA-CALCULUS-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]; pure (put done.1 "SFT-COMP-FORM-ABSTRACT-MACHINE-001" (),done.2+1)) = _
 rewrite [children177_0]
 rfl
#print axioms visitCall177
end SFT.Physics.GrandLockDependencyTrace
