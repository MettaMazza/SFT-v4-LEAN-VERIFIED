import SFT.Physics.CosmicMeasuredMeasurement
import SFT.Physics.CriticalityUniversality
namespace SFT.Physics.CriticalMeasuredAnalysis
open LeptonIntervals VacuumLedgerProofs SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Material where
 sample : String
 betaCenter : Rat
 betaWidth : Rat
 gammaCenter : Rat
 gammaWidth : Rat
 deltaCenter : Rat
 deltaWidth : Rat
structure Target where
 rows : List Material
 sampleIds : List String
 structuralTrueCount : Nat
 la02Retained : Bool
 erbiumBeta : Rat × Rat
 erbiumGamma : Rat × Rat
 erbiumNu : Rat × Rat
 turbulence : Rat × Rat
 spectrumCompensation : Bool
 fourier : Bool
 hilbert : Bool
 finiteReynolds : Bool
 structureRange : Bool
 thresholdBoundary : Bool
 originalRows : Bool
 allManganite : Bool
 allRegistered : Bool

def exactInterval (center width : Rat) : Except String (Rat × Rat) :=
 if !width.blt center || !zero.blt width then .error "criticality interval must remain positive"
 else .ok (subtract center width,add center width)

def residual (center width forced : Rat) : Except String Rat :=
 let delta := subtract center forced
 LeptonRatios.divide (multiply delta delta) (multiply width width)

def material (row : Material) : Except String (Value × Rat) := do
 let v := CriticalityUniversality.meanFieldExponents
 let b ← residual row.betaCenter row.betaWidth v.beta
 let g ← residual row.gammaCenter row.gammaWidth v.gamma
 let d ← residual row.deltaCenter row.deltaWidth v.delta
 let rat := RunningConvergenceCertificate.rat
 let bounds := fun c u => CosmicMeasuredMeasurement.pair (subtract c u,add c u)
 .ok (.object [("sample",.text row.sample),
  ("residuals",.object [("beta",rat b),("gamma",rat g),("delta",rat d)]),
  ("intervals",.object [("beta",bounds row.betaCenter row.betaWidth),("gamma",bounds row.gammaCenter row.gammaWidth),("delta",bounds row.deltaCenter row.deltaWidth)]),
  ("complete_key",.boolean true)],add (add b g) d)

def exactAnalysis (target : Target) : Except String Value := do
 let rows ← target.rows.mapM material
 let total := rows.foldl (fun sum row => add sum row.2) zero
 let mean ← LeptonRatios.divide total (wholeRatio (rows.length*3))
 let eb ← exactInterval target.erbiumBeta.1 target.erbiumBeta.2
 let eg ← exactInterval target.erbiumGamma.1 target.erbiumGamma.2
 let en ← exactInterval target.erbiumNu.1 target.erbiumNu.2
 let turbulence ← exactInterval target.turbulence.1 target.turbulence.2
 let v := CriticalityUniversality.meanFieldExponents
 let within := CosmicComponentTransportMeasurement.within
 let pair := CosmicMeasuredMeasurement.pair
 .ok (.object [
 ("material_rows",.array (rows.map Prod.fst)),
 ("complete_fifteen_value_mean_squared_residual",RunningConvergenceCertificate.rat mean),
 ("erbium_intervals",.object [("beta",pair eb),("gamma",pair eg),("nu",pair en)]),
 ("turbulence_interval",pair turbulence),
 ("all_five_material_keys_complete",.boolean (target.rows.map Material.sample == target.sampleIds && target.structuralTrueCount==5)),
 ("complete_manganite_residual_below_One",.boolean (mean.blt (wholeRatio 1))),
 ("complete_residual_exact_value",.boolean (mean == normalize 5286961 10584000 (by decide))),
 ("La02_retained_without_mismatch_reward",.boolean (target.rows.any (fun row => row.sample=="La02") && target.la02Retained)),
 ("erbium_vector_passed",.boolean (within eb v.beta && within eg v.gamma && within en v.nu)),
 ("turbulence_structure_passed",.boolean (within turbulence CriticalityUniversality.cascadeExponents.structureFunction)),
 ("both_spectrum_routes_passed",.boolean (target.spectrumCompensation && target.fourier && target.hilbert)),
 ("limitations_retained",.boolean (target.finiteReynolds && target.structureRange && target.thresholdBoundary)),
 ("all_source_rows_retained",.boolean (target.originalRows && target.allManganite && target.allRegistered))])
end SFT.Physics.CriticalMeasuredAnalysis
