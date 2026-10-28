import SFT.Computation.RecursionDerivation
namespace SFT.Computation.BindingTerms
-- The generated var/app/abs tuples of formx_001_022_laws_v1.py.
inductive Term where
 | var (name : String)
 | app (left right : Term)
 | abs (binder : String) (body : Term)
 deriving DecidableEq

-- Membership representation of the source finite set; no set order is added.
def free (term : Term) (name : String) : Bool :=
 match term with
 | .var label => decide (name = label)
 | .app left right => free left name || free right name
 | .abs binder body => if name = binder then false else free body name

def rename (term : Term) (old fresh : String) : Term :=
 match term with
 | .var label => .var (if label = old then fresh else label)
 | .app left right => .app (rename left old fresh) (rename right old fresh)
 | .abs binder body => .abs (if binder = old then fresh else binder) (rename body old fresh)

def size : Term → Nat
 | .var _ => 1
 | .app left right => size left + size right + 1
 | .abs _ body => size body + 1

inductive FreeOccurrence (name : String) : Term → Prop
 | variable : FreeOccurrence name (.var name)
 | left (a b) (h : FreeOccurrence name a) : FreeOccurrence name (.app a b)
 | right (a b) (h : FreeOccurrence name b) : FreeOccurrence name (.app a b)
 | abstraction (binder body) (different : name ≠ binder) (h : FreeOccurrence name body) :
     FreeOccurrence name (.abs binder body)

theorem freeMeaning (term : Term) (name : String) : free term name = true ↔ FreeOccurrence name term := by
  induction term with
  | var label =>
    constructor
    · intro h
      have eq : name = label := of_decide_eq_true h
      cases eq; exact .variable
    · intro h; cases h; exact decide_eq_true rfl
  | app left right il ir =>
    constructor
    · intro h
      cases hl : free left name <;> cases hr : free right name
      · rw [free,hl,hr] at h; cases h
      · exact .right _ _ (ir.mp hr)
      · exact .left _ _ (il.mp hl)
      · exact .left _ _ (il.mp hl)
    · intro h
      cases h with
      | left _ _ h => change (free left name || free right name) = true; rw [il.mpr h]; rfl
      | right _ _ h => change (free left name || free right name) = true; rw [ir.mpr h]; cases free left name <;> rfl
  | abs binder body ih =>
    constructor
    · intro h
      by_cases eq : name = binder
      · rw [free,if_pos eq] at h; cases h
      · rw [free,if_neg eq] at h; exact .abstraction _ _ eq (ih.mp h)
    · intro h
      cases h with
      | abstraction _ _ ne h => rw [free,if_neg ne]; exact ih.mpr h

theorem binderNotFree (binder : String) (body : Term) : free (.abs binder body) binder = false := by
  rw [free,if_pos rfl]

theorem renameSize (term : Term) (old fresh : String) : size (rename term old fresh) = size term := by
  induction term with
  | var => rfl
  | app left right il ir => change size (rename left old fresh) + size (rename right old fresh) + 1 = _; rw [il,ir]; rfl
  | abs binder body ih => change size (rename body old fresh) + 1 = _; rw [ih]; rfl

theorem renameIdentity (term : Term) (name : String) : rename term name name = term := by
  induction term with
  | var label =>
    unfold rename
    by_cases eq : label = name
    · rw [if_pos eq,eq]
    · rw [if_neg eq]
  | app left right il ir => change Term.app (rename left name name) (rename right name name) = _; rw [il,ir]
  | abs binder body ih =>
    change Term.abs (if binder = name then name else binder) (rename body name name) = _
    rw [ih]
    by_cases eq : binder = name
    · rw [if_pos eq,eq]
    · rw [if_neg eq]

-- Retain the source's exact four-name search, including exhaustion.
def available (body replacement : Term) (name candidate : String) : Bool :=
  !(free body candidate || free replacement candidate || decide (candidate = name))

def firstFresh (body replacement : Term) (name : String) : List String → Except String String
 | [] => .error "StopIteration"
 | candidate::rest => if available body replacement name candidate then .ok candidate else firstFresh body replacement name rest

def fresh (body replacement : Term) (name : String) : Except String String :=
  firstFresh body replacement name ["u","v","w","z"]

theorem firstFreshValid (body replacement : Term) (name : String) (candidates : List String) (result : String)
    (h : firstFresh body replacement name candidates = .ok result) :
    result ∈ candidates ∧ available body replacement name result = true := by
  induction candidates with
  | nil => cases h
  | cons candidate rest ih =>
    unfold firstFresh at h
    cases ha : available body replacement name candidate with
    | true => rw [ha] at h; cases h; exact ⟨.head _,ha⟩
    | false =>
      rw [ha] at h
      have p := ih h
      exact ⟨.tail _ p.1,p.2⟩

theorem availableMeaning (body replacement : Term) (name candidate : String) :
    available body replacement name candidate = true ↔
      free body candidate = false ∧ free replacement candidate = false ∧ candidate ≠ name := by
  unfold available
  by_cases eq : candidate = name
  · rw [decide_eq_true eq]
    constructor
    · intro h
      cases hb : free body candidate <;> cases hr : free replacement candidate <;> rw [hb,hr] at h <;> cases h
    · intro h
      exact False.elim (h.2.2 eq)
  · rw [decide_eq_false eq]
    cases hb : free body candidate <;> cases hr : free replacement candidate
    · exact ⟨fun _ => ⟨rfl,rfl,eq⟩,fun _ => rfl⟩
    · constructor
      · intro h; cases h
      · intro h; cases h.2.1
    · constructor
      · intro h; cases h
      · intro h; cases h.1
    · constructor
      · intro h; cases h
      · intro h; cases h.1

theorem freshBoundary (body replacement : Term) (name result : String)
    (h : fresh body replacement name = .ok result) :
    result ∈ ["u","v","w","z"] ∧ free body result = false ∧ free replacement result = false ∧ result ≠ name := by
  have p := firstFreshValid _ _ _ _ _ h
  exact ⟨p.1,(availableMeaning _ _ _ _).mp p.2⟩

end SFT.Computation.BindingTerms
