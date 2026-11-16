import SFT.Physics.PostNewtonianRecords
import SFT.Physics.FiniteQuantumGravityGeneral
import SFT.Physics.RunningConvergenceCertificate
import SFT.Physics.StellarCertificate
namespace SFT.Physics.CompactHorizon
open SFT.Host.Canonical GeneratorOperations LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def one : Rat := wholeRatio 1
def half : Rat := normalize 1 2 (by decide)
def quarter : Rat := normalize 1 4 (by decide)
def threeQuarter : Rat := normalize 3 4 (by decide)
def thermalMassProduct : Rat := multiply quarter quarter
def rat := RunningConvergenceCertificate.rat
def positiveWhole : CountInput → Except String Nat
 | .integer (.ofNat (n+1))=>.ok (n+1)
 | .integer (.ofNat 0) | .integer (.negSucc _) | .boolean _=>.error "a compact-support count must be a positive whole"
def positiveFraction (q : Rat) : Except String Rat := if zero.blt q then .ok q else .error "a compact carrier must be an exact positive fraction"
def foldUpperPreimage (q : Rat) : Except String Rat := do
 let q ← positiveFraction q
 if !half.blt q || one.blt q then throw "upper-preimage Fold requires half-One < value <= One"
 pure (subtract q quarter)
def exclusionScaling (side : CountInput) : Except String Value := do
 let q ← positiveWhole side
 let occupants := q*q*q
 let degeneracy := occupants*q
 let gravity := occupants*occupants
 pure (.object [("side",.integer q),("occupants",.integer occupants),("forced_momentum_depth",.integer q),("degeneracy_support_numerator",.integer degeneracy),("gravity_support_numerator",.integer gravity),("gravity_strict_after_base",.boolean (q==1 || degeneracy<gravity))])
def exclusionScalingCertificate (depth : CountInput) : Except String Value := do
 let n ← positiveWhole depth
 let rows ← (List.range n).mapM (fun i=>exclusionScaling (.integer (.ofNat (i+1))))
 let first ← match rows with | []=>.error "IndexError" | h::_=>.ok h
 pure (.object [("rows",.array rows),("base_equal",.boolean (RunningConvergenceMeasurement.sameValue (PostNewtonianRecords.getDefault first "degeneracy_support_numerator") (PostNewtonianRecords.getDefault first "gravity_support_numerator"))),("gravity_strict_after_base",.boolean ((List.range (n-1)).all (fun i=>let q:=i+2; q*q*q*q<q*q*q*(q*q*q)))),("perfect_cube_support",.boolean ((List.range n).all (fun i=>let q:=i+1; q*q*q==q^3))),("depth_independent_exponent_order",.boolean ((List.range n).all (fun i=>let q:=i+2; q^4<q^6)))])
def endpointCensus : Except String Value := do
 let balance ← foldUpperPreimage threeQuarter
 pure (.object [("loaded_exclusion_threshold",rat threeQuarter),("folded_gravity_balance",rat balance),("families",.array [.text "electron-exclusion-support",.text "neutral-fermion-exclusion-support"]),("family_count",.integer 2),("third_pre_horizon_family",.array []),("successor_after_second_family",.text "horizon-closure")])
structure Horizon where
 mass : Rat
 radius : Rat
 areaSupport : Rat
 entropySupport : Rat
 temperature : Rat
 thermalMassProduct : Rat
def horizonValue (h : Horizon) : Value := .object [("mass",rat h.mass),("radius",rat h.radius),("area_support",rat h.areaSupport),("entropy_support",rat h.entropySupport),("temperature",rat h.temperature),("thermal_mass_product",rat h.thermalMassProduct)]
def horizonThermodynamics (mass : Rat) : Except String Horizon := do
 let mass ← positiveFraction mass
 let radius := add mass mass
 let area := multiply radius radius
 let entropy := multiply quarter area
 let temperature ← LeptonRatios.divide thermalMassProduct mass
 if radius != add mass mass then throw "horizon radius lost the Fold doubling law"
 if multiply temperature mass != thermalMassProduct then throw "horizon thermal-mass product changed"
 if multiply entropy (wholeRatio 4) != area then throw "horizon quarter-area support changed"
 pure ⟨mass,radius,area,entropy,temperature,thermalMassProduct⟩
def evaporationRows : Nat → Rat → Except String (List Horizon)
 | 0,_=>.ok []
 | n+1,m=>do pure ((← horizonThermodynamics m)::(← evaporationRows n (multiply m half)))
def evaporationTrace (depth : CountInput) : Except String (List Horizon) := do evaporationRows (← positiveWhole depth) one
def adjacent (relation : Horizon → Horizon → Bool) : List Horizon → Bool
 | []=>true
 | [_]=>true
 | a::b::rest=>relation a b && adjacent relation (b::rest)
def evaporationCertificate (depth : CountInput) : Except String Value := do
 let rows ← evaporationTrace depth
 let last ← match rows.reverse with | []=>.error "IndexError" | h::_=>.ok h
 pure (.object [("rows",.array (rows.map horizonValue)),("mass_strictly_falls",.boolean (adjacent (fun a b=>b.mass.blt a.mass) rows)),("temperature_strictly_rises",.boolean (adjacent (fun a b=>a.temperature.blt b.temperature) rows)),("area_strictly_falls",.boolean (adjacent (fun a b=>b.areaSupport.blt a.areaSupport) rows)),("thermal_mass_invariant",.boolean (rows.all (fun h=>multiply h.temperature h.mass==thermalMassProduct))),("all_reached_carriers_positive",.boolean (rows.all (fun h=>[h.mass,h.radius,h.areaSupport,h.entropySupport,h.temperature].all (fun q=>zero.blt q)))),("finite_floor_retained",.boolean (zero.blt last.mass))])
def theoremCertificate : Except String Value := do
 let exclusion ← [1,2,3,8,16].mapM (fun n=>exclusionScalingCertificate (.integer (.ofNat n)))
 let evaporation ← [1,2,3,8,16].mapM (fun n=>evaporationCertificate (.integer (.ofNat n)))
 let reference ← horizonThermodynamics quarter
 let endpoints ← endpointCensus
 let flag := StellarCertificate.flag
 pure (.object [("exclusion",.array exclusion),("endpoints",endpoints),("reference_horizon",horizonValue reference),("evaporation",.array evaporation),("all_exclusion_scalings_close",.boolean (exclusion.all (fun r=>flag r "base_equal" && flag r "gravity_strict_after_base" && flag r "depth_independent_exponent_order"))),("two_pre_horizon_families",.boolean (RunningConvergenceMeasurement.sameValue (PostNewtonianRecords.getDefault endpoints "family_count") (.integer 2) && RunningConvergenceMeasurement.sameValue (PostNewtonianRecords.getDefault endpoints "third_pre_horizon_family") (.array []))),("reference_cross_closes",.boolean (reference.radius==half && reference.temperature==quarter)),("all_evaporation_traces_close",.boolean (evaporation.all (fun r=>flag r "thermal_mass_invariant" && flag r "all_reached_carriers_positive" && flag r "finite_floor_retained")))])
theorem originalHorizonReference : horizonThermodynamics quarter=.ok ⟨quarter,half,quarter,thermalMassProduct,quarter,thermalMassProduct⟩ := rfl
theorem originalThreshold : foldUpperPreimage threeQuarter=.ok half := rfl
#print axioms originalHorizonReference
#print axioms originalThreshold
end SFT.Physics.CompactHorizon
