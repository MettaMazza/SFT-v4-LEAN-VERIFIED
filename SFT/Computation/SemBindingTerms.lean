import SFT.Computation.NameScope
namespace SFT.Computation.SemBindingTerms
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology

-- The explicitly generated SEMX tuple shapes. Value payloads are retained
-- parametrically because free_names and rename_bound never inspect them.
inductive Term (Value : Type) where
 | value : Value → Term Value
 | name : String → Term Value
 | join : Term Value → Term Value → Term Value
 | letE : String → Term Value → Term Value → Term Value
 | same : Term Value → Term Value → Term Value → Term Value → Term Value

def wellFormed {Value : Type} (bound : List String) : Term Value → Bool
 | .value _ => true
 | .name label => has bound label
 | .join left right => wellFormed bound left && wellFormed bound right
 | .letE binder value body => wellFormed bound value && wellFormed (bound++[binder]) body
 | .same left right yes no => ((wellFormed bound left && wellFormed bound right) && wellFormed bound yes) && wellFormed bound no

-- Boolean membership of the source frozenset; no ordering of a set is added.
def free {Value : Type} (bound : List String) (name : String) : Term Value → Bool
 | .value _ => false
 | .name label => !has bound label && decide (name = label)
 | .join left right => free bound name left || free bound name right
 | .letE binder value body => free bound name value || free (bound++[binder]) name body
 | .same left right yes no => ((free bound name left || free bound name right) || free bound name yes) || free bound name no

def rename {Value : Type} (old fresh : String) : Term Value → Term Value
 | .value value => .value value
 | .name label => .name (if label = old then fresh else label)
 | .join left right => .join (rename old fresh left) (rename old fresh right)
 | .letE binder value body => .letE (if binder = old then fresh else binder) (rename old fresh value) (rename old fresh body)
 | .same left right yes no => .same (rename old fresh left) (rename old fresh right) (rename old fresh yes) (rename old fresh no)

inductive Formation {Value : Type} : List String → Term Value → Prop where
 | value (bound value) : Formation bound (.value value)
 | name (bound label) : label ∈ bound → Formation bound (.name label)
 | join (bound left right) : Formation bound left → Formation bound right → Formation bound (.join left right)
 | letE (bound binder value body) : Formation bound value → Formation (bound++[binder]) body → Formation bound (.letE binder value body)
 | same (bound left right yes no) : Formation bound left → Formation bound right → Formation bound yes → Formation bound no → Formation bound (.same left right yes no)

theorem replay {Value : Type} (bound : List String) (term : Term Value) (proof : Formation bound term) :
    wellFormed bound term = true := by
  induction proof with
  | value => rfl
  | name bound label member => exact (hasIff _ _).mpr member
  | join bound left right hl hr il ir => exact (andTrue _ _).mpr ⟨il,ir⟩
  | letE bound binder value body hv hb iv ib => exact (andTrue _ _).mpr ⟨iv,ib⟩
  | same bound left right yes no hl hr hy hn il ir iy inn =>
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨il,ir⟩,iy⟩,inn⟩

theorem reconstruct {Value : Type} (bound : List String) (term : Term Value)
    (accepted : wellFormed bound term = true) : Formation bound term := by
  induction term generalizing bound with
  | value value => exact .value _ _
  | name label => exact .name _ _ ((hasIff _ _).mp accepted)
  | join left right il ir =>
    have h := (andTrue _ _).mp accepted
    exact .join _ _ _ (il _ h.1) (ir _ h.2)
  | letE binder value body iv ib =>
    have h := (andTrue _ _).mp accepted
    exact .letE _ _ _ _ (iv _ h.1) (ib _ h.2)
  | same left right yes no il ir iy inn =>
    have h := (andTrue _ _).mp accepted
    have j := (andTrue _ _).mp h.1
    have k := (andTrue _ _).mp j.1
    exact .same _ _ _ _ _ (il _ k.1) (ir _ k.2) (iy _ j.2) (inn _ h.2)

theorem formationMeaning {Value : Type} (bound : List String) (term : Term Value) :
    wellFormed bound term = true ↔ Formation bound term := ⟨reconstruct _ _,replay _ _⟩

theorem formedHasNoFreeName {Value : Type} (bound : List String) (term : Term Value)
    (proof : Formation bound term) (name : String) : free bound name term = false := by
  induction proof with
  | value => rfl
  | name bound label member => change (!has bound label && decide (name = label)) = false; rw [(hasIff _ _).mpr member]; rfl
  | join bound left right hl hr il ir => change (free bound name left || free bound name right) = false; rw [il,ir]; rfl
  | letE bound binder value body hv hb iv ib => change (free bound name value || free (bound++[binder]) name body) = false; rw [iv,ib]; rfl
  | same bound left right yes no hl hr hy hn il ir iy inn =>
    change (((free bound name left || free bound name right) || free bound name yes) || free bound name no) = false
    rw [il,ir,iy,inn]; rfl

theorem renameIdentity {Value : Type} (term : Term Value) (name : String) : rename name name term = term := by
  induction term with
  | value => rfl
  | name label =>
    unfold rename
    by_cases h : label = name
    · rw [ite_eq_left h,h]
    · rw [ite_eq_right h]
  | join left right il ir => change Term.join (rename name name left) (rename name name right) = _; rw [il,ir]
  | letE binder value body iv ib =>
    change Term.letE (if binder = name then name else binder) (rename name name value) (rename name name body) = _
    rw [iv,ib]
    by_cases h : binder = name
    · rw [ite_eq_left h,h]
    · rw [ite_eq_right h]
  | same left right yes no il ir iy inn => change Term.same (rename name name left) (rename name name right) (rename name name yes) (rename name name no) = _; rw [il,ir,iy,inn]

def available {Value : Type} (body replacement : Term Value) (name candidate : String) : Bool :=
  !(free [] candidate body || free [] candidate replacement || decide (candidate = name))

def firstFresh {Value : Type} (body replacement : Term Value) (name : String) : List String → Except String String
 | [] => .error "StopIteration"
 | candidate::rest => if available body replacement name candidate then .ok candidate else firstFresh body replacement name rest

def fresh {Value : Type} (body replacement : Term Value) (name : String) : Except String String :=
  firstFresh body replacement name ["u","v","w","z"]

theorem freshSelected {Value : Type} (body replacement : Term Value) (name : String) (candidates : List String) (selected : String)
    (accepted : firstFresh body replacement name candidates = .ok selected) :
    selected ∈ candidates ∧ available body replacement name selected = true := by
  induction candidates with
  | nil => cases accepted
  | cons candidate rest ih =>
    unfold firstFresh at accepted
    cases h : available body replacement name candidate with
    | true => rw [h] at accepted; cases accepted; exact ⟨List.Mem.head _,h⟩
    | false => rw [h] at accepted; obtain ⟨member,valid⟩ := ih accepted; exact ⟨List.Mem.tail _ member,valid⟩

theorem availableMeaning {Value : Type} (body replacement : Term Value) (name candidate : String) :
    available body replacement name candidate = true ↔
      free [] candidate body = false ∧ free [] candidate replacement = false ∧ candidate ≠ name := by
  unfold available
  cases hb : free [] candidate body <;> cases hr : free [] candidate replacement
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { cases h.1 }
  all_goals try { cases h.2.1 }
  · refine ⟨rfl,rfl,?_⟩
    intro eq; rw [decide_eq_true eq] at h; cases h
  · rw [decide_eq_false h.2.2]; rfl

theorem freshBoundary {Value : Type} (body replacement : Term Value) (name selected : String)
    (accepted : fresh body replacement name = .ok selected) :
    selected ∈ ["u","v","w","z"] ∧ free [] selected body = false ∧
      free [] selected replacement = false ∧ selected ≠ name := by
  have h := freshSelected _ _ _ _ _ accepted
  exact ⟨h.1,(availableMeaning _ _ _ _).mp h.2⟩

theorem exhausted {Value : Type} (body replacement : Term Value) (name : String) (candidates : List String) :
    firstFresh body replacement name candidates = .error "StopIteration" ↔
      ∀ candidate, candidate ∈ candidates → available body replacement name candidate = false := by
  induction candidates with
  | nil => constructor; intro h candidate member; cases member; intro h; rfl
  | cons candidate rest ih =>
    unfold firstFresh
    cases h : available body replacement name candidate with
    | true =>
      constructor
      · intro impossible; cases impossible
      · intro all; have no := all candidate (List.Mem.head _); rw [h] at no; cases no
    | false =>
      constructor
      · intro error value member
        cases member with
        | head => exact h
        | tail _ tail => exact ih.mp error value tail
      · intro all
        exact ih.mpr (fun value member => all value (List.Mem.tail candidate member))

end SFT.Computation.SemBindingTerms
