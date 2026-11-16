import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitNode177
import SFT.Physics.GrandLockVisitHits2
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children185_8 : recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) after184 [] = .ok after184 := rfl
theorem children185_7 : recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) before184 ["SFT-INFO-CONSERVATION-LOSS-001"] = .ok after184 := by
 change (visit sourceDictionary534 425 visitedNode3778 before184 "SFT-INFO-CONSERVATION-LOSS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) done []) = _
 rewrite [visitCall184]
 change recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) after184 [] = _
 exact children185_8
theorem children185_6 : recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) before183 ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after184 := by
 change (visit sourceDictionary534 425 visitedNode3778 before183 "SFT-INFO-ENCODING-DECODING-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) done ["SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall183]
 change recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) after183 ["SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children185_7
theorem children185_5 : recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) before182 ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after184 := by
 change (visit sourceDictionary534 425 visitedNode3778 before182 "SFT-MATH-CATEGORY-TYPE-COMPOSITION-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) done ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall182]
 change recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) after182 ["SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children185_6
theorem children185_4 : recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) before181 ["SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after184 := by
 change (visit sourceDictionary534 425 visitedNode3778 before181 "SFT-MATH-LOGIC-PROOF-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) done ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall181]
 change recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) after181 ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children185_5
theorem children185_3 : recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) before180 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after184 := by
 change (visit sourceDictionary534 425 visitedNode3778 before180 "SFT-MATH-GRAPH-NETWORK-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) done ["SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall180]
 change recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) after180 ["SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children185_4
theorem children185_2 : recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) before179 ["SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after184 := by
 change (visit sourceDictionary534 425 visitedNode3778 before179 "SFT-MATH-DISCRETE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) done ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall179]
 change recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) after179 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children185_3
theorem children185_1 : recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) before178 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after184 := by
 change (visit sourceDictionary534 425 visitedNode3778 before178 "SFT-FOUNDATION-FORM-ENFORCEMENT-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) done ["SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall178]
 change recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) after178 ["SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children185_2
theorem children185_0 : recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) before177 ["SFT-COMP-FORM-ABSTRACT-MACHINE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok after184 := by
 change (visit sourceDictionary534 425 visitedNode3778 before177 "SFT-COMP-FORM-ABSTRACT-MACHINE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) done ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [visitCall177]
 change recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) after177 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact children185_1
theorem visitCall185 : visit sourceDictionary534 426 visitedNode3759 before185 "SFT-COMP-FORM-CIRCUIT-001" = .ok after185 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 425 visitedNode3778 done dep) before177 ["SFT-COMP-FORM-ABSTRACT-MACHINE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]; pure (put done.1 "SFT-COMP-FORM-CIRCUIT-001" (),done.2+1)) = _
 rewrite [children185_0]
 rfl
#print axioms visitCall185
end SFT.Physics.GrandLockDependencyTrace
