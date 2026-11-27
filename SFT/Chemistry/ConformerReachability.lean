import SFT.Chemistry.ConformerReachSet
import SFT.Chemistry.ConformerIdentityValues
namespace SFT.Chemistry.ConformerReachability
open SFT.Physics.CapabilityValues ConformerCarrier ConformerReachSet
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

private theorem positionEqual (a b : PositiveCount) (h : a.value=b.value) : a=b := by
 cases a; cases b; cases h; rfl
private instance : DecidableEq PositiveCount := fun a b =>
 match decEq a.value b.value with
 | isTrue h => isTrue (positionEqual a b h)
 | isFalse h => isFalse (fun eq => h (congrArg PositiveCount.value eq))
private def removePosition : List PositiveCount → PositiveCount → List PositiveCount
 | [],_ => []
 | y::ys,x => if y=x then removePosition ys x else y::removePosition ys x
private theorem removeLengthLe (xs : List PositiveCount) (x : PositiveCount) :
 (removePosition xs x).length≤xs.length := by
 induction xs with
 | nil => exact Nat.le_refl _
 | cons y ys ih =>
  unfold removePosition
  split
  · exact Nat.le_trans ih (Nat.le_succ _)
  · exact Nat.succ_le_succ ih
private theorem removeShorter (xs : List PositiveCount) (x : PositiveCount)
 (member : x∈xs) : (removePosition xs x).length<xs.length := by
 induction xs with
 | nil => cases member
 | cons y ys ih =>
  unfold removePosition
  by_cases same : y=x
  · rw [if_pos same]; exact Nat.lt_succ_of_le (removeLengthLe ys x)
  · rw [if_neg same]
    apply Nat.succ_lt_succ
    apply ih
    cases member with
    | head => exact False.elim (same rfl)
    | tail _ h => exact h
private theorem removeRetainsOther (xs : List PositiveCount) (x y : PositiveCount)
 (member : y∈xs) (other : y≠x) : y∈removePosition xs x := by
 induction xs with
 | nil => cases member
 | cons z zs ih =>
  unfold removePosition
  by_cases same : z=x
  · rw [if_pos same]
    apply ih
    cases member with
    | head => exact False.elim (other same)
    | tail _ h => exact h
  · rw [if_neg same]
    cases member with
    | head => exact List.Mem.head _
    | tail _ h => exact List.Mem.tail _ (ih h)

theorem registeredCardinality (small large : List PositiveCount) (unique : small.Nodup)
 (inside : ∀ x, x∈small → x∈large) : small.length≤large.length := by
 induction small generalizing large with
 | nil => exact Nat.zero_le _
 | cons x xs ih =>
  cases unique with
  | cons fresh unique =>
   have shorter := removeShorter large x (inside x (List.Mem.head xs))
   have tailInside : ∀ y, y∈xs → y∈removePosition large x := by
    intro y member
    exact removeRetainsOther large x y (inside y (List.Mem.tail x member))
     (fun eq => fresh y member eq.symm)
   exact Nat.le_trans (Nat.succ_le_succ (ih _ unique tailInside)) shorter

-- The source's simultaneous expanded-set loop, expressed as a finite trace.
-- Constructor premises are its stopping/evolution tests, not a new model rule.
inductive OriginalExpansionRun (bonds : List Bond) : List PositiveCount → List PositiveCount → Prop where
 | stopped (reached : List PositiveCount) (fixed : expand bonds reached=reached) :
   OriginalExpansionRun bonds reached reached
 | advanced (reached result : List PositiveCount) (changed : expand bonds reached≠reached)
   (rest : OriginalExpansionRun bonds (expand bonds reached) result) :
   OriginalExpansionRun bonds reached result

theorem boundedReachRunsOriginal (n : Nat) (bonds : List Bond) (allowed reached : List PositiveCount)
 (custody : ∀ bond, bond∈bonds → bond.1∈allowed ∧ bond.2∈allowed)
 (unique : reached.Nodup) (inside : ∀ x, x∈reached → x∈allowed)
 (budget : allowed.length < reached.length+n) :
 OriginalExpansionRun bonds reached (reach n bonds reached) := by
 induction n generalizing reached with
 | zero =>
  exact False.elim ((Nat.not_lt_of_ge (registeredCardinality reached allowed unique inside)) budget)
 | succ n ih =>
  cases sameSize : ((expand bonds reached).length==reached.length) with
  | true =>
   have fixed := expansionStopsExactly bonds reached unique (Nat.eq_of_beq_eq_true sameSize)
   have step : reach (n+1) bonds reached=reached := by
    change (if (expand bonds reached).length==reached.length then reached else reach n bonds (expand bonds reached))=reached
    rw [sameSize]
    rfl
   rw [step]
   exact OriginalExpansionRun.stopped reached fixed
  | false =>
   have differentSize : (expand bonds reached).length≠reached.length := by
    intro eq
    rw [eq,naturalEqualityReflexive] at sameSize
    cases sameSize
   have growth := expansionGrows bonds reached unique differentSize
   have nextBudget : allowed.length < (expand bonds reached).length+n := by
    have inc := Nat.add_le_add_right growth n
    rw [Nat.succ_add] at inc
    exact Nat.lt_of_lt_of_le budget inc
   have step : reach (n+1) bonds reached=reach n bonds (expand bonds reached) := by
    change (if (expand bonds reached).length==reached.length then reached else reach n bonds (expand bonds reached))=_
    rw [sameSize]
    rfl
   rw [step]
   apply OriginalExpansionRun.advanced reached _
   · intro fixed; exact differentSize (congrArg List.length fixed)
   · exact ih _ (expansionUnique bonds reached) (expansionInside bonds reached allowed custody inside) nextBudget

theorem originalRunEndsFixed (bonds : List Bond) (start result : List PositiveCount)
 (run : OriginalExpansionRun bonds start result) : expand bonds result=result := by
 induction run with
 | stopped reached fixed => exact fixed
 | advanced reached result changed rest ih => exact ih

private theorem zeroInRange (n : Nat) : 0∈List.range (n+1) := by
 have loop (k : Nat) (xs : List Nat) : 0∈List.range.loop (k+1) xs := by
  induction k generalizing xs with
  | zero => exact List.Mem.head _
  | succ k ih => exact ih ((k+1)::xs)
 exact loop n []

-- Exactly the original singleton and the constructor's atom-count bound.
theorem initialReachRunsOriginal (size : Nat) (positive : 0<size) (bonds : List Bond)
 (guard : bonds.all (fun bond => containsPosition (positions size) bond.1 &&
  containsPosition (positions size) bond.2)=true) :
 OriginalExpansionRun bonds [⟨1,Nat.zero_lt_succ 0⟩]
  (reach size bonds [⟨1,Nat.zero_lt_succ 0⟩]) := by
 have custody : ∀ bond, bond∈bonds → bond.1∈positions size ∧ bond.2∈positions size := by
  intro bond member
  have each : containsPosition (positions size) bond.1 && containsPosition (positions size) bond.2=true := by
   induction bonds with
   | nil => cases member
   | cons first rest ih =>
    change ((containsPosition (positions size) first.1 && containsPosition (positions size) first.2) &&
     rest.all (fun e => containsPosition (positions size) e.1 && containsPosition (positions size) e.2))=true at guard
    cases head : (containsPosition (positions size) first.1 && containsPosition (positions size) first.2) with
    | false => rw [head] at guard; cases guard
    | true =>
     rw [head] at guard
     cases member with
     | head => exact head
     | tail _ h => exact ih guard h
  cases left : containsPosition (positions size) bond.1 with
  | false => rw [left] at each; cases each
  | true =>
   rw [left] at each
   exact ⟨(positionMembership _ _).mp left,(positionMembership _ _).mp each⟩
 apply boundedReachRunsOriginal size bonds (positions size) _ custody
 · exact List.Pairwise.cons (fun _ h => by cases h) List.Pairwise.nil
 · intro x member
   cases member with
   | head =>
    cases size with
    | zero => cases positive
    | succ n => exact memMap (fun i => (⟨i+1,Nat.zero_lt_succ i⟩ : PositiveCount)) 0 _ (zeroInRange n)
   | tail _ h => cases h
 · rw [ConformerIdentityValues.positionsLength]
   change size<1+size
   rw [Nat.one_add]
   exact Nat.lt_succ_self _

theorem initialReachFixed (size : Nat) (positive : 0<size) (bonds : List Bond)
 (guard : bonds.all (fun bond => containsPosition (positions size) bond.1 &&
  containsPosition (positions size) bond.2)=true) :
 expand bonds (reach size bonds [⟨1,Nat.zero_lt_succ 0⟩]) =
 reach size bonds [⟨1,Nat.zero_lt_succ 0⟩] :=
 originalRunEndsFixed bonds _ _ (initialReachRunsOriginal size positive bonds guard)
end SFT.Chemistry.ConformerReachability
