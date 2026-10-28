import SFT.Computation.BindingCorrespondence
namespace SFT.Computation.BindingLedger
open BindingTerms BindingSubstitution

-- Structural addresses retain each source abstraction's identity independently
-- of its string presentation; scope is nearest enclosing abstraction first.
inductive Edge where
 | left | right | body
 deriving DecidableEq
abbrev Address := List Edge
abbrev Scope := List (String × Address)
structure Occurrence where
  address : Address
  label : String
  binder : Option Address
 deriving DecidableEq

def resolve (scope : Scope) (name : String) : Option Address :=
 match scope with
 | [] => none
 | (binder,address)::rest => if binder = name then some address else resolve rest name

def ledger (scope : Scope) (address : Address) : Term → List Occurrence
 | .var name => [⟨address,name,resolve scope name⟩]
 | .app left right => ledger scope (address++[.left]) left ++ ledger scope (address++[.right]) right
 | .abs binder body => ledger ((binder,address)::scope) (address++[.body]) body

def variableCount : Term → Nat
 | .var _ => 1
 | .app left right => variableCount left + variableCount right
 | .abs _ body => variableCount body

theorem ledgerLength (term : Term) (scope : Scope) (address : Address) :
    (ledger scope address term).length = variableCount term := by
  induction term generalizing scope address with
  | var => rfl
  | app left right il ir =>
    change (ledger scope (address++[.left]) left ++ ledger scope (address++[.right]) right).length = _
    rw [SFT.Foundation.CommonRefinement.appendLength,il,ir]
    rfl
  | abs binder body ih => exact ih _ _

theorem resolveHeld (scope : Scope) (name : String) (address : Address) :
    resolve ((name,address)::scope) name = some address := by
  rw [resolve,if_pos rfl]

theorem resolveOther (scope : Scope) (name binder : String) (address : Address) (different : binder ≠ name) :
    resolve ((binder,address)::scope) name = resolve scope name := by
  rw [resolve,if_neg different]

theorem resolveRegistered (scope : Scope) (name : String) (address : Address)
    (h : resolve scope name = some address) : (name,address) ∈ scope := by
  induction scope with
  | nil => cases h
  | cons row rest ih =>
    obtain ⟨binder,location⟩ := row
    by_cases eq : binder = name
    · rw [resolve,if_pos eq] at h
      cases h; cases eq; exact .head _
    · rw [resolve,if_neg eq] at h
      exact .tail _ (ih h)

theorem resolveAbsent (scope : Scope) (name : String) :
    resolve scope name = none ↔ ∀ address, (name,address) ∉ scope := by
  induction scope with
  | nil =>
    constructor
    · intro _ address h; cases h
    · intro _; rfl
  | cons row rest ih =>
    obtain ⟨binder,location⟩ := row
    by_cases eq : binder = name
    · rw [resolve,if_pos eq]
      constructor
      · intro h; cases h
      · intro missing; exact False.elim (missing location (eq ▸ List.Mem.head rest))
    · rw [resolve,if_neg eq]
      constructor
      · intro h address member
        cases member with
        | head => exact eq rfl
        | tail _ hm => exact ih.mp h address hm
      · intro missing
        apply ih.mpr
        intro address hm
        exact missing address (.tail _ hm)

-- Exact source diagnostic: the fresh search excludes free names, not every
-- nested binder name. Preserve this behavior; do not silently repair V3.
def nestedSource : Term := .abs "y" (.abs "u" (.var "y"))
def nestedResult : Term := .abs "u" (.abs "u" (.var "u"))

theorem nestedSourceResult : substitute nestedSource "x" (.var "y") = .ok nestedResult := rfl

theorem originalBinderLedger : ledger [] [] nestedSource = [⟨[.body,.body],"y",some []⟩] := rfl

theorem resultingBinderLedger : ledger [] [] nestedResult = [⟨[.body,.body],"u",some [.body]⟩] := rfl

theorem differentHeldBinder : (some ([] : Address)) ≠ some [.body] := by
  intro h
  cases h

theorem sourceTargetAbsent : free nestedSource "x" = false := rfl

end SFT.Computation.BindingLedger
