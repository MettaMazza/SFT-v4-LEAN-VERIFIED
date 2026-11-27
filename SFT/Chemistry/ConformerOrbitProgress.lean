import SFT.Chemistry.ConformerActionEnumeration
import SFT.Chemistry.ConformerReadback
import SFT.Chemistry.ConformerCensus
namespace SFT.Chemistry.ConformerOrbitProgress
open SFT.Physics.CapabilityValues ConformerCarrier ConformerAssignments ConformerCensus
open ConformerIdentityValues ConformerReachSet ConformerActionEnumeration ConformerReadback

-- The original rotor-admission check supplies the site bounds used by identity.
theorem acceptedRotorBounds (rotor : Rotor) (g : Graph)
 (accepted : validateRotor rotor g=.ok ()) :
 ∀ site, site∈rotor.orderedSites → site.value≤g.atomTypes.length := by
 unfold validateRotor at accepted
 split at accepted
 · cases accepted
 · rename_i admitted
   have custody : rotor.orderedSites.all (containsPosition (positions g.atomTypes.length))=true := by
    cases held : rotor.orderedSites.all (containsPosition (positions g.atomTypes.length)) with
    | true => rfl
    | false =>
     apply False.elim
     apply admitted
     rw [held]
     cases ((uniquePositions rotor.orderedSites).length != 4) <;> rfl
   intro site member
   have each : containsPosition (positions g.atomTypes.length) site=true := by
    have allHeld (pending : List PositiveCount)
     (all : pending.all (containsPosition (positions g.atomTypes.length))=true)
     (p : PositiveCount) (present : p∈pending) : containsPosition (positions g.atomTypes.length) p=true := by
     induction pending with
     | nil => cases present
     | cons first rest ih =>
      change (containsPosition (positions g.atomTypes.length) first && rest.all (containsPosition (positions g.atomTypes.length)))=true at all
      cases head : containsPosition (positions g.atomTypes.length) first with
      | false => rw [head] at all; cases all
      | true =>
       rw [head] at all
       cases present with
       | head => exact head
       | tail _ h => exact ih all h
    exact allHeld rotor.orderedSites custody site member
   exact positionWithinSupport g.atomTypes.length site ((positionMembership _ _).mp each)

theorem validatedRotorBounds (rotors : List Rotor) (g : Graph)
 (validated : rotors.forM (fun rotor => validateRotor rotor g)=.ok ()) :
 ∀ rotor, rotor∈rotors → ∀ site, site∈rotor.orderedSites → site.value≤g.atomTypes.length := by
 induction rotors with
 | nil => intro rotor impossible; cases impossible
 | cons first rest ih =>
  change (do validateRotor first g; rest.forM (fun rotor => validateRotor rotor g))=.ok () at validated
  cases step : validateRotor first g with
  | error message => rw [step] at validated; cases validated
  | ok unit =>
   cases unit
   rw [step] at validated
   intro rotor member
   cases member with
   | head => exact acceptedRotorBounds first g step
   | tail _ member => exact ih validated rotor member

theorem generatedImagesContainAnchor (atoms : List HeldLabel) (bonds : List Bond)
 (g : Graph) (admitted : graph atoms bonds=.ok g)
 (rotors : List Rotor) (alphabets : List Alphabet) (validated : rotors.forM (fun rotor => validateRotor rotor g)=.ok ())
 (actions : List Action) (enumerated : allActions g=.ok actions)
 (anchor : Assignment) (images : List Assignment)
 (evaluated : actions.mapM (fun action => applyAction anchor action rotors alphabets)=.ok images) :
 anchor∈images := by
 let identity : Action := ⟨positions g.atomTypes.length⟩
 have present : identity∈actions := admittedEnumerationRetainsIdentity atoms bonds g admitted actions enumerated
 obtain ⟨image,value⟩ := mappedInputSucceeds (fun action => applyAction anchor action rotors alphabets)
  actions identity images present evaluated
 have unchanged : image=anchor := successfulIdentityAction g.atomTypes.length rotors anchor alphabets image
  (validatedRotorBounds rotors g validated) value
 have retained := mappedResultRetained (fun action => applyAction anchor action rotors alphabets)
  actions identity image images present value evaluated
 rw [unchanged] at retained
 exact retained

private theorem sameAssignment (anchor : Assignment) : MulticentreSupport.sameWord anchor anchor=true := by
 induction anchor with
 | nil => rfl
 | cons first rest ih =>
  change MulticentreSupport.sameLabel first first && MulticentreSupport.sameWord rest rest=true
  have same : MulticentreSupport.sameLabel first first=true := by
   have reflexive (xs : List Nat) : (xs==xs)=true := by
    induction xs with
    | nil => rfl
    | cons x xs ih =>
     change ((x==x) && (xs==xs))=true
     rw [SFT.Foundation.CommonRefinement.naturalEqualityReflexive,ih]
     rfl
   unfold MulticentreSupport.sameLabel SFT.Host.Text.equal
   rw [reflexive,reflexive]
   rfl
  rw [same,ih]
  rfl

private theorem containsAppend (before after : List Assignment) (anchor : Assignment)
 (held : containsAssignment before anchor=true) : containsAssignment (before++after) anchor=true := by
 induction before with
 | nil => cases held
 | cons first rest ih =>
  change MulticentreSupport.sameWord anchor first || containsAssignment rest anchor=true at held
  change MulticentreSupport.sameWord anchor first || containsAssignment (rest++after) anchor=true
  cases same : MulticentreSupport.sameWord anchor first with
  | true => rfl
  | false =>
   try rw [same] at held
   exact ih held
private theorem containsAtEnd (before : List Assignment) (anchor : Assignment) :
 containsAssignment (before++[anchor]) anchor=true := by
 induction before with
 | nil =>
  change MulticentreSupport.sameWord anchor anchor || false=true
  rw [sameAssignment]
  rfl
 | cons first rest ih =>
  change MulticentreSupport.sameWord anchor first || containsAssignment (rest++[anchor]) anchor=true
  rw [ih]
  cases MulticentreSupport.sameWord anchor first <;> rfl

theorem dedupRetainsAnchor (images : List Assignment) (anchor : Assignment) (present : anchor∈images) :
 containsAssignment (uniqueAssignments images) anchor=true := by
 let add := fun (seen : List Assignment) (row : Assignment) => if containsAssignment seen row then seen else seen++[row]
 have loop (pending seen : List Assignment)
  (held : containsAssignment seen anchor=true ∨ anchor∈pending) :
  containsAssignment (pending.foldl add seen) anchor=true := by
  induction pending generalizing seen with
  | nil =>
   cases held with
   | inl h => exact h
   | inr h => cases h
  | cons first rest ih =>
   change containsAssignment (rest.foldl add (add seen first)) anchor=true
   cases existing : containsAssignment seen first with
   | true =>
    have step : add seen first=seen := by dsimp only [add]; rw [existing]; rfl
    rw [step]
    apply ih
    cases held with
    | inl h => exact Or.inl h
    | inr h =>
     cases h with
     | head => exact Or.inl existing
     | tail _ h => exact Or.inr h
   | false =>
    have step : add seen first=seen++[first] := by dsimp only [add]; rw [existing]; rfl
    rw [step]
    apply ih
    cases held with
    | inl h => exact Or.inl (containsAppend seen [first] anchor h)
    | inr h =>
     cases h with
     | head => exact Or.inl (containsAtEnd seen anchor)
     | tail _ h => exact Or.inr h
 exact loop images [] (Or.inr present)

-- This is the actual orbit used by quotient, including original deduplication.
theorem generatedOrbitContainsAnchor (atoms : List HeldLabel) (bonds : List Bond)
 (g : Graph) (admitted : graph atoms bonds=.ok g)
 (rotors : List Rotor) (alphabets : List Alphabet) (validated : rotors.forM (fun rotor => validateRotor rotor g)=.ok ())
 (actions : List Action) (enumerated : allActions g=.ok actions)
 (anchor : Assignment) (images : List Assignment)
 (evaluated : actions.mapM (fun action => applyAction anchor action rotors alphabets)=.ok images) :
 containsAssignment (uniqueAssignments images) anchor=true :=
 dedupRetainsAnchor images anchor
  (generatedImagesContainAnchor atoms bonds g admitted rotors alphabets validated actions enumerated anchor images evaluated)

theorem orbitRemovalDropsAnchor (remaining orbit : List Assignment) (anchor : Assignment)
 (self : containsAssignment orbit anchor=true) :
 anchor∉remaining.filter (fun row => !containsAssignment orbit row) := by
 induction remaining with
 | nil => intro impossible; cases impossible
 | cons first rest ih =>
  change anchor∉(match !containsAssignment orbit first with
   | true => first::rest.filter (fun row => !containsAssignment orbit row)
   | false => rest.filter (fun row => !containsAssignment orbit row))
  cases removed : containsAssignment orbit first with
  | true => exact ih
  | false =>
   intro member
   cases member with
   | head => rw [removed] at self; cases self
   | tail _ member => exact ih member

theorem orbitRemovalShrinks (remaining orbit : List Assignment) (anchor : Assignment)
 (present : anchor∈remaining) (self : containsAssignment orbit anchor=true) :
 (remaining.filter (fun row => !containsAssignment orbit row)).length<remaining.length := by
 have bound (rows : List Assignment) :
  (rows.filter (fun row => !containsAssignment orbit row)).length≤rows.length := by
  induction rows with
  | nil => exact Nat.le_refl _
  | cons row rest ih =>
   change (match !containsAssignment orbit row with
    | true => row::rest.filter (fun x => !containsAssignment orbit x)
    | false => rest.filter (fun x => !containsAssignment orbit x)).length≤rest.length+1
   cases removed : containsAssignment orbit row with
   | true => exact Nat.le_trans ih (Nat.le_succ _)
   | false => exact Nat.succ_le_succ ih
 induction remaining with
 | nil => cases present
 | cons first rest ih =>
  change (match !containsAssignment orbit first with
   | true => first::rest.filter (fun x => !containsAssignment orbit x)
   | false => rest.filter (fun x => !containsAssignment orbit x)).length<rest.length+1
  cases removed : containsAssignment orbit first with
  | true => exact Nat.lt_succ_of_le (bound rest)
  | false =>
   apply Nat.succ_lt_succ
   apply ih
   cases present with
   | head => rw [removed] at self; cases self
   | tail _ member => exact member
end SFT.Chemistry.ConformerOrbitProgress
