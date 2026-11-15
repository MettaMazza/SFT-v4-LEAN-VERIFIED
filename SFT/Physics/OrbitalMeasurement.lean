import SFT.Physics.OrbitalExperiment
namespace SFT.Physics.OrbitalMeasurement
open SFT.Host SFT.Host.Canonical OrbitalDimensionStabilityCertificate RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def targetWhole : Value → Except String Int
 | .integer n => .ok n
 | .boolean false => .ok 0
 | .boolean true => .ok 1
 | .text s => match LeptonDecimal.exponent (Text.chars s) with | some n => .ok n | none => .error "ValueError"
 | .null | .array _ | .object _ => .error "TypeError"
structure Analysis where
 ratios : List SFT.Foundation.ExactOperations.PositiveFraction
 rows : List DimensionRow
 stableDimensions : List Nat
 marginalDimensions : List Nat
 unstableDimensions : List Nat
 externalStableMatch : Bool
 externalMarginalMatch : Bool
 unstableFamilyMatch : Bool
 allTargetRowsRetained : Bool
 negativeOrFittedProofValue : Bool
def exactMeasurementAnalysis (target : Value) : Except String Analysis := do
 let rows ← ((List.range 11).map (fun n => n+2)).mapM dimensionRow
 let stable := (rows.filter (fun row => classesExactly row "stable-restoring")).map DimensionRow.dimension
 let marginal := (rows.filter (fun row => classesExactly row "marginal")).map DimensionRow.dimension
 let unstable := (rows.filter (fun row => classesExactly row "unstable-nonrestoring")).map DimensionRow.dimension
 let externalStable ← (← array (← field target "stable_dimensions")).mapM targetWhole
 let externalMarginal ← targetWhole (← field target "marginal_dimension")
 let retained ← match target with
  | .object fields => .ok fields.length
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "TypeError"
 pure ⟨ratios,rows,stable,marginal,unstable,
  decide (stable.map Int.ofNat=externalStable),decide (marginal.map Int.ofNat=[externalMarginal]),
  unstable==[5,6,7,8,9,10,11,12] && sameValue (← field target "unstable_dimension_family") (.text "every-positive-whole-N-at-least-five"),
  retained==14,false⟩
def analysisValue (a : Analysis) : Value :=
 let ns := fun xs : List Nat => Value.array (xs.map OrbitalDimensionStabilityEvidence.nv)
 .object [("ratios",.array (a.ratios.map OrbitalDimensionStabilityEvidence.frac)),("rows",.array (a.rows.map OrbitalDimensionStabilityEvidence.rowValue)),("stable_dimensions",ns a.stableDimensions),("marginal_dimensions",ns a.marginalDimensions),("unstable_dimensions",ns a.unstableDimensions),("external_stable_match",.boolean a.externalStableMatch),("external_marginal_match",.boolean a.externalMarginalMatch),("unstable_family_match",.boolean a.unstableFamilyMatch),("all_target_rows_retained",.boolean a.allTargetRowsRetained),("negative_or_fitted_proof_value",.boolean a.negativeOrFittedProofValue)]
end SFT.Physics.OrbitalMeasurement
