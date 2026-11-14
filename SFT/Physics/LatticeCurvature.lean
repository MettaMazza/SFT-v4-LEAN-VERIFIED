import SFT.Physics.RedshiftEquivalence
import SFT.Physics.SpatialStability
import SFT.Physics.CommonScaleAxisAlgebra
namespace SFT.Physics.LatticeCurvature
open SFT.Foundation ExactOperations ExactPartCarrier GeneratorOperations
open LeptonIntervals VacuumLedgerProofs

def squareLatticeCurvature : FoldFirstReturn.Input → FoldFirstReturn.Input → Except String Rat
 | .nonFraction,_ | _,.nonFraction => .error "lattice curvature requires exact fractions"
 | .fraction position,.fraction spacing => do
  if !(zero.blt spacing && spacing.blt position) then
   throw "curvature witness requires positive predecessor support"
  let forwardPosition := add position spacing
  let forward := multiply forwardPosition forwardPosition
  let backwardPosition := subtract position spacing
  let backward := multiply backwardPosition backwardPosition
  let binary ← AlphaCovers.binaryCount
  let middle := multiply (multiply (wholeRatio binary) position) position
  let numerator ← GravityFlux.positiveTake (.fraction (add forward backward)) (.fraction middle)
  match numerator with
  | none => .error "quadratic curvature cannot be empty"
  | some numerator => LeptonRatios.divide numerator (multiply spacing spacing)

def appendAxes (perAxis : Rat) : Nat → Rat → Rat
 | 0,result => result
 | n+1,result => appendAxes perAxis n (add result perAxis)

def latticeLaplacian (input : CountInput) (spacing : FoldFirstReturn.Input) : Except String Int := do
 let dimensionLimit ← SpatialStability.spatialDimension
 let dimension ← match input with
  | .boolean true => .ok 1
  | .boolean false => .error "dimension lies outside generated three-space"
  | .integer (.negSucc _) => .error "dimension lies outside generated three-space"
  | .integer (.ofNat n) =>
    if 0<n && n≤dimensionLimit then .ok n
    else .error "dimension lies outside generated three-space"
 let perAxis ← squareLatticeCurvature (.fraction ⟨1,2,by decide,by decide⟩) spacing
 let result := appendAxes perAxis (dimension-1) perAxis
 if result.den==1 then .ok result.num
 else .error "lattice Laplacian failed whole-count closure"

theorem eighthSpacing : squareLatticeCurvature (.fraction ⟨1,2,by decide,by decide⟩) (.fraction ⟨1,8,by decide,by decide⟩)=.ok ⟨2,1,by decide,by decide⟩ := by
 unfold squareLatticeCurvature
 rw [AlphaCovers.binaryCountTwo]
 rfl

theorem sixteenthSpacing : squareLatticeCurvature (.fraction ⟨1,2,by decide,by decide⟩) (.fraction ⟨1,16,by decide,by decide⟩)=.ok ⟨2,1,by decide,by decide⟩ := by
 unfold squareLatticeCurvature
 rw [AlphaCovers.binaryCountTwo]
 rfl

theorem originalFamily :
 (latticeLaplacian (.integer 1) (.fraction ⟨1,8,by decide,by decide⟩),
  latticeLaplacian (.integer 2) (.fraction ⟨1,8,by decide,by decide⟩),
  latticeLaplacian (.integer 3) (.fraction ⟨1,8,by decide,by decide⟩))=(.ok 2,.ok 4,.ok 6) := by
 unfold latticeLaplacian
 rw [SpatialStability.spatialDimensionThree]
 dsimp only
 rw [eighthSpacing]
 rfl
end SFT.Physics.LatticeCurvature
