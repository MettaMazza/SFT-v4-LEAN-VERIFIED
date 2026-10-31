import SFT.Physics.SpacetimeInertial
import SFT.Physics.MechanicalVelocity
namespace SFT.Physics.SpacetimeLimitSpeed
open SFT.Foundation.ExactOperations MechanicalEvents MechanicalDuration MechanicalVelocity

structure Elementary (State Clock Support : Type) (adjacent : Event State → Event State → Prop) where
 relation : SpacetimeEvent.Relation State Clock Support adjacent
 noPriorTransition : count (FieldLocality.trace relation.predecessors) = 0

variable {State Clock Support : Type} {adjacent : Event State → Event State → Prop}

def duration (r : Elementary State Clock Support adjacent) : PositiveFraction :=
 positiveRatio (FieldLocality.trace (SpacetimeEvent.completePath r.relation)) r.relation.clock
   (SpacetimeEvent.completePathPositive r.relation)

def boundaryRatio (r : Elementary State Clock Support adjacent) : PositiveFraction :=
 quotient r.relation.spatial.separation (duration r)

theorem oneElementaryRecurrence (r : Elementary State Clock Support adjacent) :
 count (FieldLocality.trace (SpacetimeEvent.completePath r.relation))=1 := by
 rw [SpacetimeEvent.addsExactlyOneTransition,r.noPriorTransition]

theorem elementaryDurationExact (r : Elementary State Clock Support adjacent) :
 (duration r).denominator = (duration r).numerator * count r.relation.clock.path := by
 have h := SpacetimeEvent.recurrenceRatioExact r.relation
 rw [oneElementaryRecurrence r,Nat.one_mul] at h
 exact h

theorem boundaryRatioExact (r : Elementary State Clock Support adjacent) :
 (r.relation.spatial.separation.numerator * (duration r).denominator) * (boundaryRatio r).denominator =
 (boundaryRatio r).numerator * (r.relation.spatial.separation.denominator * (duration r).numerator) :=
 quotientExact _ _

theorem boundaryRatioPositive (r : Elementary State Clock Support adjacent) :
 0 < (boundaryRatio r).numerator := (boundaryRatio r).positive

def intervalRatio {Causal : Type} (s : SpacetimeInterval.Separation Causal) : Option PositiveFraction :=
 match s.temporal with
 | .emptyOne => none
 | .positive time => some (quotient s.spatial time)

theorem emptyRecurrenceHasNoSpeed {Causal : Type} (space : PositiveFraction) (orientation : MechanicalLocation.Held) (causal : Causal) :
 intervalRatio (⟨.emptyOne,space,orientation,causal⟩ : SpacetimeInterval.Separation Causal)=none := rfl

theorem intervalPreservationForcesBoundaryRatio {Causal : Type}
 (a b : SpacetimeInterval.Description Causal) (same : SpacetimeInterval.equivalent a b) :
 intervalRatio a.separation=intervalRatio b.separation := congrArg intervalRatio same

theorem inertialBoundaryRatioInvariant {A B : Type}
 (a : SpacetimeInertial.Frame (Elementary State Clock Support adjacent) A)
 (b : SpacetimeInertial.Frame (Elementary State Clock Support adjacent) B) (x : A) :
 boundaryRatio (b.read (SpacetimeInertial.correspondence a b x))=boundaryRatio (a.read x) :=
 congrArg boundaryRatio (SpacetimeInertial.completeRecordPreserved a b x)

-- For n elementary support advances in R retained recurrence units, the
-- existing causal cone supplies n≤R. Compare the exact raw quotient with
-- the elementary boundary by positive cross-products.
theorem reachableSpeedBound (n R A B : Nat) (within : n≤R) :
 (n*A)*B ≤ A*(R*B) := by
 obtain ⟨k,h⟩ := Nat.le.dest within
 rw [← h,Nat.mul_comm (n+k) B,Nat.mul_add,Nat.mul_comm B n,Nat.mul_comm B k]
 have base : (n*A)*B ≤ (n*A)*B+(k*A)*B := Nat.le_add_right _ _
 calc
  (n*A)*B ≤ (n*A)*B+(k*A)*B := base
  _ = A*(n*B+k*B) := by rw [Nat.mul_add,Nat.mul_comm n A,Nat.mul_comm k A,SFT.Foundation.FractionReduction.mulAssoc,SFT.Foundation.FractionReduction.mulAssoc]

theorem completeCausalConeBound (a b : Event State) (R A B : Nat)
 (within : @SpacetimeCausalOrder.Within State adjacent a b R) :
 ∃ path : FieldLocality.Propagation adjacent a b,
 (count (FieldLocality.trace path)*A)*B ≤ A*(R*B) := by
 obtain ⟨path,bound⟩ := within
 exact ⟨path,reachableSpeedBound _ _ _ _ bound⟩

theorem elementaryAttainsBoundary (A B : Nat) : (1*A)*B=A*(1*B) := by
 rw [Nat.one_mul,Nat.one_mul]
end SFT.Physics.SpacetimeLimitSpeed
