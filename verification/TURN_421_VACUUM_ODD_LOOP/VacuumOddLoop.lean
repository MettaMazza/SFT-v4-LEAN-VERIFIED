import SFT.Physics.VacuumOddTrace
namespace SFT.Physics.VacuumOddLoop
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Mathematics.OrbitOrderIdentity SFT.Mathematics.OrbitOrderExistence
open SFT.Mathematics.OrbitCycleSupport SFT.Mathematics.OrbitBinaryDepth
open FoldFirstReturn FoldReturnCarrier VacuumOddTrace

theorem stateNumerator (q : Nat) (aboveOne : 1 < q) (odd : q%2=1) (k : Nat) :
 (state q aboveOne k).numerator = rankIterate 1 q k := by
 change rankIterate 1 q k / Nat.gcd (rankIterate 1 q k) q = rankIterate 1 q k
 rw [VacuumOddRecurrence.unitReduced q k aboveOne odd]
 have h := SFT.Foundation.FractionReduction.divisionMultiple 1 (rankIterate 1 q k) (by decide)
 rw [Nat.one_mul] at h
 exact h

theorem statePositionsDistinct (q period i j : Nat) (aboveOne : 1 < q) (odd : q%2=1)
 (first : FirstBinaryOrder q period) (earlier : i < j) (before : j < period) :
 state q aboveOne i ≠ state q aboveOne j := by
 intro same
 have ranks := congrArg Part.numerator same
 rw [stateNumerator q aboveOne odd i,stateNumerator q aboveOne odd j] at ranks
 exact noEarlierCollision 1 q period i j (Nat.lt_trans (by decide) aboveOne) odd
   (gcdOneLeft q) first earlier before ranks

theorem lastStateReturns (q period : Nat) (aboveOne : 1 < q)
 (first : FirstBinaryOrder q period) : state q aboveOne period = state q aboveOne 0 :=
 stateReturned q period aboveOne
   ((exactExecutedReturnIffOrder 1 q period (by decide) (Nat.le_of_lt aboveOne) (gcdOneLeft q)).mpr first.2.1)

theorem nextBeforeReturn (q period count : Nat) (aboveOne : 1 < q)
 (first : FirstBinaryOrder q period) (before : count < period)
 (different : state q aboveOne (count+1) ≠ state q aboveOne 0) : count+1 < period := by
 have bound := Nat.succ_le_of_lt before
 apply Nat.lt_of_le_of_ne bound
 intro same
 exact different ((congrArg (state q aboveOne) same).trans (lastStateReturns q period aboveOne first))

/-- Track the actual previously visited keys while inducting over the source loop. -/
theorem runSuccessful (q period : Nat) (aboveOne : 1 < q) (odd : q%2=1)
 (first : FirstBinaryOrder q period) (seen : List Key) (current : Part)
 (result : Except String (List Part)) (run : Run (state q aboveOne 0) seen current result) :
 ∀ count, count < period → current = state q aboveOne count →
 (∀ k, k ∈ seen → ∃ i, i ≤ count ∧ k = key (state q aboveOne i)) →
 ∃ trace, result = .ok trace := by
 induction run with
 | returned seen current same =>
   intro count before currentEq visited
   exact ⟨[foldPart current],rfl⟩
 | repeated seen current different repeated =>
   intro count before currentEq visited
   have nextEq : foldPart current = state q aboveOne (count+1) :=
     (congrArg foldPart currentEq).trans (stateStep q aboveOne count)
   have diff : state q aboveOne (count+1) ≠ state q aboveOne 0 := fun h => different (nextEq.trans h)
   have nextBefore := nextBeforeReturn q period count aboveOne first before diff
   obtain ⟨i,ib,ki⟩ := visited _ repeated
   have stateEq : state q aboveOne i = state q aboveOne (count+1) :=
     (keyInjective _ _ ki).symm.trans nextEq
   exact False.elim (statePositionsDistinct q period i (count+1) aboveOne odd first
     (Nat.lt_succ_of_le ib) nextBefore stateEq)
 | advanced seen current result different fresh tail ih =>
   intro count before currentEq visited
   have nextEq : foldPart current = state q aboveOne (count+1) :=
     (congrArg foldPart currentEq).trans (stateStep q aboveOne count)
   have diff : state q aboveOne (count+1) ≠ state q aboveOne 0 := fun h => different (nextEq.trans h)
   have nextBefore := nextBeforeReturn q period count aboveOne first before diff
   have seenNext : ∀ k, k ∈ key (foldPart current)::seen →
       ∃ i, i ≤ count+1 ∧ k = key (state q aboveOne i) := by
     intro k held
     cases held with
     | head => exact ⟨count+1,Nat.le_refl _,congrArg key nextEq⟩
     | tail _ old =>
       obtain ⟨i,ib,ki⟩ := visited k old
       exact ⟨i,Nat.le_trans ib (Nat.le_succ _),ki⟩
   obtain ⟨trace,ok⟩ := ih (count+1) nextBefore nextEq seenNext
   exact ⟨foldPart current::trace,congrArg (prepend (foldPart current)) ok⟩

theorem originalFirstReturnSucceeds (q : Nat) (aboveOne : 1 < q) (odd : q%2=1) :
 ∃ trace, firstReturn (state q aboveOne 0) = .ok trace ∧
   GeneratorThreeDerivation.FirstReturn (state q aboveOne 0) trace := by
 obtain ⟨period,_,first,_⟩ := firstOrderExists q (Nat.lt_trans (by decide) aboveOne) odd
 have seen : ∀ k, k ∈ [key (state q aboveOne 0)] → ∃ i, i ≤ 0 ∧ k = key (state q aboveOne i) := by
   intro k held
   cases held with
   | head => exact ⟨0,Nat.le_refl _,rfl⟩
   | tail _ h => cases h
 obtain ⟨trace,ok⟩ := runSuccessful q period aboveOne odd first _ _ _
   (originalLoop (state q aboveOne 0)) 0 first.1 rfl seen
 exact ⟨trace,ok,nativeFirstReturn _ _ ok⟩
theorem oddGuardFalse (q : Nat) (odd : q%2=1) : (q/2*2 == q) = false := by
 cases h : q/2*2 == q with
 | false => rfl
 | true =>
   have same := Nat.eq_of_beq_eq_true h
   have rem := moduloAddMultiple 0 2 (q/2) (by decide)
   rw [Nat.zero_add,← Nat.mul_comm (q/2) 2,same] at rem
   have bad : (1:Nat) = 0 := odd.symm.trans rem
   cases bad

theorem checkedFirstTrace (source : Part) (trace : List Part)
 (first : GeneratorThreeDerivation.FirstReturn source trace) :
 VacuumOddOrbit.checkedTrace trace = .ok trace := by
 obtain ⟨before,split,_,_⟩ := first
 rw [split]
 cases before with
 | nil => exact VacuumOddOrbit.nonemptyTracePreserved source []
 | cons p rest => exact VacuumOddOrbit.nonemptyTracePreserved p (rest ++ [source])

theorem originalWrapperSucceeds (n : Nat) (odd : (n+2)%2=1) :
 ∃ trace, VacuumOddOrbit.oddDenominatorOrbit (.integer (.ofNat (n+2))) = .ok trace ∧
   GeneratorThreeDerivation.FirstReturn (VacuumOddOrbit.unit n) trace := by
 have above : 1 < n+2 := Nat.succ_lt_succ (Nat.zero_lt_succ n)
 obtain ⟨trace,ok,first⟩ := originalFirstReturnSucceeds (n+2) above odd
 have start : state (n+2) above 0 = VacuumOddOrbit.unit n := rfl
 rw [start] at ok first
 refine ⟨trace,?_,first⟩
 rw [VacuumOddOrbit.exactBinaryGuard,oddGuardFalse (n+2) odd]
 change (do let xs ← firstReturn (VacuumOddOrbit.unit n); VacuumOddOrbit.checkedTrace xs) = .ok trace
 rw [ok]
 exact checkedFirstTrace _ _ first

end SFT.Physics.VacuumOddLoop

#print axioms SFT.Physics.VacuumOddLoop.stateNumerator
#print axioms SFT.Physics.VacuumOddLoop.statePositionsDistinct
#print axioms SFT.Physics.VacuumOddLoop.lastStateReturns
#print axioms SFT.Physics.VacuumOddLoop.nextBeforeReturn
#print axioms SFT.Physics.VacuumOddLoop.runSuccessful
#print axioms SFT.Physics.VacuumOddLoop.originalFirstReturnSucceeds

#print axioms SFT.Physics.VacuumOddLoop.oddGuardFalse
#print axioms SFT.Physics.VacuumOddLoop.checkedFirstTrace
#print axioms SFT.Physics.VacuumOddLoop.originalWrapperSucceeds
