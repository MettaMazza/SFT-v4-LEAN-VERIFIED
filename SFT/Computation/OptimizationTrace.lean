import SFT.Computation.DynamicProgrammingTrace
import SFT.Mathematics.OptimizationBounds
namespace SFT.Computation.OptimizationTrace
open SFT.Mathematics OptimizationSelection DiscreteObjects
open SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.ExactTraceArithmetic

-- The original full relation supplies every elimination row; no scoring rule.
def eliminators (preferred : Preference) (candidate : String) : Preference :=
  preferred.filter (fun row => decide (row.2 = candidate))

def comparisonLedger (feasible : List String) (preferred : Preference) : List (String × Preference) :=
  feasible.map (fun candidate => (candidate,eliminators preferred candidate))

def keep (preferred : Preference) (candidate : String) : Bool :=
  !has (preferred.map Prod.snd) candidate

def advance (preferred : Preference) (incumbent : List String) (candidate : String) : List String :=
  if keep preferred candidate then incumbent ++ [candidate] else incumbent

def scan (preferred : Preference) (incumbent : List String) : List String → List String
 | [] => incumbent
 | candidate :: rest => scan preferred (advance preferred incumbent candidate) rest

def history (preferred : Preference) (incumbent : List String) : List String → List (List String)
 | [] => [incumbent]
 | candidate :: rest => incumbent :: history preferred (advance preferred incumbent candidate) rest

theorem eliminationRow (preferred : Preference) (candidate better worse : String) :
    (better,worse) ∈ eliminators preferred candidate ↔ (better,worse) ∈ preferred ∧ worse = candidate := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem completeComparison (feasible : List String) (preferred : Preference) (candidate : String) :
    (candidate,eliminators preferred candidate) ∈ comparisonLedger feasible preferred ↔ candidate ∈ feasible := by
  constructor
  · intro h
    obtain ⟨source,held,same⟩ := memMapPreimage _ _ _ h
    have identity := congrArg Prod.fst same
    dsimp only at identity; cases identity; exact held
  · intro h; exact memMap _ _ _ h

theorem traversalIdentities (feasible : List String) (preferred : Preference) :
    (comparisonLedger feasible preferred).map Prod.fst = feasible := by
  induction feasible with
  | nil => rfl
  | cons head rest ih => exact congrArg (List.cons head) ih

theorem appendIdentity (xs : List String) : xs ++ [] = xs := by
  induction xs with
  | nil => rfl
  | cons x rest ih => exact congrArg (List.cons x) ih

theorem scanReconstruction (preferred : Preference) (feasible incumbent : List String) :
    scan preferred incumbent feasible = incumbent ++ retained feasible preferred := by
  induction feasible generalizing incumbent with
  | nil => exact (appendIdentity incumbent).symm
  | cons candidate rest ih =>
    change scan preferred (advance preferred incumbent candidate) rest =
      incumbent ++ ((candidate :: rest).filter (keep preferred))
    cases decision : keep preferred candidate with
    | true =>
      rw [List.filter_cons_of_pos (p := keep preferred) decision]
      unfold advance; rw [decision]
      exact (ih _).trans (appendAssociative _ _ _)
    | false =>
      rw [List.filter_cons_of_neg (p := keep preferred) (by rw [decision]; intro h; cases h)]
      unfold advance; rw [decision]; exact ih _

theorem allOptima (preferred : Preference) (feasible : List String) :
    scan preferred [] feasible = retained feasible preferred := scanReconstruction _ _ _

theorem survivorCertificate (preferred : Preference) (feasible : List String) (candidate : String) :
    candidate ∈ scan preferred [] feasible ↔ candidate ∈ feasible ∧ ∀ better, ¬ (better,candidate) ∈ preferred := by
  rw [allOptima]; exact retainedMembership _ _ _

theorem eliminationCertificate (preferred : Preference) (feasible : List String) (candidate : String)
    (valid : preferenceValid feasible preferred = true) (held : candidate ∈ feasible)
    (gone : ¬ candidate ∈ scan preferred [] feasible) :
    ∃ better, better ∈ feasible ∧ (better,candidate) ∈ eliminators preferred candidate ∧ better ≠ candidate := by
  rw [allOptima] at gone
  obtain ⟨better,member,pair,different⟩ := eliminatedWitness _ _ _ valid held gone
  exact ⟨better,member,(eliminationRow _ _ _ _).mpr ⟨pair,rfl⟩,different⟩

inductive Trace (preferred : Preference) : List String → List String → List (List String) → Prop where
 | base (incumbent) : Trace preferred incumbent [] [incumbent]
 | next (incumbent candidate rest states)
     (tail : Trace preferred (advance preferred incumbent candidate) rest states) :
     Trace preferred incumbent (candidate :: rest) (incumbent :: states)

theorem completeHistory (preferred : Preference) (feasible incumbent : List String) :
    Trace preferred incumbent feasible (history preferred incumbent feasible) := by
  induction feasible generalizing incumbent with
  | nil => exact .base _
  | cons candidate rest ih => exact .next _ _ _ _ (ih _)

theorem historyReplay (preferred : Preference) (feasible incumbent : List String) (states : List (List String))
    (trace : Trace preferred incumbent feasible states) : history preferred incumbent feasible = states := by
  induction trace with
  | base => rfl
  | next incumbent candidate rest states tail ih => exact congrArg (List.cons incumbent) ih

theorem historyCount (preferred : Preference) (feasible incumbent : List String) :
    (history preferred incumbent feasible).length = feasible.length + 1 := by
  induction feasible generalizing incumbent with
  | nil => rfl
  | cons candidate rest ih => exact congrArg Nat.succ (ih _)

theorem scanComposition (preferred : Preference) (first second incumbent : List String) :
    scan preferred incumbent (first ++ second) = scan preferred (scan preferred incumbent first) second := by
  induction first generalizing incumbent with
  | nil => rfl
  | cons candidate rest ih => exact ih _

theorem successor (preferred : Preference) (feasible incumbent : List String) (fresh : String) :
    scan preferred incumbent (feasible ++ [fresh]) = advance preferred (scan preferred incumbent feasible) fresh :=
  scanComposition _ _ _ _

theorem incumbentAtPrefix (preferred : Preference) (first second : List String) :
    history preferred [] (first ++ second) =
      (history preferred [] first).dropLast ++ history preferred (retained first preferred) second := by
  have step (first second incumbent : List String) :
      history preferred incumbent (first ++ second) =
        (history preferred incumbent first).dropLast ++ history preferred (scan preferred incumbent first) second := by
    induction first generalizing incumbent with
    | nil => rfl
    | cons candidate rest ih =>
      cases rest with
      | nil => rfl
      | cons next more => exact congrArg (List.cons incumbent) (ih _)
  rw [← allOptima preferred first]; exact step _ _ _

theorem exactSourceResult (feasible : List String) (preferred : Preference)
    (nonempty : feasible.isEmpty = false) (valid : preferenceValid feasible preferred = true) :
    exactOptimum feasible preferred = .ok (classifyOptimum (scan preferred [] feasible)) := by
  rw [allOptima]
  exact exactOptimumResult _ _ _ (undominatedAdmitted _ _ nonempty valid)

theorem noTieBreak (feasible : List String) (preferred : Preference) (first second : String)
    (left : first ∈ feasible) (right : second ∈ feasible)
    (one : ∀ better, ¬ (better,first) ∈ preferred) (two : ∀ better, ¬ (better,second) ∈ preferred) :
    first ∈ scan preferred [] feasible ∧ second ∈ scan preferred [] feasible :=
  ⟨(survivorCertificate _ _ _).mpr ⟨left,one⟩,(survivorCertificate _ _ _).mpr ⟨right,two⟩⟩

theorem uniqueOnlySingleton (feasible : List String) (preferred : Preference) (candidate : String) :
    classifyOptimum (scan preferred [] feasible) = .unique candidate ↔ scan preferred [] feasible = [candidate] :=
  classifyUniqueIff _ _

theorem oneBase (candidate : String) : scan [] [] [candidate] = [candidate] := rfl
theorem extendedSelection (old added : Preference) (feasible fresh : List String) (candidate : String) :
    candidate ∈ scan (old ++ added) [] (feasible ++ fresh) ↔
      (candidate ∈ feasible ∨ candidate ∈ fresh) ∧
      (∀ better, ¬ (better,candidate) ∈ old) ∧ (∀ better, ¬ (better,candidate) ∈ added) := by
  constructor
  · intro h
    have p := (survivorCertificate _ _ _).mp h
    exact ⟨memAppendCases _ _ _ p.1,
      fun better held => p.2 better (memAppendLeft _ _ _ held),
      fun better held => p.2 better (memAppendRight _ _ _ held)⟩
  · intro h
    apply (survivorCertificate _ _ _).mpr
    constructor
    · cases h.1 with
      | inl held => exact memAppendLeft _ _ _ held
      | inr held => exact memAppendRight _ _ _ held
    · intro better held
      cases memAppendCases _ _ _ held with
      | inl prior => exact h.2.1 better prior
      | inr added => exact h.2.2 better added

theorem priorEliminationNeedsNewWitness (old added : Preference) (feasible fresh : List String) (candidate : String)
    (valid : preferenceValid (feasible ++ fresh) (old ++ added) = true)
    (prior : candidate ∈ scan old [] feasible)
    (gone : ¬ candidate ∈ scan (old ++ added) [] (feasible ++ fresh)) :
    ∃ better, better ∈ feasible ++ fresh ∧ (better,candidate) ∈ added ∧ better ≠ candidate := by
  have p := (survivorCertificate _ _ _).mp prior
  have absent : ¬ candidate ∈ retained (feasible ++ fresh) (old ++ added) := by
    rw [← allOptima]; exact gone
  obtain ⟨better,held,pair,different⟩ := eliminatedWitness _ _ _ valid (memAppendLeft _ _ _ p.1) absent
  cases memAppendCases _ _ _ pair with
  | inl existing => exact False.elim (p.2 better existing)
  | inr newRow => exact ⟨better,held,newRow,different⟩

end SFT.Computation.OptimizationTrace
