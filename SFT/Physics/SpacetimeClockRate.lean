import SFT.Physics.SpacetimeLimitSpeed
namespace SFT.Physics.SpacetimeClockRate
open SFT.Foundation.ExactOperations SFT.Mathematics.ExactRatioRelations
open MechanicalEvents MechanicalDuration

-- CLOCK_RATE retains two complete positive causal paths with common endpoints.
structure SharedPaths (State : Type) (adjacent : Event State → Event State → Prop)
 (first last : Event State) where
 left : FieldLocality.Propagation adjacent first last
 right : FieldLocality.Propagation adjacent first last
 leftPresent : 0 < count (FieldLocality.trace left)
 rightPresent : 0 < count (FieldLocality.trace right)

variable {State : Type} {adjacent : Event State → Event State → Prop} {a b : Event State}

def relative (paths : SharedPaths State adjacent a b) : PositiveFraction :=
 ratio (count (FieldLocality.trace paths.left)) (count (FieldLocality.trace paths.right))
  paths.leftPresent paths.rightPresent

theorem exactCountCorrespondence (paths : SharedPaths State adjacent a b) :
 count (FieldLocality.trace paths.left) * (relative paths).denominator =
 (relative paths).numerator * count (FieldLocality.trace paths.right) :=
 ratioValue _ _ _ _

theorem positiveClockRate (paths : SharedPaths State adjacent a b) :
 0 < (relative paths).numerator := (relative paths).positive

def reverse (paths : SharedPaths State adjacent a b) : SharedPaths State adjacent a b :=
 ⟨paths.right,paths.left,paths.rightPresent,paths.leftPresent⟩

theorem reverseRestoresPaths (paths : SharedPaths State adjacent a b) :
 reverse (reverse paths)=paths := rfl

theorem reverseRatioExact (paths : SharedPaths State adjacent a b) :
 count (FieldLocality.trace paths.right) * (relative (reverse paths)).denominator =
 (relative (reverse paths)).numerator * count (FieldLocality.trace paths.left) :=
 exactCountCorrespondence (reverse paths)

-- Reference naming cannot change the complete generated paths or their counts.
theorem inertialNamingPreservesRate {A B : Type}
 (first : SpacetimeInertial.Frame (SharedPaths State adjacent a b) A)
 (second : SpacetimeInertial.Frame (SharedPaths State adjacent a b) B) (label : A) :
 relative (second.read (SpacetimeInertial.correspondence first second label)) = relative (first.read label) :=
 congrArg relative (SpacetimeInertial.completeRecordPreserved first second label)

-- Any candidate ratio reproducing the same two retained counts has the same
-- exact value. This excludes an independently selected rate coefficient.
theorem countRatioUnique (paths : SharedPaths State adjacent a b) (q : PositiveFraction)
 (exactCounts : count (FieldLocality.trace paths.left)*q.denominator =
   q.numerator*count (FieldLocality.trace paths.right)) :
 q.numerator*(relative paths).denominator = (relative paths).numerator*q.denominator := by
 let n := count (FieldLocality.trace paths.left)
 let m := count (FieldLocality.trace paths.right)
 let r := relative paths
 have hc : n*r.denominator=r.numerator*m := exactCountCorrespondence paths
 apply cancelPositive m _ _ paths.rightPresent
 calc
  m*(q.numerator*r.denominator) = (q.numerator*m)*r.denominator := by
   rw [← SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm m q.numerator]
  _ = (n*q.denominator)*r.denominator := congrArg (fun z => z*r.denominator) exactCounts.symm
  _ = (n*r.denominator)*q.denominator := by
   rw [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm q.denominator r.denominator,← SFT.Foundation.FractionReduction.mulAssoc]
  _ = (r.numerator*m)*q.denominator := congrArg (fun z => z*q.denominator) hc
  _ = m*(r.numerator*q.denominator) := by
   rw [Nat.mul_comm r.numerator m,SFT.Foundation.FractionReduction.mulAssoc]

theorem intermediateClockTelescopes (n m k : Nat) (hn : 0<n) (hm : 0<m) (hk : 0<k) :
 (compose (ratio n m hn hm) (ratio m k hm hk)).numerator*k =
 n*(compose (ratio n m hn hm) (ratio m k hm hk)).denominator :=
 telescopeNormalized n m k hn hm hk

end SFT.Physics.SpacetimeClockRate
