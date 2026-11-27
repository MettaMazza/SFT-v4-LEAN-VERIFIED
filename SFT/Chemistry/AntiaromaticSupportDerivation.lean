import SFT.Chemistry.AntiaromaticDistinctionDerivation
namespace SFT.Chemistry.AntiaromaticSupportDerivation
open SFT.Physics.CapabilityValues AntiaromaticDistinction AntiaromaticDistinctionDerivation

theorem aromaticSupport (r : AromaticRecurrence.Recurrence) (out : Alternative)
 (h : aromaticAlternative r=.ok out) : hasCount out.recurrenceSupport (AromaticRecurrence.supportSize r)=true := by
 unfold aromaticAlternative at h
 cases hn : AromaticRecurrence.positiveSupportCount r with
 | error e => rw [hn] at h; cases h
 | ok n =>
  rw [hn] at h
  have kept := retains r.carrier r.cycle completePlane completeConjugation aromatic (.positive n) r.layers out h
  cases kept
  have counted : n.value=AromaticRecurrence.supportSize r := by
   unfold AromaticRecurrence.positiveSupportCount count at hn
   split at hn
   · cases hn; rfl
   · cases hn
  dsimp only [hasCount]
  rw [counted]
  have reflexive : ∀ k : Nat, (k==k)=true := by
   intro k
   induction k with
   | zero => rfl
   | succ k ih => exact ih
  exact reflexive _

theorem antiaromaticSupport (cycle : MulticentreSupport.Support) (layers : PositiveCount) (out : Alternative)
 (h : antiaromaticAlternative cycle layers=.ok out) :
 hasCount out.recurrenceSupport (4*layers.value)=true ∧ out.layers=List.replicate layers.value AromaticRecurrence.completeCells ∧ out.cycle=cycle := by
 unfold antiaromaticAlternative at h
 cases hn : count (4*layers.value) with
 | error e => rw [hn] at h; cases h
 | ok n =>
  rw [hn] at h
  have kept := retains cycle.molecularCarrier cycle completePlane completeConjugation antiaromatic (.positive n) (List.replicate layers.value AromaticRecurrence.completeCells) out h
  cases kept
  have counted : n.value=4*layers.value := by
   unfold count at hn
   split at hn
   · cases hn; rfl
   · cases hn
  refine ⟨?_,rfl,rfl⟩
  dsimp only [hasCount]
  rw [counted]
  have reflexive : ∀ k : Nat, (k==k)=true := by
   intro k
   induction k with
   | zero => rfl
   | succ k ih => exact ih
  exact reflexive _
end SFT.Chemistry.AntiaromaticSupportDerivation
