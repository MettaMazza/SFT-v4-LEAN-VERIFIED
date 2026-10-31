import SFT.Physics.SpacetimeClockRate
namespace SFT.Physics.SpacetimeLengthRelation
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
open SFT.Mathematics.ExactRatioRelations

-- LENGTH_RELATION: retain every spatial support observation in the chosen
-- simultaneous clock slice. The clock labels are held reference identities.
structure Slice (Support Tick : Type) (clockPartition : Support → Tick) where
 tick : Tick
 wholeSupport : List Support
 supports : List Support
 retained : ∀ s, s ∈ supports → s ∈ wholeSupport
 complete : ∀ s, s ∈ wholeSupport → clockPartition s = tick → s ∈ supports
 simultaneous : ∀ s, s ∈ supports → clockPartition s = tick
 present : 0 < supports.length

variable {Support Tick : Type} {partition : Support → Tick}

def supportCount (slice : Slice Support Tick partition) : Nat := slice.supports.length

def relativeExtent {Other OtherTick : Type} {otherPartition : Other → OtherTick}
 (left : Slice Support Tick partition) (right : Slice Other OtherTick otherPartition) : PositiveFraction :=
 ratio (supportCount left) (supportCount right) left.present right.present

theorem exactExtentRatio {Other OtherTick : Type} {otherPartition : Other → OtherTick}
 (left : Slice Support Tick partition) (right : Slice Other OtherTick otherPartition) :
 supportCount left * (relativeExtent left right).denominator =
 (relativeExtent left right).numerator * supportCount right := ratioValue _ _ _ _

theorem everyHeldSupportIsSimultaneous (slice : Slice Support Tick partition) (s : Support)
 (retained : s ∈ slice.supports) : partition s=slice.tick := slice.simultaneous s retained

theorem everySimultaneousSupportIsRetained (slice : Slice Support Tick partition) (s : Support)
 (inWhole : s ∈ slice.wholeSupport) (atTick : partition s=slice.tick) : s ∈ slice.supports :=
 slice.complete s inWhole atTick

theorem sliceMembershipExactly (slice : Slice Support Tick partition) (s : Support) :
 s ∈ slice.supports ↔ s ∈ slice.wholeSupport ∧ partition s=slice.tick :=
 ⟨fun h => ⟨slice.retained s h,slice.simultaneous s h⟩,fun h => slice.complete s h.1 h.2⟩

-- The exact count pairing is the cross-product form of preserving the
-- support-per-recurrence boundary. No coordinate metric is appended.
def preservesBoundary (leftSupport rightSupport leftClock rightClock : Nat) : Prop :=
 leftSupport*rightClock=rightSupport*leftClock

theorem extentClockPairing (n m t u : Nat) (hn : 0<n) (hm : 0<m) (ht : 0<t) (hu : 0<u)
 (preserved : preservesBoundary n m t u) :
 (ratio n m hn hm).numerator*(ratio t u ht hu).denominator =
 (ratio t u ht hu).numerator*(ratio n m hn hm).denominator := by
 let a := ratio n m hn hm
 let b := ratio t u ht hu
 have ha : n*a.denominator=a.numerator*m := ratioValue _ _ _ _
 have hb : t*b.denominator=b.numerator*u := ratioValue _ _ _ _
 apply cancelPositive (m*u) _ _ (Nat.mul_pos hm hu)
 calc
  (m*u)*(a.numerator*b.denominator) = (a.numerator*m)*(u*b.denominator) := by
   rw [interchange m u a.numerator b.denominator,Nat.mul_comm m a.numerator]
  _ = (n*a.denominator)*(u*b.denominator) := congrArg (fun z => z*(u*b.denominator)) ha.symm
  _ = (n*u)*(a.denominator*b.denominator) := interchange _ _ _ _
  _ = (m*t)*(a.denominator*b.denominator) := congrArg (fun z => z*(a.denominator*b.denominator)) preserved
  _ = (m*a.denominator)*(t*b.denominator) := (interchange _ _ _ _).symm
  _ = (m*a.denominator)*(b.numerator*u) := congrArg (fun z => (m*a.denominator)*z) hb
  _ = (m*u)*(b.numerator*a.denominator) := by
   rw [Nat.mul_comm b.numerator u,interchange m a.denominator u b.numerator,Nat.mul_comm a.denominator b.numerator]

theorem distinctSlicesCannotShareASupport (a b : Slice Support Tick partition)
 (different : a.tick ≠ b.tick) (s : Support) (ha : s ∈ a.supports) : ¬ s ∈ b.supports := by
 intro hb
 exact different ((a.simultaneous s ha).symm.trans (b.simultaneous s hb))

theorem sameSliceComparedWithItself (s : Slice Support Tick partition) :
 (relativeExtent s s).numerator=1 ∧ (relativeExtent s s).denominator=1 :=
 (normalizationOneIff _ _ s.present s.present).mpr rfl

-- Inertial names retain the entire clock-partitioned support record.
theorem completeSlicePreserved {A B : Type}
 (a : SpacetimeInertial.Frame (Slice Support Tick partition) A)
 (b : SpacetimeInertial.Frame (Slice Support Tick partition) B) (x : A) :
 (b.read (SpacetimeInertial.correspondence a b x)).supports=(a.read x).supports :=
 congrArg Slice.supports (SpacetimeInertial.completeRecordPreserved a b x)
end SFT.Physics.SpacetimeLengthRelation
