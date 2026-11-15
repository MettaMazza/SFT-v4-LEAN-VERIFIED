import SFT.Physics.OrbitalDimensionStability
namespace SFT.Physics.OrbitalDimensionStabilityCertificate
open OrbitalDimensionStability BoundaryGrowth SFT.Foundation.ExactOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure DimensionRow where
 dimension : Nat
 classes : List String
 magnitudes : List (PositiveFraction × PositiveFraction)
structure Certificate where
 rows : List DimensionRow
 stableDimensions : List Nat
 marginalDimensions : List Nat
 unstableDimensions : List Nat
 generalPartition : String
 proof : String
 negativeExponentRequired : Bool
def ratios : List PositiveFraction := [normalizePositive 3 2 (by decide) (by decide),normalizePositive 2 1 (by decide) (by decide),normalizePositive 5 2 (by decide) (by decide)]
def dimensionRow (d : Nat) : Except String DimensionRow := do
 let input := GeneratorOperations.CountInput.integer (.ofNat d)
 pure ⟨d,← ratios.mapM (fun q => orbitalStabilityClass input (.fraction (asFraction q))),← ratios.mapM (fun q => displacedMagnitudes input (.fraction (asFraction q)))⟩
def classesExactly (row : DimensionRow) (label : String) : Bool :=
 !row.classes.isEmpty && row.classes.all (fun x => SFT.Host.Text.equal x label)
def dimensionCertificate : Except String Certificate := do
 let rows ← ((List.range 11).map (fun n => n+2)).mapM dimensionRow
 pure ⟨rows,
  (rows.filter (fun row => classesExactly row "stable-restoring")).map DimensionRow.dimension,
  (rows.filter (fun row => classesExactly row "marginal")).map DimensionRow.dimension,
  (rows.filter (fun row => classesExactly row "unstable-nonrestoring")).map DimensionRow.dimension,
  "stable for every d below four; marginal at four; unstable for every d above four",
  "for q>One, compare positive denominators q^(d-1) and q^3; their order is fixed solely by d-1 against three",false⟩
def certificateFacts : Except String Bool := do
 let c ← dimensionCertificate
 pure (c.stableDimensions==[2,3] && c.marginalDimensions==[4] && c.unstableDimensions==[5,6,7,8,9,10,11,12] && !c.negativeExponentRequired)
theorem originalComputedFacts : certificateFacts=.ok true := rfl
end SFT.Physics.OrbitalDimensionStabilityCertificate
