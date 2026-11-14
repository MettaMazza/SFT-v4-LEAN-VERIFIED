import SFT.Foundation.HalfOneDerivation
import SFT.Mathematics.ExactRatioRelations
import SFT.Foundation.ExactValueIdentity
import SFT.Mathematics.FiniteDifferenceBounds
namespace SFT.Mathematics.RiemannMirror
open SFT.Foundation ExactOperations ExactPartCarrier FractionReduction
open HalfOneDerivation (halfOne complement)

theorem reflectionValue (p q : Part) (reflected : complement p=.ok q) :
 (p.denominator-p.numerator)*q.denominator=q.numerator*p.denominator := by
 unfold complement takePart at reflected
 split at reflected
 next admitted =>
   have same := Except.ok.inj reflected
   have value := normalizedValuePreserved (takeNumerator one p) (takeDenominator one p)
     (takePositive one p admitted)
     (Nat.lt_of_lt_of_le (takePositive one p admitted) (Nat.le_of_lt (takeStrictlyBelowOne one p admitted)))
   change (takeNumerator one p)*(normalizePart (takeNumerator one p) (takeDenominator one p)
     (takePositive one p admitted) (Nat.le_of_lt (takeStrictlyBelowOne one p admitted))).denominator =
     (normalizePart (takeNumerator one p) (takeDenominator one p)
     (takePositive one p admitted) (Nat.le_of_lt (takeStrictlyBelowOne one p admitted))).numerator*(takeDenominator one p) at value
   rw [same] at value
   change (1*p.denominator-p.numerator*1)*q.denominator=q.numerator*(1*p.denominator) at value
   rw [Nat.one_mul,Nat.mul_one] at value
   exact value
 next rejected => cases reflected

theorem reflectedJunction (p q : Part) (reflected : complement p=.ok q) :
 p.numerator*q.denominator+q.numerator*p.denominator=p.denominator*q.denominator := by
 rw [← reflectionValue p q reflected,← FiniteDifferenceBounds.addMul,Nat.add_comm p.numerator,
   subtractAdd p.denominator p.numerator p.throughOne]

theorem reflectedProper (p q : Part) (reflected : complement p=.ok q) : q.numerator<q.denominator := by
 have whole := reflectedJunction p q reflected
 have strict : q.numerator*p.denominator<p.denominator*q.denominator := by
   rw [← whole]
   exact Nat.lt_add_of_pos_left (Nat.mul_pos p.positive (denominatorPositive q))
 rw [Nat.mul_comm p.denominator q.denominator] at strict
 apply Nat.lt_of_not_ge
 intro opposite
 exact Nat.not_lt_of_ge (Nat.mul_le_mul_right p.denominator opposite) strict

theorem reflectionTwice (p q : Part) (reflected : complement p=.ok q) : complement q=.ok p := by
 have proper := reflectedProper p q reflected
 have admitted : strictlyLarger one q := by
   change q.numerator*1<1*q.denominator
   rw [Nat.mul_one,Nat.one_mul]
   exact proper
 unfold complement
 rw [takeAdmitted one q admitted]
 apply congrArg Except.ok
 apply ExactValueIdentity.normalizedRepresents
 change (1*q.denominator-q.numerator*1)*p.denominator=p.numerator*(1*q.denominator)
 rw [Nat.one_mul,Nat.mul_one]
 have cancel : ∀ k a b : Nat, a+k=b+k → a=b := by
   intro k
   induction k with
   | zero => exact fun _ _ h => h
   | succ k ih => exact fun a b h => ih a b (Nat.succ.inj h)
 apply cancel (q.numerator*p.denominator)
 calc
   (q.denominator-q.numerator)*p.denominator+q.numerator*p.denominator = q.denominator*p.denominator := by
     rw [← FiniteDifferenceBounds.addMul,subtractAdd q.denominator q.numerator q.throughOne]
   _ = p.numerator*q.denominator+q.numerator*p.denominator := by
     rw [Nat.mul_comm q.denominator p.denominator]
     exact (reflectedJunction p q reflected).symm

theorem uniqueFixedAxis (p : Part) (fixed : complement p=.ok p) : p=halfOne := by
 have value := reflectionValue p p fixed
 have same : p.denominator-p.numerator=p.numerator := by
   apply ExactRatioRelations.cancelPositive p.denominator _ _ (denominatorPositive p)
   exact (Nat.mul_comm _ _).trans (value.trans (Nat.mul_comm _ _))
 have whole := subtractAdd p.denominator p.numerator p.throughOne
 rw [same] at whole
 apply (HalfOneDerivation.selfJunctionOneIff p).mp
 exact (normalizationOneIff (p.numerator+p.numerator) p.denominator
   (Nat.add_pos_left p.positive _) (denominatorPositive p)).mpr whole

theorem halfIsFixed : complement halfOne=.ok halfOne := HalfOneDerivation.complementHalf

theorem nonHalfCannotBeFixed (p : Part) (different : p≠halfOne) : complement p≠.ok p :=
 fun fixed => different (uniqueFixedAxis p fixed)

def quarter : Part := normalizePart 1 4 (by decide) (by decide)
def threeQuarters : Part := normalizePart 3 4 (by decide) (by decide)
def third : Part := normalizePart 1 3 (by decide) (by decide)
def twoThirds : Part := normalizePart 2 3 (by decide) (by decide)
theorem quarterPartner : complement quarter=.ok threeQuarters := rfl
theorem threeQuarterPartner : complement threeQuarters=.ok quarter := rfl
theorem thirdPartner : complement third=.ok twoThirds := rfl
theorem twoThirdPartner : complement twoThirds=.ok third := rfl

-- Original adverse logical control: the off-axis two-point set is invariant.
theorem offAxisSymmetry (p : Part) (member : p=quarter ∨ p=threeQuarters) :
 ∃ q, (q=quarter ∨ q=threeQuarters) ∧ complement p=.ok q := by
 cases member with
 | inl h => cases h; exact ⟨threeQuarters,Or.inr rfl,quarterPartner⟩
 | inr h => cases h; exact ⟨quarter,Or.inl rfl,threeQuarterPartner⟩

theorem properPartHasPartner (p : Part) (proper : p.numerator<p.denominator) :
 ∃ q, complement p=.ok q ∧ q.numerator<q.denominator ∧ complement q=.ok p := by
 have guard : strictlyLarger one p := by
   change p.numerator*1<1*p.denominator
   rw [Nat.mul_one,Nat.one_mul]
   exact proper
 let q := normalizePart (takeNumerator one p) (takeDenominator one p)
   (takePositive one p guard) (Nat.le_of_lt (takeStrictlyBelowOne one p guard))
 have pair : complement p=.ok q := takeAdmitted one p guard
 exact ⟨q,pair,reflectedProper p q pair,reflectionTwice p q pair⟩

theorem nonHalfPairDistinct (p q : Part) (reflected : complement p=.ok q) (different : p≠halfOne) :
 p≠q ∧ q≠halfOne := by
 constructor
 · intro same
   rw [← same] at reflected
   exact different (uniqueFixedAxis p reflected)
 · intro half
   have back := reflectionTwice p q reflected
   rw [half,halfIsFixed] at back
   exact different (Except.ok.inj back).symm

theorem quarterOffAxis : quarter≠halfOne := by
 intro same
 have den := congrArg Part.denominator same
 exact (by decide : (4:Nat)≠2) den

theorem threeQuartersOffAxis : threeQuarters≠halfOne := by
 intro same
 have den := congrArg Part.denominator same
 exact (by decide : (4:Nat)≠2) den

theorem symmetricSetHasNoFixedPoint (p : Part) (member : p=quarter ∨ p=threeQuarters) :
 complement p≠.ok p := by
 cases member with
 | inl same => cases same; exact nonHalfCannotBeFixed quarter quarterOffAxis
 | inr same => cases same; exact nonHalfCannotBeFixed threeQuarters threeQuartersOffAxis

theorem complementSucceedsIff (p : Part) :
 (∃ q, complement p=.ok q) ↔ p.numerator<p.denominator := by
 constructor
 · intro paired
   obtain ⟨q,pair⟩ := paired
   exact reflectedProper q p (reflectionTwice p q pair)
 · intro proper
   obtain ⟨q,pair,_,_⟩ := properPartHasPartner p proper
   exact ⟨q,pair⟩

theorem wholeComplementRejected :
 complement one=.error "Take requires the first exact part to be strictly larger" :=
 takeRejected one one (Nat.lt_irrefl _)

end SFT.Mathematics.RiemannMirror
