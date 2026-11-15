import SFT.Physics.InverseSquare
import SFT.Physics.LeptonTerminal
namespace SFT.Physics.OrbitalDimensionStability
open SFT.Foundation.ExactOperations GeneratorOperations BoundaryGrowth FoldFirstReturn
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def spatialDimension : CountInput → Except String Nat
 | .integer (.ofNat (n+2)) => .ok (n+2)
 | .integer (.ofNat 0) | .integer (.ofNat 1) | .integer (.negSucc _) | .boolean _ => .error "orbital dimension must be a positive whole of at least two"
def outwardRatio : Input → Except String PositiveFraction
 | .nonFraction => .error "outward radius ratio must exceed the One"
 | .fraction value => match admitPositive value with
  | none => .error "outward radius ratio must exceed the One"
  | some positive => if positive.denominator<positive.numerator then .ok positive else .error "outward radius ratio must exceed the One"
def displacedMagnitudes (dimension : CountInput) (ratio : Input) : Except String (PositiveFraction × PositiveFraction) := do
 let d ← spatialDimension dimension
 let q ← outwardRatio ratio
 pure (LeptonInvariants.reciprocal (LeptonTerminal.positivePower q (d-1)),LeptonInvariants.reciprocal (LeptonTerminal.positivePower q 3))
def orbitalStabilityClass (dimension : CountInput) (ratio : Input) : Except String String := do
 let (gravity,centrifugal) ← displacedMagnitudes dimension ratio
 let left := gravity.numerator*centrifugal.denominator
 let right := centrifugal.numerator*gravity.denominator
 if left==right then pure "marginal"
 else pure (if right<left then "stable-restoring" else "unstable-nonrestoring")
theorem originalOutwardAdmitted (ratio : PositiveFraction) (above : ratio.denominator<ratio.numerator) :
 outwardRatio (.fraction (asFraction ratio))=.ok ratio := by
 unfold outwardRatio
 dsimp only
 rw [positiveRoundTrip]
 exact if_pos above
theorem originalMagnitudes (d : Nat) (ratio : PositiveFraction) (above : ratio.denominator<ratio.numerator) :
 displacedMagnitudes (.integer (.ofNat (d+2))) (.fraction (asFraction ratio))=
 .ok (LeptonInvariants.reciprocal (LeptonTerminal.positivePower ratio (d+1)),LeptonInvariants.reciprocal (LeptonTerminal.positivePower ratio 3)) := by
 unfold displacedMagnitudes
 change (do let q ← outwardRatio (.fraction (asFraction ratio)); pure (_,_))=_
 rw [originalOutwardAdmitted ratio above]
 rfl
end SFT.Physics.OrbitalDimensionStability
