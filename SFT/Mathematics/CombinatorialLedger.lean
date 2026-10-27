import SFT.Mathematics.ArrangementCompleteness
namespace SFT.Mathematics.CombinatorialLedger
open DiscreteObjects SFT.Foundation.Count.TraceDerivation
abbrev Ledger := List (String × List String)

-- Classifier results are the text labels after the source str(...) conversion.
def insertItem (ledger : Ledger) (label item : String) : Ledger :=
  match ledger with
  | [] => [(label,[item])]
  | (key,group)::rest => if key = label then (key,group ++ [item])::rest
      else (key,group)::insertItem rest label item

def ledgerRun (classify : String → String) (initial : Ledger) : List String → Ledger
  | [] => initial
  | item::rest => ledgerRun classify (insertItem initial (classify item) item) rest

def disjointClassLedger (items : List String) (classify : String → String) : Ledger :=
  ledgerRun classify [] items

def keys (ledger : Ledger) : List String := ledger.map Prod.fst

def lookup (ledger : Ledger) (label : String) : List String :=
  match ledger with
  | [] => []
  | (key,group)::rest => if key = label then group else lookup rest label

def flatten (ledger : Ledger) : List String := ledger.flatMap Prod.snd

theorem moveFrontToEnd {α : Type} (x : α) (xs : List α) : List.Perm (x::xs) (xs ++ [x]) := by
  induction xs with
  | nil => exact List.Perm.refl _
  | cons y ys ih => exact (List.Perm.swap y x ys).trans (List.Perm.cons y ih)

theorem insertionConserves (ledger : Ledger) (label item : String) :
    List.Perm (flatten (insertItem ledger label item)) (flatten ledger ++ [item]) := by
  induction ledger with
  | nil => exact List.Perm.refl _
  | cons entry rest ih =>
    obtain ⟨key,group⟩ := entry
    change List.Perm (flatten (if key = label then (key,group ++ [item])::rest
      else (key,group)::insertItem rest label item)) ((group ++ flatten rest) ++ [item])
    by_cases eq : key = label
    · rw [ite_eq_left eq]
      change List.Perm ((group ++ [item]) ++ flatten rest) ((group ++ flatten rest) ++ [item])
      rw [ExactTraceArithmetic.appendAssociative,ExactTraceArithmetic.appendAssociative]
      exact (List.Perm.refl group).append (moveFrontToEnd item (flatten rest))
    · rw [ite_eq_right eq]
      change List.Perm (group ++ flatten (insertItem rest label item)) ((group ++ flatten rest) ++ [item])
      rw [ExactTraceArithmetic.appendAssociative]
      exact (List.Perm.refl group).append ih

theorem ledgerRunConserves (classify : String → String) (items : List String) (initial : Ledger) :
    List.Perm (flatten (ledgerRun classify initial items)) (flatten initial ++ items) := by
  induction items generalizing initial with
  | nil =>
    change List.Perm (flatten initial) (flatten initial ++ [])
    have eq : flatten initial ++ [] = flatten initial := by
      induction flatten initial with
      | nil => rfl
      | cons x xs ih => exact congrArg (List.cons x) ih
    rw [eq]
  | cons item rest ih =>
    have first := ih (insertItem initial (classify item) item)
    have second := (insertionConserves initial (classify item) item).append (List.Perm.refl rest)
    have combined := first.trans second
    rw [ExactTraceArithmetic.appendAssociative] at combined
    exact combined

theorem ledgerConservesEveryOccurrence (items : List String) (classify : String → String) :
    List.Perm (flatten (disjointClassLedger items classify)) items := ledgerRunConserves classify items []

theorem ledgerCountConserved (items : List String) (classify : String → String) :
    (flatten (disjointClassLedger items classify)).length = items.length :=
  CombinatorialArrangements.permutationLength (ledgerConservesEveryOccurrence items classify)

theorem insertionKeys (ledger : Ledger) (label item : String) :
    keys (insertItem ledger label item) =
      if has (keys ledger) label then keys ledger else keys ledger ++ [label] := by
  induction ledger with
  | nil => rfl
  | cons entry rest ih =>
    obtain ⟨key,group⟩ := entry
    by_cases eq : key = label
    · change keys (if key = label then (key,group ++ [item])::rest
        else (key,group)::insertItem rest label item) =
        if (if key = label then true else has (keys rest) label) then key::keys rest else (key::keys rest) ++ [label]
      rw [ite_eq_left eq,ite_eq_left eq]
      rfl
    · change keys (if key = label then (key,group ++ [item])::rest
        else (key,group)::insertItem rest label item) =
        if (if key = label then true else has (keys rest) label) then key::keys rest else (key::keys rest) ++ [label]
      rw [ite_eq_right eq,ite_eq_right eq]
      change key::keys (insertItem rest label item) = _
      rw [ih]
      cases has (keys rest) label <;> rfl

theorem insertionPreservesUniqueKeys (ledger : Ledger) (label item : String)
    (unique : distinct (keys ledger) = true) : distinct (keys (insertItem ledger label item)) = true := by
  have eq := insertionKeys ledger label item
  cases present : has (keys ledger) label with
  | true => rw [present] at eq; rw [eq]; exact unique
  | false =>
    rw [present] at eq
    rw [eq]
    exact freshAppendDistinct (keys ledger) label unique present

theorem ledgerRunUniqueKeys (classify : String → String) (items : List String) (initial : Ledger)
    (unique : distinct (keys initial) = true) : distinct (keys (ledgerRun classify initial items)) = true := by
  induction items generalizing initial with
  | nil => exact unique
  | cons item rest ih => exact ih _ (insertionPreservesUniqueKeys initial (classify item) item unique)

theorem ledgerUniqueKeys (items : List String) (classify : String → String) :
    distinct (keys (disjointClassLedger items classify)) = true := ledgerRunUniqueKeys classify items [] rfl

theorem insertionLookup (ledger : Ledger) (label item target : String) :
    lookup (insertItem ledger label item) target =
      if label = target then lookup ledger target ++ [item] else lookup ledger target := by
  induction ledger with
  | nil =>
    change (if label = target then [item] else []) = (if label = target then [] ++ [item] else [])
    rfl
  | cons entry rest ih =>
    obtain ⟨key,group⟩ := entry
    by_cases keyLabel : key = label
    · change lookup (if key = label then (key,group ++ [item])::rest else (key,group)::insertItem rest label item) target = _
      rw [ite_eq_left keyLabel]
      cases keyLabel
      change (if label = target then group ++ [item] else lookup rest target) =
        (if label = target then (if label = target then group else lookup rest target) ++ [item]
          else (if label = target then group else lookup rest target))
      by_cases eq : label = target
      · rw [ite_eq_left eq,ite_eq_left eq,ite_eq_left eq]
      · rw [ite_eq_right eq,ite_eq_right eq,ite_eq_right eq]
    · change lookup (if key = label then (key,group ++ [item])::rest else (key,group)::insertItem rest label item) target = _
      rw [ite_eq_right keyLabel]
      change (if key = target then group else lookup (insertItem rest label item) target) =
        (if label = target then (if key = target then group else lookup rest target) ++ [item]
          else (if key = target then group else lookup rest target))
      by_cases keyTarget : key = target
      · have unequal : label ≠ target := fun eq => keyLabel (keyTarget.trans eq.symm)
        rw [ite_eq_left keyTarget,ite_eq_right unequal,ite_eq_left keyTarget]
      · rw [ite_eq_right keyTarget,ite_eq_right keyTarget]
        exact ih

theorem lookupRunStable (classify : String → String) (items : List String) (initial : Ledger)
    (target : String) : lookup (ledgerRun classify initial items) target =
      lookup initial target ++ items.filter (fun x => decide (classify x = target)) := by
  induction items generalizing initial with
  | nil =>
    change lookup initial target = lookup initial target ++ []
    induction lookup initial target with
    | nil => rfl
    | cons x xs ih => exact congrArg (List.cons x) ih
  | cons item rest ih =>
    change lookup (ledgerRun classify (insertItem initial (classify item) item) rest) target = _
    rw [ih,insertionLookup]
    by_cases eq : classify item = target
    · rw [ite_eq_left eq, List.filter_cons_of_pos (p := fun x => decide (classify x = target))
        (by exact decide_eq_true eq)]
      rw [ExactTraceArithmetic.appendAssociative]
      rfl
    · rw [ite_eq_right eq, List.filter_cons_of_neg (p := fun x => decide (classify x = target))
        (by intro h; exact eq (of_decide_eq_true h))]

theorem lookupExactClass (items : List String) (classify : String → String) (target : String) :
    lookup (disjointClassLedger items classify) target =
      items.filter (fun x => decide (classify x = target)) := lookupRunStable classify items [] target

theorem classMemberIff (items : List String) (classify : String → String) (target item : String) :
    item ∈ lookup (disjointClassLedger items classify) target ↔ item ∈ items ∧ classify item = target := by
  rw [lookupExactClass]
  constructor
  · intro h
    have parts := (filterMemberIff _ _ _).mp h
    exact ⟨parts.1,of_decide_eq_true parts.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem differentClassesDisjoint (items : List String) (classify : String → String)
    (first second : String) (different : first ≠ second) (item : String)
    (member : item ∈ lookup (disjointClassLedger items classify) first) :
    ¬ item ∈ lookup (disjointClassLedger items classify) second := by
  intro other
  have left := ((classMemberIff items classify first item).mp member).2
  have right := ((classMemberIff items classify second item).mp other).2
  exact different (left.symm.trans right)

theorem emptyLedger (classify : String → String) : disjointClassLedger [] classify = [] := rfl

end SFT.Mathematics.CombinatorialLedger
