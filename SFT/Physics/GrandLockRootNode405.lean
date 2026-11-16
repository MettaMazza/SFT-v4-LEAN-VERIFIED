import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents405_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state405_7 [] = .ok state405_7 := rfl
theorem parents405_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state405_6 ["SFT-PHYS-FLUID-TURBULENCE-001"] = .ok state405_7 := rfl
theorem parents405_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state405_5 ["SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-TURBULENCE-001"] = .ok state405_7 := rfl
theorem parents405_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state405_4 ["SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-TURBULENCE-001"] = .ok state405_7 := rfl
theorem parents405_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state405_3 ["SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-TURBULENCE-001"] = .ok state405_7 := rfl
theorem parents405_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state405_2 ["SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-TURBULENCE-001"] = .ok state405_7 := rfl
theorem parents405_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state405_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-TURBULENCE-001"] = .ok state405_7 := rfl
theorem parents405_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state405_0 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-TURBULENCE-001"] = .ok state405_7 := by
 change (reachesOne sourceDictionary534 534 memoNode6448 "SFT-MATH-GRAPH-NETWORK-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-TURBULENCE-001"]) = _
 rewrite [rootCall404]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state405_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-TURBULENCE-001"] = _
 exact parents405_1
theorem rootCall405 : reachesOne sourceDictionary534 535 memoNode6448 "SFT-PHYS-PLASMA-COLLECTIVE-001" = .ok result405 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state405_0 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-TURBULENCE-001"]; pure (result.1,put result.2 "SFT-PHYS-PLASMA-COLLECTIVE-001" result.1)) = _
 rewrite [parents405_0]
 rfl
#print axioms rootCall405
end SFT.Physics.GrandLockRootTrace
