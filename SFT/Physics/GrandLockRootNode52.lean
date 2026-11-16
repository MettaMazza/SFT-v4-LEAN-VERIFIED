import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents52_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state52_7 [] = .ok state52_7 := rfl
theorem parents52_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state52_6 ["SFT-PHYS-CONDENSED-PHASE-ORDER-001"] = .ok state52_7 := rfl
theorem parents52_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state52_5 ["SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-PHASE-ORDER-001"] = .ok state52_7 := rfl
theorem parents52_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state52_4 ["SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-PHASE-ORDER-001"] = .ok state52_7 := rfl
theorem parents52_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state52_3 ["SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-PHASE-ORDER-001"] = .ok state52_7 := rfl
theorem parents52_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state52_2 ["SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-PHASE-ORDER-001"] = .ok state52_7 := rfl
theorem parents52_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state52_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-PHASE-ORDER-001"] = .ok state52_7 := rfl
theorem parents52_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state52_0 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-PHASE-ORDER-001"] = .ok state52_7 := by
 change (reachesOne sourceDictionary534 534 memoNode1032 "SFT-MATH-GRAPH-NETWORK-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-PHASE-ORDER-001"]) = _
 rewrite [rootCall51]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state52_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-PHASE-ORDER-001"] = _
 exact parents52_1
theorem rootCall52 : reachesOne sourceDictionary534 535 memoNode1032 "SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001" = .ok result52 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state52_0 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-PHASE-ORDER-001"]; pure (result.1,put result.2 "SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001" result.1)) = _
 rewrite [parents52_0]
 rfl
#print axioms rootCall52
end SFT.Physics.GrandLockRootTrace
