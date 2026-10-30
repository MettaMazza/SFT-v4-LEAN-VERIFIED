import SFT.Mathematics.FiniteRefinement
import SFT.Mathematics.LimitContinuumGrammar
namespace SFT.Mathematics.FiniteRefinementTrace
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations SFT.Mathematics.FiniteRefinement
open SFT.Foundation.Count.TraceDerivation

def trace : Nat → List Part
 | 0 => [one]
 | n+1 => trace n ++ [rung (n+1)]

theorem traceCount (n : Nat) : (trace n).length=n+1 := by
 induction n with
 | zero => rfl
 | succ n ih =>
  change (trace n ++ [rung (n+1)]).length=(n+1)+1
  rw [SFT.Foundation.CommonRefinement.appendLength,ih]
  rfl

theorem terminalIncluded (n : Nat) : rung n ∈ trace n := by
 cases n with
 | zero => exact List.Mem.head _
 | succ n => exact memAppendRight _ _ _ (List.Mem.head _)

theorem priorRetained (n : Nat) (p : Part) (h : p ∈ trace n) : p ∈ trace (n+1) :=
 memAppendLeft _ _ _ h

theorem traceExactlyGenerated (n : Nat) : ∀ p, p ∈ trace n → ∃ k, k≤n ∧ p=rung k := by
 induction n with
 | zero =>
  intro p h
  cases h with
  | head => exact ⟨0,Nat.le_refl _,rfl⟩
  | tail _ h => cases h
 | succ n ih =>
  intro p h
  cases memAppendCases p (trace n) [rung (n+1)] h with
  | inl h =>
   obtain ⟨k,hk,eq⟩ := ih p h
   exact ⟨k,Nat.le_trans hk (Nat.le_succ _),eq⟩
  | inr h =>
   cases h with
   | head => exact ⟨n+1,Nat.le_refl _,rfl⟩
   | tail _ h => cases h

theorem everyEarlierRungIncluded (n k : Nat) (h : k≤n) : rung k ∈ trace n := by
 induction n with
 | zero =>
  have eq := Nat.eq_zero_of_le_zero h
  cases eq
  exact terminalIncluded 0
 | succ n ih =>
  cases Nat.eq_or_lt_of_le h with
  | inl eq => cases eq; exact terminalIncluded (n+1)
  | inr lt => exact priorRetained n _ (ih (Nat.le_of_lt_succ lt))

theorem traceRungIff (n : Nat) (p : Part) :
 p ∈ trace n ↔ ∃ k, k≤n ∧ p=rung k := by
 constructor
 · exact traceExactlyGenerated n p
 · intro h
   obtain ⟨k,hk,eq⟩ := h
   cases eq
   exact everyEarlierRungIncluded n k hk

theorem everyTraceMemberPositive (n : Nat) (p : Part) (_ : p ∈ trace n) : 0<p.numerator := p.positive

theorem noGreatestTrace (n : Nat) : (trace n).length < (trace (n+1)).length := by
 rw [traceCount,traceCount]
 exact Nat.lt_succ_self _

theorem acceptedObjectBoundary (c : LimitContinuumGrammar.Candidate)
 (h : LimitContinuumGrammar.survives c=true) :
 c.object=.admitted ∧ c.continuum=.admitted ∧ c.cardinality=.admitted := by
 have eq := (LimitContinuumGrammar.uniqueSurvivor c).mp h
 cases eq
 exact ⟨rfl,rfl,rfl⟩

#print axioms trace
#print axioms traceCount
#print axioms terminalIncluded
#print axioms priorRetained
#print axioms traceExactlyGenerated
#print axioms everyEarlierRungIncluded
#print axioms traceRungIff
#print axioms everyTraceMemberPositive
#print axioms noGreatestTrace
#print axioms acceptedObjectBoundary
end SFT.Mathematics.FiniteRefinementTrace
