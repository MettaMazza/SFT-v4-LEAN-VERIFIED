import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents54_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state54_7 [] = .ok state54_7 := rfl
theorem parents54_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state54_6 ["SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001"] = .ok state54_7 := rfl
theorem parents54_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state54_5 ["SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001"] = .ok state54_7 := rfl
theorem parents54_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state54_4 ["SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001"] = .ok state54_7 := rfl
theorem parents54_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state54_3 ["SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001"] = .ok state54_7 := rfl
theorem parents54_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state54_2 ["SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001"] = .ok state54_7 := rfl
theorem parents54_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state54_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001"] = .ok state54_7 := rfl
theorem parents54_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state54_0 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001"] = .ok state54_7 := by
 change (reachesOne sourceDictionary534 534 memoNode1065 "SFT-MATH-GRAPH-NETWORK-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001"]) = _
 rewrite [rootCall53]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state54_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001"] = _
 exact parents54_1
theorem rootCall54 : reachesOne sourceDictionary534 535 memoNode1065 "SFT-PHYS-CONDENSED-TOPOLOGICAL-001" = .ok result54 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state54_0 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-CONDENSED-SUPERCONDUCTIVITY-001"]; pure (result.1,put result.2 "SFT-PHYS-CONDENSED-TOPOLOGICAL-001" result.1)) = _
 rewrite [parents54_0]
 rfl
#print axioms rootCall54
end SFT.Physics.GrandLockRootTrace
