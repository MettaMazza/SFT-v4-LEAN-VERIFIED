import SFT.Mathematics.ExactRatioRelations
import SFT.Foundation.FoldCastLaws
namespace SFT.Mathematics.LocalSeparation
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
open SFT.Foundation.ExactCast SFT.Foundation.FoldCastLaws

/-- An ordered held pair after a common finite refinement. -/
structure HeldPair where
 lower : Nat
 upper : Nat
 denominator : Nat
 lowerPositive : 0 < lower
 separated : lower < upper
 withinWhole : upper ≤ denominator

def gap (p : HeldPair) : PositiveFraction :=
 normalizePositive (p.upper-p.lower) p.denominator
  (subtractPositive _ _ p.separated)
  (Nat.lt_of_lt_of_le (Nat.lt_trans p.lowerPositive p.separated) p.withinWhole)

theorem gapValue (p : HeldPair) :
 (p.upper-p.lower)*(gap p).denominator=(gap p).numerator*p.denominator :=
 normalizedValuePreserved _ _ _ _

theorem doubleDifference (upper lower : Nat) :
 (upper+upper)-(lower+lower)=(upper-lower)+(upper-lower) := by
 rw [← twoTimes upper,← twoTimes lower,mulSubtract,twoTimes]

def uncastTransport (p : HeldPair) : PositiveFraction :=
 normalizePositive ((p.upper+p.upper)-(p.lower+p.lower)) p.denominator
  (by rw [doubleDifference]; exact Nat.add_pos_left (subtractPositive _ _ p.separated) _)
  (Nat.lt_of_lt_of_le (Nat.lt_trans p.lowerPositive p.separated) p.withinWhole)

theorem localTransportExact (p : HeldPair) :
 uncastTransport p = normalizePositive ((p.upper-p.lower)+(p.upper-p.lower)) p.denominator
  (Nat.add_pos_left (subtractPositive _ _ p.separated) _)
  (Nat.lt_of_lt_of_le (Nat.lt_trans p.lowerPositive p.separated) p.withinWhole) := by
 exact positiveNormalizationCongr _ _ _ _ _ _ _ _ (doubleDifference p.upper p.lower) rfl

theorem transportValue (p : HeldPair) :
 ((p.upper-p.lower)+(p.upper-p.lower))*(uncastTransport p).denominator=
 (uncastTransport p).numerator*p.denominator := by
 rw [localTransportExact]
 exact normalizedValuePreserved _ _ _ _

theorem sharedRemoval (a b d : Nat) (ha : d ≤ a) (hb : d ≤ b) :
 (a-d)-(b-d)=a-b := by
 calc
  (a-d)-(b-d)=((a-d)+d)-((b-d)+d) := (addSubtractSame (a-d) (b-d) d).symm
  _ = a-b := by rw [subtractAdd a d ha,subtractAdd b d hb]

theorem upperBranchCast (n d : Nat) (hd : 0<d) (hn : n≤d) (upper : d<n+n) :
 castNumerator (n+n) d=(n+n)-d := by
 rw [castRemoves _ _ hd upper]
 apply castRetains _ _ hd
 have h := Nat.sub_le_sub_right (Nat.add_le_add hn hn) d
 rw [addSubtract] at h
 exact h

theorem lowerBranchGap (p : HeldPair) (branch : p.upper+p.upper ≤ p.denominator) :
 castNumerator (p.upper+p.upper) p.denominator-
 castNumerator (p.lower+p.lower) p.denominator=
 (p.upper-p.lower)+(p.upper-p.lower) := by
 have hd := Nat.lt_of_lt_of_le (Nat.lt_trans p.lowerPositive p.separated) p.withinWhole
 have lower := Nat.le_trans (Nat.add_le_add (Nat.le_of_lt p.separated) (Nat.le_of_lt p.separated)) branch
 rw [castRetains _ _ hd branch,castRetains _ _ hd lower]
 exact doubleDifference _ _

theorem upperBranchGap (p : HeldPair) (branch : p.denominator<p.lower+p.lower) :
 castNumerator (p.upper+p.upper) p.denominator-
 castNumerator (p.lower+p.lower) p.denominator=
 (p.upper-p.lower)+(p.upper-p.lower) := by
 have hd := Nat.lt_of_lt_of_le (Nat.lt_trans p.lowerPositive p.separated) p.withinWhole
 have upper := Nat.lt_of_lt_of_le branch (Nat.add_le_add (Nat.le_of_lt p.separated) (Nat.le_of_lt p.separated))
 rw [upperBranchCast _ _ hd p.withinWhole upper,
   upperBranchCast _ _ hd (Nat.le_trans (Nat.le_of_lt p.separated) p.withinWhole) branch,
   sharedRemoval _ _ _ (Nat.le_of_lt upper) (Nat.le_of_lt branch)]
 exact doubleDifference _ _

#print axioms sharedRemoval
#print axioms upperBranchCast
#print axioms lowerBranchGap
#print axioms upperBranchGap
#print axioms HeldPair
#print axioms gap
#print axioms gapValue
#print axioms doubleDifference
#print axioms uncastTransport
#print axioms localTransportExact
#print axioms transportValue
end SFT.Mathematics.LocalSeparation
