import SFT.Physics.PostNewtonianExperiment
import SFT.Physics.DeuteronMeasurement
namespace SFT.Physics.PostNewtonianMeasurement
open SFT.Host SFT.Host.Canonical LeptonIntervals PostNewtonianFixedPoint PostNewtonianFixedPointCertificate RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def historicalFraction : Value → Except String Rat
 | .text s => DeuteronMeasurement.fraction s
 | .integer n => .ok (normalize n 1 (by decide))
 | .boolean b => .ok (normalize (if b then 1 else 0) 1 (by decide))
 | .null | .array _ | .object _ => .error "TypeError"
structure Analysis where
 structural : Structural
 admissible : List Rat
 iteration : List Rat
 errors : List Rat
 corrections : List Rat
 errorFactors : List Rat
 correctionFactors : List Rat
 errorsShrink : Bool
 correctionsShrink : Bool
 factorsBelowQuarter : Bool
 historicalCorrections : List Rat
 historicalShrink : Bool
 mapRowsMatch : Bool
 externalRows : List Value
 universalNotClaimed : Bool
 allTargetRowsRetained : Bool
 fittedValueUsed : Bool
def exactMeasurementAnalysis (target : Value) : Except String Analysis := do
 let c ← convergenceCertificate (.integer 10)
 let old ← (← array (← field target "v1_corrections")).mapM historicalFraction
 let v ← structuralValues
 let external ← ["external_scheme","external_nonlinearity","external_1PN_scalar_structure","external_domain","external_formal_order"].mapM (field target)
 let retained ← match target with
  | .object fields => .ok fields.length
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "TypeError"
 pure ⟨v,← admissibleFixedPoints,← iterate (.integer 10),c.errors,c.corrections,c.errorFactors,c.correctionFactors,
  c.errorsStrictlyShrink,c.correctionsStrictlyShrink,c.allFactorsBelowQuarter,old,
  (successors old).all (fun pair => pair.2.blt pair.1),
  sameValue (← field target "v2_matter_source") (.text "7/16") && sameValue (← field target "v2_coupling") (.text "1/2") && sameValue (← field target "v2_fixed_point") (.text "1/4"),
  external,sameValue (← field target "external_universal_numeric_convergence_claimed") (.boolean false),retained==15,false⟩
def analysisValue (a : Analysis) : Value :=
 let rs := fun xs : List Rat => Value.array (xs.map PostNewtonianFixedPointEvidence.frac)
 .object [("structural_values",PostNewtonianFixedPointEvidence.structuralValue a.structural),("admissible_fixed_points",rs a.admissible),("iteration",rs a.iteration),("errors",rs a.errors),("corrections",rs a.corrections),("error_factors",rs a.errorFactors),("correction_factors",rs a.correctionFactors),("errors_strictly_shrink",.boolean a.errorsShrink),("corrections_strictly_shrink",.boolean a.correctionsShrink),("all_factors_below_quarter",.boolean a.factorsBelowQuarter),("v1_corrections",rs a.historicalCorrections),("v1_corrections_strictly_shrink",.boolean a.historicalShrink),("v2_map_rows_match",.boolean a.mapRowsMatch),("external_rows_retained",.array a.externalRows),("external_universal_numeric_convergence_not_claimed",.boolean a.universalNotClaimed),("all_target_rows_retained",.boolean a.allTargetRowsRetained),("fitted_value_used",.boolean a.fittedValueUsed)]
end SFT.Physics.PostNewtonianMeasurement
