import SFT.Computation.SemSubstitution
namespace SFT.Computation.SemValueSubstitution
open SemBindingTerms SemSubstitution
open SFT.Foundation.Count.TraceDerivation

def replaceValue {Value : Type} (name : String) (value : Value) : Term Value → Term Value
 | .value v => .value v
 | .name label => if label = name then .value value else .name label
 | .join left right => .join (replaceValue name value left) (replaceValue name value right)
 | .same left right yes no => .same (replaceValue name value left) (replaceValue name value right) (replaceValue name value yes) (replaceValue name value no)
 | .letE binder initial body =>
   .letE binder (replaceValue name value initial) (if binder = name then body else replaceValue name value body)

-- V3 step enters substitution only after its initializer satisfies is_value.
theorem sourceAgreement {Value : Type} (term : Term Value) (name : String) (value : Value) :
    substitute term name (.value value) = .ok (replaceValue name value term) := by
  induction term with
  | value => rfl
  | name label =>
    rw [nameReplacement]
    by_cases h : label = name
    · rw [ite_eq_left h]; change _ = @Except.ok String (Term Value) (if label = name then _ else _); rw [ite_eq_left h]
    · rw [ite_eq_right h]; change _ = @Except.ok String (Term Value) (if label = name then _ else _); rw [ite_eq_right h]
  | join left right il ir => rw [joinEquation,il,ir]; rfl
  | same left right yes no il ir iy inn => rw [sameEquation,il,ir,iy,inn]; rfl
  | letE binder initial body ii ib =>
    by_cases h : binder = name
    · cases h
      rw [heldBinder,ii]
      change _ = @Except.ok String (Term Value) (.letE name (replaceValue name value initial) (if name = name then body else _))
      rw [ite_eq_left rfl]
      rfl
    · rw [nonconflictingBinder _ _ _ _ _ h rfl,ii,ib]
      change _ = @Except.ok String (Term Value) (.letE binder (replaceValue name value initial) (if binder = name then body else _))
      rw [ite_eq_right h]
      rfl

theorem scopeTransport {Value : Type} (source target : List String) (term : Term Value)
    (membership : ∀ label, label ∈ source → label ∈ target) (proof : Formation source term) : Formation target term := by
  induction proof generalizing target with
  | value => exact .value _ _
  | name source label member => exact .name _ _ (membership _ member)
  | join source left right hl hr il ir => exact .join _ _ _ (il _ membership) (ir _ membership)
  | letE source binder initial body hi hb ii ib =>
    apply Formation.letE
    · exact ii _ membership
    · apply ib
      intro label member
      cases memAppendCases _ _ _ member with
      | inl old => exact memAppendLeft _ _ _ (membership _ old)
      | inr new => exact memAppendRight _ _ _ new
  | same source left right yes no hl hr hy hn il ir iy inn =>
    exact .same _ _ _ _ _ (il _ membership) (ir _ membership) (iy _ membership) (inn _ membership)

theorem removeShadowDuplicate (bound : List String) (name label : String)
    (member : label ∈ (name::bound)++[name]) : label ∈ bound++[name] := by
  cases memAppendCases _ _ _ member with
  | inl old =>
    cases old with
    | head => exact memAppendRight _ _ _ (List.Mem.head _)
    | tail _ h => exact memAppendLeft _ _ _ h
  | inr new => exact memAppendRight _ _ _ new

theorem moveTargetToFront (bound : List String) (name binder label : String)
    (member : label ∈ (name::bound)++[binder]) : label ∈ name::(bound++[binder]) := by
  cases memAppendCases _ _ _ member with
  | inl old =>
    cases old with
    | head => exact List.Mem.head _
    | tail _ h => exact List.Mem.tail name (memAppendLeft _ _ _ h)
  | inr new => exact List.Mem.tail name (memAppendRight _ _ _ new)

theorem formationPreserved {Value : Type} (term : Term Value) (name : String) (value : Value) (bound : List String)
    (formed : Formation (name::bound) term) : Formation bound (replaceValue name value term) := by
  induction term generalizing bound with
  | value v => exact .value _ _
  | name label =>
    cases formed with
    | name _ _ member =>
      by_cases h : label = name
      · change Formation bound (if label = name then _ else _); rw [ite_eq_left h]; exact .value _ _
      · change Formation bound (if label = name then _ else _); rw [ite_eq_right h]
        cases member with
        | head => exact False.elim (h rfl)
        | tail _ old => exact .name _ _ old
  | join left right il ir =>
    cases formed with
    | join _ _ _ hl hr => exact .join _ _ _ (il _ hl) (ir _ hr)
  | same left right yes no il ir iy inn =>
    cases formed with
    | same _ _ _ _ _ hl hr hy hn => exact .same _ _ _ _ _ (il _ hl) (ir _ hr) (iy _ hy) (inn _ hn)
  | letE binder initial body ii ib =>
    cases formed with
    | letE _ _ _ _ hi hb =>
      change Formation bound (.letE binder (replaceValue name value initial) (if binder = name then body else replaceValue name value body))
      by_cases h : binder = name
      · cases h
        rw [ite_eq_left rfl]
        exact .letE _ _ _ _ (ii _ hi) (scopeTransport _ _ _ (removeShadowDuplicate bound name) hb)
      · rw [ite_eq_right h]
        exact .letE _ _ _ _ (ii _ hi) (ib _ (scopeTransport _ _ _ (moveTargetToFront bound name binder) hb))

theorem sourceFormation {Value : Type} (term : Term Value) (name : String) (value : Value) (bound : List String)
    (formed : wellFormed (name::bound) term = true) :
    ∃ result, substitute term name (.value value) = .ok result ∧ wellFormed bound result = true :=
  ⟨replaceValue name value term,sourceAgreement _ _ _,replay _ _ (formationPreserved _ _ _ _ (reconstruct _ _ formed))⟩

theorem noFreshSearchFailure {Value : Type} (term : Term Value) (name : String) (value : Value) (reason : String) :
    substitute term name (.value value) ≠ .error reason := by
  rw [sourceAgreement]
  intro impossible
  cases impossible

theorem boundNameNotFree {Value : Type} (term : Term Value) (bound : List String) (name : String)
    (held : name ∈ bound) : free bound name term = false := by
  induction term generalizing bound with
  | value => rfl
  | name label =>
    change (!SFT.Mathematics.DiscreteObjects.has bound label && decide (name = label)) = false
    by_cases h : name = label
    · cases h; rw [(SFT.Mathematics.DiscreteObjects.hasIff _ _).mpr held]; rfl
    · rw [decide_eq_false h]; exact Bool.and_false _
  | join left right il ir => change (free bound name left || free bound name right) = false; rw [il _ held,ir _ held]; rfl
  | same a b c d ia ib ic id =>
    change (((free bound name a || free bound name b) || free bound name c) || free bound name d) = false
    rw [ia _ held,ib _ held,ic _ held,id _ held]; rfl
  | letE binder initial body ii ib =>
    change (free bound name initial || free (bound++[binder]) name body) = false
    rw [ii _ held,ib _ (memAppendLeft _ _ _ held)]; rfl

theorem targetRemoved {Value : Type} (term : Term Value) (name : String) (value : Value) (bound : List String) :
    free bound name (replaceValue name value term) = false := by
  induction term generalizing bound with
  | value => rfl
  | name label =>
    unfold replaceValue
    by_cases h : label = name
    · rw [ite_eq_left h]; rfl
    · rw [ite_eq_right h]
      change (!SFT.Mathematics.DiscreteObjects.has bound label && decide (name = label)) = false
      rw [decide_eq_false (fun eq => h eq.symm)]; exact Bool.and_false _
  | join a b ia ib => change (free bound name (replaceValue name value a) || free bound name (replaceValue name value b)) = false; rw [ia,ib]; rfl
  | same a b c d ia ib ic id =>
    change (((free bound name (replaceValue name value a) || free bound name (replaceValue name value b)) || free bound name (replaceValue name value c)) || free bound name (replaceValue name value d)) = false
    rw [ia,ib,ic,id]; rfl
  | letE binder initial body ii ib =>
    unfold replaceValue
    by_cases h : binder = name
    · cases h; rw [ite_eq_left rfl]
      change (free bound name (replaceValue name value initial) || free (bound++[name]) name body) = false
      rw [ii,boundNameNotFree _ _ _ (memAppendRight _ _ _ (List.Mem.head _))]; rfl
    · rw [ite_eq_right h]
      change (free bound name (replaceValue name value initial) || free (bound++[binder]) name (replaceValue name value body)) = false
      rw [ii,ib]; rfl

theorem otherFreePreserved {Value : Type} (term : Term Value) (name other : String) (value : Value)
    (different : other ≠ name) (bound : List String) :
    free bound other (replaceValue name value term) = free bound other term := by
  induction term generalizing bound with
  | value => rfl
  | name label =>
    unfold replaceValue
    by_cases h : label = name
    · cases h; rw [ite_eq_left rfl]
      change false = (!SFT.Mathematics.DiscreteObjects.has bound name && decide (other = name))
      rw [decide_eq_false different,Bool.and_false]
    · rw [ite_eq_right h]
  | join a b ia ib =>
    change (free bound other (replaceValue name value a) || free bound other (replaceValue name value b)) = _
    rw [ia,ib]; rfl
  | same a b c d ia ib ic id =>
    change (((free bound other (replaceValue name value a) || free bound other (replaceValue name value b)) || free bound other (replaceValue name value c)) || free bound other (replaceValue name value d)) = _
    rw [ia,ib,ic,id]; rfl
  | letE binder initial body ii ib =>
    unfold replaceValue
    by_cases h : binder = name
    · rw [ite_eq_left h]
      change (free bound other (replaceValue name value initial) || free (bound++[binder]) other body) = _
      rw [ii]; rfl
    · rw [ite_eq_right h]
      change (free bound other (replaceValue name value initial) || free (bound++[binder]) other (replaceValue name value body)) = _
      rw [ii,ib]; rfl

inductive Edge where | left | right | initial | body | yes | no
abbrev BinderRow := List Edge × String

def liftBinder (edge : Edge) (row : BinderRow) : BinderRow := (edge::row.1,row.2)

def binderRows {Value : Type} : Term Value → List BinderRow
 | .value _ => []
 | .name _ => []
 | .join a b => (binderRows a).map (liftBinder .left) ++ (binderRows b).map (liftBinder .right)
 | .same a b c d => ((binderRows a).map (liftBinder .left) ++ (binderRows b).map (liftBinder .right)) ++
      ((binderRows c).map (liftBinder .yes) ++ (binderRows d).map (liftBinder .no))
 | .letE binder initial body => ([],binder)::((binderRows initial).map (liftBinder .initial) ++ (binderRows body).map (liftBinder .body))

theorem binderIdentitiesPreserved {Value : Type} (term : Term Value) (name : String) (value : Value) :
    binderRows (replaceValue name value term) = binderRows term := by
  induction term with
  | value => rfl
  | name label =>
    unfold replaceValue
    by_cases h : label = name
    · rw [ite_eq_left h]; rfl
    · rw [ite_eq_right h]
  | join a b ia ib =>
    change (binderRows (replaceValue name value a)).map (liftBinder .left) ++ (binderRows (replaceValue name value b)).map (liftBinder .right) = _
    rw [ia,ib]; rfl
  | same a b c d ia ib ic id =>
    change ((binderRows (replaceValue name value a)).map (liftBinder .left) ++ (binderRows (replaceValue name value b)).map (liftBinder .right)) ++ ((binderRows (replaceValue name value c)).map (liftBinder .yes) ++ (binderRows (replaceValue name value d)).map (liftBinder .no)) = _
    rw [ia,ib,ic,id]; rfl
  | letE binder initial body ii ib =>
    unfold replaceValue
    by_cases h : binder = name
    · rw [ite_eq_left h]
      change ([],binder)::((binderRows (replaceValue name value initial)).map (liftBinder .initial) ++ (binderRows body).map (liftBinder .body)) = _
      rw [ii]; rfl
    · rw [ite_eq_right h]
      change ([],binder)::((binderRows (replaceValue name value initial)).map (liftBinder .initial) ++ (binderRows (replaceValue name value body)).map (liftBinder .body)) = _
      rw [ii,ib]; rfl

def isValue {Value : Type} : Term Value → Bool
 | .value _ => true
 | .name _ => false
 | .join _ _ => false
 | .letE _ _ _ => false
 | .same _ _ _ _ => false

theorem valueShape {Value : Type} (term : Term Value) : isValue term = true ↔ ∃ value, term = .value value := by
  cases term with
  | value value => exact ⟨fun _ => ⟨value,rfl⟩,fun _ => rfl⟩
  | name label => constructor; intro h; cases h; intro ⟨v,h⟩; cases h
  | join a b => constructor; intro h; cases h; intro ⟨v,h⟩; cases h
  | letE binder v b => constructor; intro h; cases h; intro ⟨v,h⟩; cases h
  | same a b c d => constructor; intro h; cases h; intro ⟨v,h⟩; cases h

theorem evaluatorCallSafety {Value : Type} (body initial : Term Value) (binder : String)
    (ready : isValue initial = true) :
    ∃ result, substitute body binder initial = .ok result ∧
      binderRows result = binderRows body ∧ free [] binder result = false ∧
      ∀ other, other ≠ binder → free [] other result = free [] other body := by
  obtain ⟨value,same⟩ := (valueShape _).mp ready
  cases same
  exact ⟨replaceValue binder value body,sourceAgreement _ _ _,binderIdentitiesPreserved _ _ _,
    targetRemoved _ _ _ _,fun other different => otherFreePreserved _ _ _ _ different _⟩

end SFT.Computation.SemValueSubstitution
