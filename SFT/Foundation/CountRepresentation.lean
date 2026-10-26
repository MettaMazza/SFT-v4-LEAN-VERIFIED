import SFT.Foundation.CountTrace
/-! count.py completeness_record and survives: derive the source relation class
from retained generated positions, preserving multiplicity, and the source's
independent has-extra/no-extra relation. The extra flag is a source relation,
not an additional fitted parameter. -/
namespace SFT.Foundation.Count.Representation
open TraceDerivation

theorem orTrue (a b : Bool) : (a || b) = true ↔ a = true ∨ b = true := by
  cases a <;> cases b <;> decide

theorem orFalse (a b : Bool) : (a || b) = false ↔ a = false ∧ b = false := by
  cases a <;> cases b <;> decide

theorem andTrue (a b : Bool) : (a && b) = true ↔ a = true ∧ b = true := by
  cases a <;> cases b <;> decide

def equalPosition : {t : Trace} → Position t → Position t → Bool
  | .base, .base, .base => true
  | .extend _, .prior a, .prior b => equalPosition a b
  | .extend _, .terminal, .terminal => true
  | .extend _, .prior _, .terminal => false
  | .extend _, .terminal, .prior _ => false

theorem equalPositionRefl {t : Trace} (a : Position t) : equalPosition a a = true := by
  induction a with
  | base => rfl
  | prior a ih => exact ih
  | terminal => rfl

theorem equalPositionSound {t : Trace} (a b : Position t)
    (h : equalPosition a b = true) : a = b := by
  induction a with
  | base => cases b; rfl
  | prior a ih =>
    cases b with
    | prior b => exact congrArg Position.prior (ih b h)
    | terminal => cases h
  | terminal =>
    cases b with
    | prior b => cases h
    | terminal => rfl

def containsPosition {t : Trace} (p : Position t) : List (Position t) → Bool
  | [] => false
  | x::xs => equalPosition p x || containsPosition p xs

theorem containsIffMember {t : Trace} (p : Position t) (xs : List (Position t)) :
    containsPosition p xs = true ↔ p ∈ xs := by
  induction xs with
  | nil => constructor <;> intro h <;> cases h
  | cons x xs ih =>
    constructor
    · intro h
      cases (orTrue _ _).mp h with
      | inl eq =>
        have e := equalPositionSound p x eq
        cases e
        exact List.Mem.head _
      | inr tail => exact List.Mem.tail _ (ih.mp tail)
    · intro h
      cases h with
      | head => exact (orTrue _ _).mpr (Or.inl (equalPositionRefl p))
      | tail _ hp => exact (orTrue _ _).mpr (Or.inr (ih.mpr hp))

theorem containsFalseIffAbsent {t : Trace} (p : Position t) (xs : List (Position t)) :
    containsPosition p xs = false ↔ p ∉ xs := by
  constructor
  · intro h member
    have yes := (containsIffMember p xs).mpr member
    exact Bool.noConfusion (h.symm.trans yes)
  · intro absent
    cases h : containsPosition p xs with
    | false => rfl
    | true => exact False.elim (absent ((containsIffMember p xs).mp h))

def duplicated {t : Trace} : List (Position t) → Bool
  | [] => false
  | x::xs => containsPosition x xs || duplicated xs

theorem duplicatedFalseIffNodup {t : Trace} (xs : List (Position t)) :
    duplicated xs = false ↔ xs.Nodup := by
  induction xs with
  | nil => exact ⟨fun _ => List.Pairwise.nil, fun _ => rfl⟩
  | cons x xs ih =>
    constructor
    · intro h
      have parts := (orFalse _ _).mp h
      apply List.Pairwise.cons
      · intro y hy eq
        cases eq
        exact (containsFalseIffAbsent x xs).mp parts.1 hy
      · exact ih.mp parts.2
    · intro h
      cases h with
      | cons distinct rest =>
        exact (orFalse _ _).mpr ⟨(containsFalseIffAbsent x xs).mpr
          (fun hx => distinct x hx rfl), ih.mpr rest⟩

def coversAll (t : Trace) (xs : List (Position t)) : Bool :=
  (complete t).all (fun p => containsPosition p xs)

theorem allContainsIff {t : Trace} (ps xs : List (Position t)) :
    ps.all (fun p => containsPosition p xs) = true ↔ ∀ p, p ∈ ps → p ∈ xs := by
  induction ps with
  | nil =>
    constructor
    · intro _ _ h; cases h
    · intro _; rfl
  | cons p ps ih =>
    constructor
    · intro h q member
      have parts := (andTrue _ _).mp h
      cases member with
      | head => exact (containsIffMember p xs).mp parts.1
      | tail _ hq => exact ih.mp parts.2 q hq
    · intro all
      exact (andTrue _ _).mpr ⟨(containsIffMember p xs).mpr (all p (List.Mem.head _)),
        ih.mpr (fun q hq => all q (List.Mem.tail _ hq))⟩

theorem coversAllIffCompleteCoverage (t : Trace) (xs : List (Position t)) :
    coversAll t xs = true ↔ ∀ p : Position t, p ∈ xs :=
  ⟨fun h p => (allContainsIff (complete t) xs).mp h p (everyGeneratedPositionRetained t p),
   fun h => (allContainsIff (complete t) xs).mpr (fun p _ => h p)⟩

def classifyFlags (nonempty complete duplicate extra : Bool) : Candidate :=
  if !nonempty then if extra then .c1 else .c0
  else if complete then
    if duplicate then if extra then .c9 else .c8
    else if extra then .c7 else .c6
  else if duplicate then if extra then .c5 else .c4
    else if extra then .c3 else .c2

def classify (t : Trace) (xs : List (Position t)) (hasExtra : Bool) : Candidate :=
  classifyFlags (!xs.isEmpty) (coversAll t xs) (duplicated xs) hasExtra

theorem classificationExhaustive (t : Trace) (xs : List (Position t)) (hasExtra : Bool) :
    classify t xs hasExtra ∈ candidates := candidatesComplete _

theorem flagSurvivalExact (nonempty complete duplicate extra : Bool) :
    survives (classifyFlags nonempty complete duplicate extra) = true ↔
    nonempty = true ∧ complete = true ∧ duplicate = false ∧ extra = false := by
  cases nonempty <;> cases complete <;> cases duplicate <;> cases extra <;> decide

theorem nonemptyOfCompleteCoverage (t : Trace) (xs : List (Position t))
    (h : ∀ p : Position t, p ∈ xs) : (!xs.isEmpty) = true := by
  cases xs with
  | cons p ps => rfl
  | nil =>
    cases t with
    | base => have impossible := h Position.base; cases impossible
    | extend t => have impossible := h Position.terminal; cases impossible

theorem acceptedIffExactRetention (t : Trace) (xs : List (Position t)) (hasExtra : Bool) :
    survives (classify t xs hasExtra) = true ↔
      (∀ p : Position t, p ∈ xs) ∧ xs.Nodup ∧ hasExtra = false := by
  constructor
  · intro h
    have flags := (flagSurvivalExact _ _ _ _).mp h
    exact ⟨(coversAllIffCompleteCoverage t xs).mp flags.2.1,
      (duplicatedFalseIffNodup xs).mp flags.2.2.1,flags.2.2.2⟩
  · intro h
    exact (flagSurvivalExact _ _ _ _).mpr ⟨nonemptyOfCompleteCoverage t xs h.1,
      (coversAllIffCompleteCoverage t xs).mpr h.1,
      (duplicatedFalseIffNodup xs).mpr h.2.1,h.2.2⟩

theorem completeTraceAccepted (t : Trace) : survives (classify t (complete t) false) = true :=
  (acceptedIffExactRetention t (complete t) false).mpr
    ⟨everyGeneratedPositionRetained t,everyGeneratedPositionRetainedOnce t,rfl⟩

theorem omittedPositionRejected (t : Trace) (xs : List (Position t)) (hasExtra : Bool)
    (p : Position t) (missing : p ∉ xs) : survives (classify t xs hasExtra) ≠ true := by
  intro h
  exact missing (((acceptedIffExactRetention t xs hasExtra).mp h).1 p)

theorem duplicatedRetentionRejected (t : Trace) (xs : List (Position t)) (hasExtra : Bool)
    (repeated : ¬ xs.Nodup) : survives (classify t xs hasExtra) ≠ true := by
  intro h
  exact repeated ((acceptedIffExactRetention t xs hasExtra).mp h).2.1

theorem ungeneratedAdditionRejected (t : Trace) (xs : List (Position t)) :
    survives (classify t xs true) ≠ true := by
  intro h
  exact Bool.noConfusion ((acceptedIffExactRetention t xs true).mp h).2.2

theorem previousPrefixRejected (t : Trace) :
    survives (classify (.extend t) (previous (complete t)) false) ≠ true :=
  omittedPositionRejected _ _ _ Position.terminal (terminalAbsentFromPrevious _)

theorem retainedTraceHasSourceSurvivor (t : Trace) : classify t (complete t) false = survivor :=
  (uniqueSurvivor _).mp (completeTraceAccepted t)

-- Source completeness relation: a proposed occurrence either belongs to the
-- registered trace or is ungenerated extra material. The latter marker records
-- only the source relation; no extra object's content is inspected by Count.
inductive ProposedOccurrence (t : Trace) where
  | generated : Position t → ProposedOccurrence t
  | ungenerated : ProposedOccurrence t

def retained {t : Trace} : List (ProposedOccurrence t) → List (Position t)
  | [] => []
  | .generated p :: xs => p :: retained xs
  | .ungenerated :: xs => retained xs

def hasUngenerated {t : Trace} : List (ProposedOccurrence t) → Bool
  | [] => false
  | .generated _ :: xs => hasUngenerated xs
  | .ungenerated :: _ => true

def classifyProposal (t : Trace) (xs : List (ProposedOccurrence t)) : Candidate :=
  classify t (retained xs) (hasUngenerated xs)

theorem noExtraIffNoUngenerated {t : Trace} (xs : List (ProposedOccurrence t)) :
    hasUngenerated xs = false ↔ ProposedOccurrence.ungenerated ∉ xs := by
  induction xs with
  | nil =>
    constructor
    · intro _ impossible; cases impossible
    · intro _; rfl
  | cons x xs ih =>
    cases x with
    | generated p =>
      constructor
      · intro h member
        cases member with
        | tail _ htail => exact ih.mp h htail
      · intro absent
        exact ih.mpr (fun h => absent (List.Mem.tail _ h))
    | ungenerated =>
      constructor
      · intro h; cases h
      · intro absent
        exact False.elim (absent (List.Mem.head _))

theorem proposalAcceptedIffExactRetention (t : Trace) (xs : List (ProposedOccurrence t)) :
    survives (classifyProposal t xs) = true ↔
      (∀ p : Position t, p ∈ retained xs) ∧ (retained xs).Nodup ∧
        ProposedOccurrence.ungenerated ∉ xs := by
  constructor
  · intro h
    have exactRetention := (acceptedIffExactRetention t _ _).mp h
    exact ⟨exactRetention.1,exactRetention.2.1,(noExtraIffNoUngenerated xs).mp exactRetention.2.2⟩
  · intro h
    exact (acceptedIffExactRetention t _ _).mpr
      ⟨h.1,h.2.1,(noExtraIffNoUngenerated xs).mpr h.2.2⟩

theorem retainedGeneratedList {t : Trace} (xs : List (Position t)) :
    retained (xs.map ProposedOccurrence.generated) = xs := by
  induction xs with
  | nil => rfl
  | cons p xs ih => exact congrArg (List.cons p) ih

theorem generatedListHasNoExtra {t : Trace} (xs : List (Position t)) :
    hasUngenerated (xs.map ProposedOccurrence.generated) = false := by
  induction xs with
  | nil => rfl
  | cons _ xs ih => exact ih

theorem completeProposalAccepted (t : Trace) :
    survives (classifyProposal t ((complete t).map ProposedOccurrence.generated)) = true := by
  unfold classifyProposal
  rw [retainedGeneratedList,generatedListHasNoExtra]
  exact completeTraceAccepted t

end SFT.Foundation.Count.Representation
