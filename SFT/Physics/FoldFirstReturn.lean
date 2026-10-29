import SFT.Physics.FoldReturnCarrier
namespace SFT.Physics.FoldFirstReturn
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Mathematics.DiscreteObjects FoldReturnCarrier

def recurrenceError : String := "ValueError: registered part entered another recurrence before returning"

def prepend (state : Part) : Except String (List Part) → Except String (List Part)
 | .error error => .error error
 | .ok trace => .ok (state :: trace)

-- Exact ordered branches of the source while loop. The next Fold is retained
-- before testing return, then the previously visited states are tested.
inductive Run (source : Part) : List Key → Part → Except String (List Part) → Prop where
 | returned (seen : List Key) (current : Part) (same : foldPart current = source) :
     Run source seen current (.ok [foldPart current])
 | repeated (seen : List Key) (current : Part) (different : foldPart current ≠ source)
     (visited : key (foldPart current) ∈ seen) : Run source seen current (.error recurrenceError)
 | advanced (seen : List Key) (current : Part) (result : Except String (List Part))
     (different : foldPart current ≠ source) (fresh : ¬ key (foldPart current) ∈ seen)
     (tail : Run source (key (foldPart current) :: seen) (foldPart current) result) :
     Run source seen current (prepend (foldPart current) result)

def runBounded (source : Part) (denominator : Nat) : (fuel : Nat) →
    (remaining seen : List Key) → remaining.length ≤ fuel → Covered denominator remaining seen →
    (current : Part) → current.denominator ≤ denominator →
    { result : Except String (List Part) // Run source seen current result }
 | fuel,remaining,seen,bound,covered,current,currentBound => by
    let next := foldPart current
    have nextBound := Nat.le_trans (foldDenominatorBound current) currentBound
    by_cases same : key next = key source
    · exact ⟨.ok [next],.returned _ _ (keyInjective _ _ same)⟩
    · have different : next ≠ source := fun eq => same (congrArg key eq)
      by_cases seenCheck : has seen (key next) = true
      · exact ⟨.error recurrenceError,.repeated _ _ different ((hasIff _ _).mp seenCheck)⟩
      · have visited : ¬ key next ∈ seen := fun h => seenCheck ((hasIff _ _).mpr h)
        have held : key next ∈ remaining := by
          cases covered next nextBound with
          | inl h => exact h
          | inr h => exact False.elim (visited h)
        have decrease := removeDecreases (key next) remaining held
        match fuel with
        | 0 => exact False.elim (Nat.not_lt_zero _ (Nat.lt_of_lt_of_le decrease bound))
        | fuel+1 =>
          have smaller := Nat.le_of_lt_succ (Nat.lt_of_lt_of_le decrease bound)
          let tail := runBounded source denominator fuel (remove (key next) remaining) (key next :: seen)
            smaller (coveredSuccessor _ _ _ covered next) next nextBound
          exact ⟨prepend next tail.val,.advanced _ _ _ different visited tail.property⟩

def firstReturn (source : Part) : Except String (List Part) :=
  (runBounded source source.denominator (carrier source.denominator).length
    (carrier source.denominator) [key source] (Nat.le_refl _) (initialCovered source)
    source (Nat.le_refl _)).val

theorem originalLoop (source : Part) : Run source [key source] source (firstReturn source) :=
  (runBounded source source.denominator (carrier source.denominator).length
    (carrier source.denominator) [key source] (Nat.le_refl _) (initialCovered source)
    source (Nat.le_refl _)).property

theorem successfulSteps (source : Part) (seen : List Key) (current : Part)
    (result : Except String (List Part)) (run : Run source seen current result) :
    ∀ trace, result = .ok trace → GeneratorThreeDerivation.Steps current trace := by
  induction run with
  | returned seen current same =>
    intro trace eq; cases eq
    exact .next _ _ (.identity _)
  | repeated seen current different visited => intro trace eq; cases eq
  | advanced seen current result different fresh tail ih =>
    intro trace eq
    cases result with
    | error error => cases eq
    | ok rest =>
      cases eq
      exact .next _ _ (ih rest rfl)

theorem successfulFirst (source : Part) (seen : List Key) (current : Part)
    (result : Except String (List Part)) (run : Run source seen current result) :
    ∀ trace, result = .ok trace → ∃ before, trace = before ++ [source] ∧
      ∀ state, state ∈ before → state ≠ source := by
  induction run with
  | returned seen current same =>
    intro trace eq; cases eq
    exact ⟨[],congrArg (fun p => [p]) same,fun _ held => by cases held⟩
  | repeated seen current different visited => intro trace eq; cases eq
  | advanced seen current result different fresh tail ih =>
    intro trace eq
    cases result with
    | error error => cases eq
    | ok rest =>
      cases eq
      obtain ⟨before,split,absent⟩ := ih rest rfl
      refine ⟨foldPart current :: before,congrArg (List.cons (foldPart current)) split,?_⟩
      intro state held
      cases held with
      | head => exact different
      | tail _ h => exact absent _ h

theorem nativeFirstReturn (source : Part) (trace : List Part) (passed : firstReturn source = .ok trace) :
    GeneratorThreeDerivation.FirstReturn source trace := by
  obtain ⟨before,split,absent⟩ := successfulFirst source _ _ _ (originalLoop source) trace passed
  exact ⟨before,split,successfulSteps source _ _ _ (originalLoop source) trace passed,absent⟩

inductive Input where
 | fraction (value : Rat)
 | nonFraction

def checkedFold : Input → Except String Part
 | .nonFraction => .error "ValueError: Fold action requires one exact positive part of the One"
 | .fraction value => match admitFraction value with
   | none => .error "ValueError: Fold action requires one exact positive part of the One"
   | some p => .ok (foldPart p)

def checkedFirstReturn : Input → Except String (List Part)
 | .nonFraction => .error "ValueError: first return requires one exact positive Fold part"
 | .fraction value => match admitFraction value with
   | none => .error "ValueError: first return requires one exact positive Fold part"
   | some p => firstReturn p

theorem checkedFoldAdmitted (p : Part) : checkedFold (.fraction (asFraction p)) = .ok (foldPart p) := by
  unfold checkedFold
  dsimp only
  rw [admittedPartRoundTrip]

theorem checkedReturnAdmitted (p : Part) : checkedFirstReturn (.fraction (asFraction p)) = firstReturn p := by
  unfold checkedFirstReturn
  dsimp only
  rw [admittedPartRoundTrip]

theorem fractionRejected (r : Rat) (rejected : admitFraction r = none) :
    checkedFirstReturn (.fraction r) = .error "ValueError: first return requires one exact positive Fold part" := by
  unfold checkedFirstReturn
  dsimp only
  rw [rejected]

set_option maxRecDepth 10000 in
set_option maxHeartbeats 2000000 in
theorem binaryNative : firstReturn SFT.Foundation.FoldDynamics.third =
    .ok GeneratorThreeDerivation.binaryTrace := rfl

set_option maxRecDepth 10000 in
set_option maxHeartbeats 2000000 in
theorem ternaryNative : firstReturn GeneratorThreeDerivation.seventh =
    .ok GeneratorThreeDerivation.ternaryTrace := rfl

def generatorPeriod : Except String Nat := do
  let binary ← firstReturn (GeneratorThreeDerivation.unitPart 2 (by decide))
  let candidate := binary.length + 1
  let witnessed ← firstReturn (GeneratorThreeDerivation.unitPart candidate (Nat.zero_lt_succ _))
  if binary.length != 2 || witnessed.length != candidate then
    .error "ValueError: Fold recurrence did not force the first two distinct periods"
  else .ok witnessed.length

set_option maxRecDepth 10000 in
set_option maxHeartbeats 2000000 in
theorem generatorPeriodThree : generatorPeriod = .ok 3 := rfl

end SFT.Physics.FoldFirstReturn
