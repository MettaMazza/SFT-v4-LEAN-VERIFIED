import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents187_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state187_7 [] = .ok state187_7 := rfl
theorem parents187_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state187_6 ["SFT-PHYS-FLUID-VISCOSITY-001"] = .ok state187_7 := rfl
theorem parents187_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state187_5 ["SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-VISCOSITY-001"] = .ok state187_7 := rfl
theorem parents187_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state187_4 ["SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-VISCOSITY-001"] = .ok state187_7 := rfl
theorem parents187_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state187_3 ["SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-VISCOSITY-001"] = .ok state187_7 := rfl
theorem parents187_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state187_2 ["SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-VISCOSITY-001"] = .ok state187_7 := rfl
theorem parents187_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state187_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-VISCOSITY-001"] = .ok state187_7 := rfl
theorem parents187_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state187_0 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-VISCOSITY-001"] = .ok state187_7 := by
 change (reachesOne sourceDictionary534 534 memoNode3373 "SFT-MATH-GRAPH-NETWORK-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-VISCOSITY-001"]) = _
 rewrite [rootCall186]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state187_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-VISCOSITY-001"] = _
 exact parents187_1
theorem rootCall187 : reachesOne sourceDictionary534 535 memoNode3373 "SFT-PHYS-FLUID-TURBULENCE-001" = .ok result187 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state187_0 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-VISCOSITY-001"]; pure (result.1,put result.2 "SFT-PHYS-FLUID-TURBULENCE-001" result.1)) = _
 rewrite [parents187_0]
 rfl
#print axioms rootCall187
end SFT.Physics.GrandLockRootTrace
