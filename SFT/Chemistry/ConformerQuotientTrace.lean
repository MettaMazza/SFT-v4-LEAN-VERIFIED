import SFT.Chemistry.ConformerAssignmentMembership
namespace SFT.Chemistry.ConformerQuotientTrace
open SFT.Physics.CapabilityValues ConformerCarrier ConformerAssignments ConformerCensus
open ConformerOrbitProgress ConformerAssignmentMembership
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation
abbrev State := List Assignment × List (List Assignment)

private theorem appendEmpty {α : Type} (xs : List α) : xs++[]=xs := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons x) ih
private theorem appendGrouped {α : Type} (xs ys zs : List α) : (xs++ys)++zs=xs++(ys++zs) := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons x) ih

-- Proof-only execution of the original loop: choose the least remaining
-- generation position, perform its unchanged transition, repeat until empty.
inductive OriginalRun (assignments : List Assignment) (actions : List Action)
 (rotors : List Rotor) (alphabets : List Alphabet) : State → Except String (List (List Assignment)) → Prop where
 | done (classes : List (List Assignment)) : OriginalRun assignments actions rotors alphabets ([],classes) (.ok classes)
 | failed (state : State) (anchor : Assignment) (message : String)
   (least : assignments.find? (containsAssignment state.1)=some anchor)
   (active : containsAssignment state.1 anchor=true)
   (step : quotientStep assignments actions rotors alphabets state anchor=.error message) :
   OriginalRun assignments actions rotors alphabets state (.error message)
 | advanced (state next : State) (anchor : Assignment) (result : Except String (List (List Assignment)))
   (least : assignments.find? (containsAssignment state.1)=some anchor)
   (active : containsAssignment state.1 anchor=true)
   (step : quotientStep assignments actions rotors alphabets state anchor=.ok next)
   (rest : OriginalRun assignments actions rotors alphabets next result) :
   OriginalRun assignments actions rotors alphabets state result

private theorem successfulStep (assignments : List Assignment) (actions : List Action)
 (rotors : List Rotor) (alphabets : List Alphabet) (remaining : List Assignment)
 (classes : List (List Assignment)) (anchor : Assignment) (next : State)
 (active : containsAssignment remaining anchor=true)
 (success : quotientStep assignments actions rotors alphabets (remaining,classes) anchor=.ok next) :
 ∃ images, actions.mapM (fun action => applyAction anchor action rotors alphabets)=.ok images ∧
 next=(remaining.filter (fun row => !containsAssignment (uniqueAssignments images) row),
  classes++[(uniqueAssignments assignments).filter (containsAssignment (uniqueAssignments images))]) := by
 unfold quotientStep at success
 dsimp only at success
 rw [active] at success
 change (do
  let images ← actions.mapM (fun action => applyAction anchor action rotors alphabets)
  if !((uniqueAssignments images).all (containsAssignment assignments)) then
   Except.error "symmetry orbit leaves the complete generated assignment space"
  else Except.ok (remaining.filter (fun row => !containsAssignment (uniqueAssignments images) row), classes++[(uniqueAssignments assignments).filter (containsAssignment (uniqueAssignments images))]))=.ok next at success
 cases computed : actions.mapM (fun action => applyAction anchor action rotors alphabets) with
 | error message => rw [computed] at success; cases success
 | ok images =>
  rw [computed] at success
  dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at success
  split at success
  · cases success
  · cases success
    exact ⟨images,rfl,rfl⟩

theorem orderedScanRunsOriginal (atoms : List HeldLabel) (bonds : List Bond) (g : Graph)
 (admitted : graph atoms bonds=.ok g) (rotors : List Rotor) (alphabets : List Alphabet)
 (validated : rotors.forM (fun rotor => validateRotor rotor g)=.ok ())
 (actions : List Action) (enumerated : allActions g=.ok actions)
 (assignments before pending remaining : List Assignment) (classes : List (List Assignment))
 (decomposition : assignments=before++pending)
 (origin : ∀ row, row∈remaining → row∈assignments)
 (excluded : ∀ row, row∈before → containsAssignment remaining row=false) :
 OriginalRun assignments actions rotors alphabets (remaining,classes)
  (do
   let (_,finalClasses) ← pending.foldlM (quotientStep assignments actions rotors alphabets) (remaining,classes)
   pure finalClasses) := by
 induction pending generalizing before remaining classes with
 | nil =>
  have allExcluded : ∀ row, row∈assignments → containsAssignment remaining row=false := by
   intro row member
   rw [decomposition,appendEmpty] at member
   exact excluded row member
  have empty := noRemainingAfterFullScan assignments remaining origin allExcluded
  rw [empty]
  exact OriginalRun.done classes
 | cons anchor rest ih =>
  have nextDecomposition : assignments=(before++[anchor])++rest :=
   decomposition.trans (appendGrouped before [anchor] rest).symm
  cases active : containsAssignment remaining anchor with
  | false =>
   have skipped : quotientStep assignments actions rotors alphabets (remaining,classes) anchor=.ok (remaining,classes) := by
    unfold quotientStep
    dsimp only
    rw [active]
    rfl
   change OriginalRun assignments actions rotors alphabets (remaining,classes) (do
    let (_,finalClasses) ← (do
     let next ← quotientStep assignments actions rotors alphabets (remaining,classes) anchor
     rest.foldlM (quotientStep assignments actions rotors alphabets) next)
    pure finalClasses)
   rw [skipped]
   have nextExcluded : ∀ row, row∈before++[anchor] → containsAssignment remaining row=false := by
    intro row member
    cases memAppendCases row before [anchor] member with
    | inl h => exact excluded row h
    | inr h =>
     cases h with
     | head => exact active
     | tail _ h => cases h
   exact ih (before++[anchor]) remaining classes nextDecomposition origin nextExcluded
  | true =>
   have least : assignments.find? (containsAssignment remaining)=some anchor := by
    rw [decomposition]
    exact earliestAfterPrefix before rest remaining anchor excluded active
   change OriginalRun assignments actions rotors alphabets (remaining,classes) (do
    let (_,finalClasses) ← (do
     let next ← quotientStep assignments actions rotors alphabets (remaining,classes) anchor
     rest.foldlM (quotientStep assignments actions rotors alphabets) next)
    pure finalClasses)
   cases transition : quotientStep assignments actions rotors alphabets (remaining,classes) anchor with
   | error message =>
    exact OriginalRun.failed (remaining,classes) anchor message least active transition
   | ok next =>
    obtain ⟨images,evaluated,shape⟩ := successfulStep assignments actions rotors alphabets remaining classes anchor next active transition
    have self := generatedOrbitContainsAnchor atoms bonds g admitted rotors alphabets validated actions enumerated anchor images evaluated
    have nextOrigin : ∀ row, row∈next.1 → row∈assignments := by
     intro row member
     rw [shape] at member
     exact origin row (removalMember remaining (uniqueAssignments images) row member).1
    have nextExcluded : ∀ row, row∈before++[anchor] → containsAssignment next.1 row=false := by
     intro row member
     rw [shape]
     cases memAppendCases row before [anchor] member with
     | inl h =>
      cases retained : containsAssignment (remaining.filter (fun x => !containsAssignment (uniqueAssignments images) x)) row with
      | false => rfl
      | true =>
       have prior := removalContainsSubset remaining (uniqueAssignments images) row retained
       rw [excluded row h] at prior
       cases prior
     | inr h =>
      cases h with
      | head => exact removalAnchorAbsent remaining (uniqueAssignments images) anchor self
      | tail _ h => cases h
    have continued := ih (before++[anchor]) next.1 next.2 nextDecomposition nextOrigin nextExcluded
    exact OriginalRun.advanced (remaining,classes) next anchor _ least active transition continued

-- The actual quotient computation has precisely an original-loop execution,
-- including its returned classes and its original failure outcomes.
theorem quotientRunsOriginal (atoms : List HeldLabel) (bonds : List Bond) (g : Graph)
 (admitted : graph atoms bonds=.ok g) (rotors : List Rotor) (alphabets : List Alphabet)
 (validated : rotors.forM (fun rotor => validateRotor rotor g)=.ok ())
 (actions : List Action) (enumerated : allActions g=.ok actions) (assignments : List Assignment) :
 OriginalRun assignments actions rotors alphabets (uniqueAssignments assignments,[])
  (quotient assignments actions rotors alphabets) :=
 orderedScanRunsOriginal atoms bonds g admitted rotors alphabets validated actions enumerated
  assignments [] assignments (uniqueAssignments assignments) [] rfl
  (uniqueOrigins assignments) (fun _ h => by cases h)
end SFT.Chemistry.ConformerQuotientTrace
