import SFT.Mathematics.GeometryTopology
import SFT.Foundation.ExactOperations
import SFT.Mathematics.CombinatorialArrangements
namespace SFT.Mathematics.ProbabilityEvents
open DiscreteObjects SFT.Foundation.ExactOperations

-- Original order and labels are retained, including the literal empty-One marker.
def exactEvent (support held : List String) : Except String (List String) :=
  if support.isEmpty || !distinct support then
    .error "support must be a complete nonempty canonical trace"
  else if !distinct held || held.any (fun state => !has support state) then
    .error "event must be a duplicate-free held support selection"
  else .ok (if held.isEmpty then emptyOne else held)

theorem eventResult (support held event : List String) (success : exactEvent support held = .ok event) :
    event = (if held.isEmpty then emptyOne else held) := by
  unfold exactEvent at success
  split at success
  · cases success
  · split at success
    · cases success
    · exact (Except.ok.inj success).symm

theorem eventSupportPositive (support held event : List String) (success : exactEvent support held = .ok event) :
    0 < support.length := by
  cases support with
  | nil => unfold exactEvent at success; cases success
  | cons first rest => exact Nat.zero_lt_succ _

theorem eventHeldPositive (support held event : List String) (success : exactEvent support held = .ok event)
    (notMarker : (event == emptyOne) ≠ true) : 0 < held.length := by
  cases held with
  | nil =>
    have same := eventResult support [] event success
    change event = emptyOne at same
    cases same
    exact False.elim (notMarker rfl)
  | cons first rest => exact Nat.zero_lt_succ _

abbrev Weight := Sum (List String) PositiveFraction

def exactWeight (support held : List String) : Except String Weight :=
  match success : exactEvent support held with
  | .error message => .error message
  | .ok event =>
    if marker : (event == emptyOne) = true then .ok (.inl emptyOne)
    else .ok (.inr (normalizePositive held.length support.length
      (eventHeldPositive support held event success marker) (eventSupportPositive support held event success)))

def commonEvent (support event condition : List String) : List String :=
  support.filter (fun state => has event state && has condition state)

def conditionalWeight (support event condition : List String) : Except String Weight :=
  match exactEvent support event with
  | .error message => .error message
  | .ok _ =>
    match success : exactEvent support condition with
    | .error message => .error message
    | .ok conditionForm =>
      if marker : (conditionForm == emptyOne) = true then .ok (.inl emptyOne)
      else match commonEvent support event condition with
        | [] => .ok (.inl emptyOne)
        | first :: rest => .ok (.inr (normalizePositive (rest.length+1) condition.length
          (Nat.zero_lt_succ _) (eventHeldPositive support condition conditionForm success marker)))

theorem eventAdmitted (support held : List String)
    (supportGuard : (support.isEmpty || !distinct support) = false)
    (heldGuard : (!distinct held || held.any (fun state => !has support state)) = false) :
    exactEvent support held = .ok (if held.isEmpty then emptyOne else held) := by
  unfold exactEvent
  rw [supportGuard,heldGuard]
  rfl

theorem eventRejectsSupport (support held : List String)
    (invalid : (support.isEmpty || !distinct support) = true) :
    exactEvent support held = .error "support must be a complete nonempty canonical trace" := by
  unfold exactEvent
  rw [invalid]
  rfl

theorem weightRetainsEventError (support held : List String) (message : String)
    (failed : exactEvent support held = .error message) : exactWeight support held = .error message := by
  unfold exactWeight
  split
  · rename_i other equation
    rw [failed] at equation
    cases equation
    rfl
  · rename_i event equation
    rw [failed] at equation
    cases equation

theorem weightMarker (support held : List String) (accepted : exactEvent support held = .ok emptyOne) :
    exactWeight support held = .ok (.inl emptyOne) := by
  unfold exactWeight
  split
  · rename_i message equation
    rw [accepted] at equation
    cases equation
  · rename_i event equation
    rw [accepted] at equation
    cases equation
    rfl

theorem emptyEventWeight (support : List String)
    (valid : (support.isEmpty || !distinct support) = false) : exactWeight support [] = .ok (.inl emptyOne) :=
  weightMarker support [] (eventAdmitted support [] valid rfl)

theorem literalMarkerWeight (support : List String)
    (accepted : exactEvent support emptyOne = .ok emptyOne) :
    exactWeight support emptyOne = .ok (.inl emptyOne) := weightMarker support emptyOne accepted

theorem weightAdmittedValue (support held event : List String)
    (accepted : exactEvent support held = .ok event) (notMarker : (event == emptyOne) ≠ true) :
    exactWeight support held = .ok (.inr (normalizePositive held.length support.length
      (eventHeldPositive support held event accepted notMarker) (eventSupportPositive support held event accepted))) := by
  unfold exactWeight
  split
  · rename_i message equation
    rw [accepted] at equation
    cases equation
  · rename_i result equation
    rw [accepted] at equation
    cases equation
    rw [dite_eq_right notMarker]

theorem weightExactRatio (support held : List String) (fraction : PositiveFraction)
    (success : exactWeight support held = .ok (.inr fraction)) :
    held.length * fraction.denominator = fraction.numerator * support.length := by
  unfold exactWeight at success
  split at success
  · cases success
  · rename_i event accepted
    split at success
    · cases success
    · cases success
      exact normalizedValuePreserved _ _ _ _

theorem weightPositive (support held : List String) (fraction : PositiveFraction)
    (_success : exactWeight support held = .ok (.inr fraction)) : 0 < fraction.numerator := fraction.positive

theorem weightReduced (support held : List String) (fraction : PositiveFraction)
    (_success : exactWeight support held = .ok (.inr fraction)) : fraction.numerator.Coprime fraction.denominator := fraction.reduced

theorem commonEventMembership (support event condition : List String) (state : String) :
    state ∈ commonEvent support event condition ↔ state ∈ support ∧ state ∈ event ∧ state ∈ condition := by
  constructor
  · intro member
    have parts := (filterMemberIff _ _ _).mp member
    have both := (GeometryTopology.andTrue _ _).mp parts.2
    exact ⟨parts.1,(hasIff _ _).mp both.1,(hasIff _ _).mp both.2⟩
  · intro parts
    apply (filterMemberIff _ _ _).mpr
    exact ⟨parts.1,(GeometryTopology.andTrue _ _).mpr ⟨(hasIff _ _).mpr parts.2.1,(hasIff _ _).mpr parts.2.2⟩⟩

theorem conditionalRetainsFirstError (support event condition : List String) (message : String)
    (failed : exactEvent support event = .error message) : conditionalWeight support event condition = .error message := by
  unfold conditionalWeight
  rw [failed]

theorem conditionalExactRatio (support event condition : List String) (fraction : PositiveFraction)
    (success : conditionalWeight support event condition = .ok (.inr fraction)) :
    (commonEvent support event condition).length * fraction.denominator = fraction.numerator * condition.length := by
  unfold conditionalWeight at success
  split at success
  · cases success
  · split at success
    · cases success
    · split at success
      · cases success
      · split at success
        · cases success
        · rename_i first rest shape
          cases success
          rw [shape]
          exact normalizedValuePreserved _ _ _ _

theorem eventGuards (support held event : List String) (success : exactEvent support held = .ok event) :
    (support.isEmpty || !distinct support) = false ∧
    (!distinct held || held.any (fun state => !has support state)) = false := by
  unfold exactEvent at success
  cases hs : support.isEmpty || !distinct support with
  | true => rw [hs] at success; cases success
  | false =>
    rw [hs] at success
    cases hh : !distinct held || held.any (fun state => !has support state) with
    | true => rw [hh] at success; cases success
    | false => exact ⟨rfl,rfl⟩

theorem eventHeldDistinct (support held event : List String) (success : exactEvent support held = .ok event) :
    distinct held = true := by
  have guard := (eventGuards support held event success).2
  cases unique : distinct held with
  | true => rfl
  | false => rw [unique] at guard; cases guard

theorem eventHeldContained (support held event : List String) (success : exactEvent support held = .ok event) :
    ∀ state, state ∈ held → state ∈ support := by
  have guard := (eventGuards support held event success).2
  have noOutside : held.any (fun state => !has support state) = false := by
    cases outside : held.any (fun state => !has support state) with
    | false => rfl
    | true => rw [outside] at guard; cases hd : distinct held <;> rw [hd] at guard <;> cases guard
  intro state member
  have no := anyFalseAtMember (fun state => !has support state) held noOutside state member
  cases found : has support state with
  | true => exact (hasIff _ _).mp found
  | false => rw [found] at no; cases no

theorem distinctSubsetLength (held support : List String) (unique : distinct held = true)
    (contained : ∀ state, state ∈ held → state ∈ support) : held.length ≤ support.length := by
  induction held generalizing support with
  | nil => exact Nat.zero_le _
  | cons first rest ih =>
    have parts := (distinctCons first rest).mp unique
    have shorter := CombinatorialArrangements.remainderShorter support first (contained first (List.Mem.head rest))
    have bound := ih (CombinatorialArrangements.remainder support first) parts.2 (by
      intro state member
      apply (CombinatorialArrangements.remainderMemberIff support first state).mpr
      refine ⟨contained state (List.Mem.tail first member),?_⟩
      intro same
      cases same
      exact (absentIff rest first).mp parts.1 member)
    exact Nat.succ_le_of_lt (Nat.lt_of_le_of_lt bound shorter)

theorem eventPartBound (support held event : List String) (success : exactEvent support held = .ok event) :
    held.length ≤ support.length := distinctSubsetLength held support
      (eventHeldDistinct support held event success) (eventHeldContained support held event success)

theorem weightThroughOne (support held : List String) (fraction : PositiveFraction)
    (success : exactWeight support held = .ok (.inr fraction)) : fraction.numerator ≤ fraction.denominator := by
  unfold exactWeight at success
  split at success
  · cases success
  · rename_i event accepted
    split at success
    · cases success
    · cases success
      exact normalizedThroughOne _ _ _ _ (eventPartBound support held event accepted)

theorem eventSupportDistinct (support held event : List String) (success : exactEvent support held = .ok event) :
    distinct support = true := by
  have guard := (eventGuards support held event success).1
  cases unique : distinct support with
  | true => rfl
  | false => rw [unique] at guard; cases empty : support.isEmpty <;> rw [empty] at guard <;> cases guard

theorem commonEventBound (support event condition : List String) (unique : distinct support = true) :
    (commonEvent support event condition).length ≤ condition.length := by
  apply distinctSubsetLength
  · exact filterDistinct _ support unique
  · intro state member
    exact ((commonEventMembership support event condition state).mp member).2.2

theorem conditionalThroughOne (support event condition : List String) (fraction : PositiveFraction)
    (success : conditionalWeight support event condition = .ok (.inr fraction)) :
    fraction.numerator ≤ fraction.denominator := by
  unfold conditionalWeight at success
  split at success
  · cases success
  · rename_i eventForm eventAccepted
    split at success
    · cases success
    · split at success
      · cases success
      · split at success
        · cases success
        · rename_i first rest shape
          cases success
          apply normalizedThroughOne
          have bound := commonEventBound support event condition (eventSupportDistinct support event eventForm eventAccepted)
          rw [shape] at bound
          exact bound

end SFT.Mathematics.ProbabilityEvents


