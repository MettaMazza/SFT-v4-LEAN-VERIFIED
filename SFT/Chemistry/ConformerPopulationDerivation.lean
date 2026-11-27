import SFT.Chemistry.ConformerPopulation
namespace SFT.Chemistry.ConformerPopulationDerivation
open SFT.Physics.CapabilityValues SFT.Chemistry.ConformerAssignments ConformerPopulation
open SFT.Chemistry.DihedralTorsion (Height Ratio CountInput)
open SFT.Foundation.CommonRefinement

theorem occurrencesAppend (group : List Assignment) (before after : List Assignment) :
 occurrences group (before++after)=occurrences group before+occurrences group after := by
 induction before with
 | nil => exact (Nat.zero_add _).symm
 | cons a rest ih =>
  change (if ConformerCensus.containsAssignment group a then 1 else 0)+occurrences group (rest++after)=_
  change (if ConformerCensus.containsAssignment group a then 1 else 0)+occurrences group (rest++after)=((if ConformerCensus.containsAssignment group a then 1 else 0)+occurrences group rest)+occurrences group after
  rw [ih,Nat.add_assoc]

theorem observationSuccessorCount (group : List Assignment) (trace : List Assignment) (a : Assignment) :
 occurrences group (trace++[a])=occurrences group trace+(if ConformerCensus.containsAssignment group a then 1 else 0) := by
 rw [occurrencesAppend]
 rfl

theorem occurrenceWithinBoundary (group : List Assignment) (trace : List Assignment) :
 occurrences group trace≤trace.length := by
 induction trace with
 | nil => exact Nat.le_refl _
 | cons a rest ih =>
  unfold occurrences
  cases held : ConformerCensus.containsAssignment group a with
  | false =>
   change 0+occurrences group rest≤rest.length+1
   rw [Nat.zero_add]
   exact Nat.le_trans ih (Nat.le_succ _)
  | true => exact Nat.le_trans (Nat.add_le_add_left ih 1) (Nat.le_of_eq (Nat.one_add _))

theorem observationRetained (condition : HeldLabel) (boundary : CountInput) (trace : List Assignment)
 (out : Observation) (accepted : observation condition boundary trace=.ok out) :
 out.condition=condition ∧ out.trace=trace ∧ out.boundary.value=trace.length := by
 cases boundary with
 | other =>
  change (if !SFT.Host.Text.equal condition.family "observation-condition" then Except.error "conformer population requires one retained observation condition" else Except.error "observation boundary must equal the complete positive trace length")=Except.ok out at accepted
  split at accepted <;> cases accepted
 | count n =>
  change (if !SFT.Host.Text.equal condition.family "observation-condition" then Except.error "conformer population requires one retained observation condition"
   else if trace.length != n.value then Except.error "observation boundary must equal the complete positive trace length"
   else Except.ok (Observation.mk condition n trace))=Except.ok out at accepted
  split at accepted
  · cases accepted
  · split at accepted
    · cases accepted
    · rename_i aligned
      have size : trace.length=n.value := by
       cases same : (trace.length==n.value) with
       | true => exact Nat.eq_of_beq_eq_true same
       | false => exact False.elim (aligned (by change (!(trace.length==n.value))=true; rw [same]; rfl))
      cases accepted
      exact ⟨rfl,rfl,size.symm⟩

theorem rowRetained (group : List Assignment) (occurrence : Occurrence) (population energy : Height)
 (out : Row) (accepted : row group occurrence population energy=.ok out) :
 out=⟨group,occurrence,population,energy⟩ := by
 unfold row at accepted
 repeat' first | dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted | split at accepted
 all_goals cases accepted <;> rfl

theorem generatedRowPositive (group : List Assignment) (energy : Height) (trace : List Assignment)
 (boundary : PositiveCount) (out : Row) (positive : 0<occurrences group trace)
 (accepted : generatedRow group energy trace boundary=.ok out) :
 out=⟨group,.count ⟨occurrences group trace,positive⟩,.ratio ⟨⟨occurrences group trace,positive⟩,boundary⟩,energy⟩ := by
 unfold generatedRow at accepted
 rw [dif_pos positive] at accepted
 exact rowRetained _ _ _ _ _ accepted

theorem generatedRowAbsent (group : List Assignment) (energy : Height) (trace : List Assignment)
 (boundary : PositiveCount) (out : Row) (absent : occurrences group trace=0)
 (accepted : generatedRow group energy trace boundary=.ok out) :
 out=⟨group,.emptyOne,.emptyOne,energy⟩ := by
 unfold generatedRow at accepted
 rw [absent] at accepted
 exact rowRetained _ _ _ _ _ accepted

theorem takeFromLeastRetains (high : Ratio) : orderedTake (.ratio high) .emptyOne=.ok high := rfl

theorem takePositiveDifference (high low : Ratio)
 (ordered : (DihedralTorsion.fraction low).numerator*(DihedralTorsion.fraction high).denominator <
  (DihedralTorsion.fraction high).numerator*(DihedralTorsion.fraction low).denominator) :
 orderedTake (.ratio high) (.ratio low)=.ok (DihedralTorsion.rawRatio
  (SFT.Physics.LeptonTake.heldRemainder (DihedralTorsion.fraction high) (DihedralTorsion.fraction low) ordered)) := by
 unfold orderedTake
 dsimp only
 rw [dif_pos ordered]

theorem successorRetainsHistory (c : PopulationCensus) (a : Assignment) :
 appendObservation c a=conditioned c.conformers c.observation.condition
  (c.observation.trace++[a]) (c.rows.map Row.relativeEnergy) := rfl
end SFT.Chemistry.ConformerPopulationDerivation
