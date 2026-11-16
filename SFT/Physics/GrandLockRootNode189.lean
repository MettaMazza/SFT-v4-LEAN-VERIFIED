import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents189_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state189_7 [] = .ok state189_7 := rfl
theorem parents189_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state189_6 ["SFT-PHYS-FLUID-INVISCID-001"] = .ok state189_7 := rfl
theorem parents189_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state189_5 ["SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-INVISCID-001"] = .ok state189_7 := rfl
theorem parents189_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state189_4 ["SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-INVISCID-001"] = .ok state189_7 := rfl
theorem parents189_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state189_3 ["SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-INVISCID-001"] = .ok state189_7 := rfl
theorem parents189_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state189_2 ["SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-INVISCID-001"] = .ok state189_7 := rfl
theorem parents189_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state189_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-INVISCID-001"] = .ok state189_7 := rfl
theorem parents189_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state189_0 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-INVISCID-001"] = .ok state189_7 := by
 change (reachesOne sourceDictionary534 534 memoNode3393 "SFT-MATH-GRAPH-NETWORK-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-INVISCID-001"]) = _
 rewrite [rootCall188]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state189_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-INVISCID-001"] = _
 exact parents189_1
theorem rootCall189 : reachesOne sourceDictionary534 535 memoNode3393 "SFT-PHYS-FLUID-VISCOSITY-001" = .ok result189 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state189_0 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-FIELD-CONSERVED-SOURCE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-THERMO-PHASE-EQUILIBRIUM-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-FLUID-INVISCID-001"]; pure (result.1,put result.2 "SFT-PHYS-FLUID-VISCOSITY-001" result.1)) = _
 rewrite [parents189_0]
 rfl
#print axioms rootCall189
end SFT.Physics.GrandLockRootTrace
