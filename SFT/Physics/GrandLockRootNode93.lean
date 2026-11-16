import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents93_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state93_4 [] = .ok state93_4 := rfl
theorem parents93_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state93_3 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001"] = .ok state93_4 := rfl
theorem parents93_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state93_2 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001"] = .ok state93_4 := rfl
theorem parents93_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state93_1 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001"] = .ok state93_4 := rfl
theorem parents93_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state93_0 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001"] = .ok state93_4 := by
 change (reachesOne sourceDictionary534 530 memoNode1669 "SFT-FOUNDATION-COUNT-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) next ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001"]) = _
 rewrite [rootCall92]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state93_1 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001"] = _
 exact parents93_1
theorem rootCall93 : reachesOne sourceDictionary534 531 memoNode1669 "SFT-MATH-EXACT-ARITHMETIC-001" = .ok result93 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state93_0 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001"]; pure (result.1,put result.2 "SFT-MATH-EXACT-ARITHMETIC-001" result.1)) = _
 rewrite [parents93_0]
 rfl
#print axioms rootCall93
end SFT.Physics.GrandLockRootTrace
