import SFT.Mathematics.OptimizationSelection
namespace SFT.Mathematics.OptimizationBounds
open DiscreteObjects AlgebraOperations GeometryTopology OptimizationSelection
open SFT.Foundation.ExactOperations SFT.Foundation.ExactPartCarrier

abbrev Criteria := List (String × Preference)

def dominates (criteria : Criteria) (left right : String) : Bool :=
  criteria.all (fun row => has row.2 (left,right) || decide (left = right)) &&
  criteria.any (fun row => has row.2 (left,right))

def paretoFrontier (feasible : List String) (criteria : Criteria) : List String :=
  feasible.filter (fun candidate => !feasible.any (fun other => !decide (other = candidate) && dominates criteria other candidate))

def exactApproximation (candidate optimum : Int) : Except String Part :=
  match candidate with
  | .negSucc _ => .error "approximation requires positive generated cell counts and a valid lower optimum"
  | .ofNat c => match optimum with
    | .negSucc _ => .error "approximation requires positive generated cell counts and a valid lower optimum"
    | .ofNat o =>
      if positive : 0 < o then
        if bound : o ≤ c then .ok (normalizePart o c positive bound)
        else .error "approximation requires positive generated cell counts and a valid lower optimum"
      else .error "approximation requires positive generated cell counts and a valid lower optimum"

theorem dominatesMeaning (criteria : Criteria) (left right : String) :
    dominates criteria left right = true ↔
      (∀ row, row ∈ criteria → (left,right) ∈ row.2 ∨ left = right) ∧
      (∃ row, row ∈ criteria ∧ (left,right) ∈ row.2) := by
  constructor
  · intro h
    have parts := (andTrue _ _).mp h
    constructor
    · intro row member
      have one := allTrueAtMember _ _ parts.1 row member
      cases hasPair : has row.2 (left,right) with
      | true => exact Or.inl ((hasIff _ _).mp hasPair)
      | false => rw [hasPair] at one; exact Or.inr (of_decide_eq_true one)
    · obtain ⟨row,member,pair⟩ := (anyTrueIff _ _).mp parts.2
      exact ⟨row,member,(hasIff _ _).mp pair⟩
  · intro h
    apply (andTrue _ _).mpr
    constructor
    · apply (allTrueIffMembers _ _).mpr
      intro row member
      cases h.1 row member with
      | inl pair => rw [(hasIff _ _).mpr pair]; rfl
      | inr same => rw [decide_eq_true same]; cases has row.2 (left,right) <;> rfl
    · obtain ⟨row,member,pair⟩ := h.2
      exact (anyTrueIff _ _).mpr ⟨row,member,(hasIff _ _).mpr pair⟩

theorem frontierMembership (feasible : List String) (criteria : Criteria) (candidate : String) :
    candidate ∈ paretoFrontier feasible criteria ↔ candidate ∈ feasible ∧
      ∀ other, other ∈ feasible → other ≠ candidate → dominates criteria other candidate = false := by
  constructor
  · intro h
    have parts := (filterMemberIff _ _ _).mp h
    have no := (notTrue _).mp parts.2
    refine ⟨parts.1,?_⟩
    intro other member different
    have rejected := anyFalseAtMember _ _ no other member
    rw [decide_eq_false different] at rejected
    exact rejected
  · intro h
    apply (filterMemberIff _ _ _).mpr
    refine ⟨h.1,?_⟩
    have none := anyFalseOfMembers (fun other => !decide (other = candidate) && dominates criteria other candidate) feasible (by
      intro other member
      by_cases same : other = candidate
      · rw [decide_eq_true same]; rfl
      · rw [decide_eq_false same,h.2 other member same]; rfl)
    rw [none]
    rfl

theorem frontierEliminationWitness (feasible : List String) (criteria : Criteria) (candidate : String)
    (member : candidate ∈ feasible) (absent : ¬ candidate ∈ paretoFrontier feasible criteria) :
    ∃ other, other ∈ feasible ∧ other ≠ candidate ∧ dominates criteria other candidate = true := by
  cases h : feasible.any (fun other => !decide (other = candidate) && dominates criteria other candidate) with
  | false =>
    exact False.elim (absent ((filterMemberIff _ _ _).mpr ⟨member,by rw [h]; rfl⟩))
  | true =>
    obtain ⟨other,present,better⟩ := (anyTrueIff _ _).mp h
    have parts := (andTrue _ _).mp better
    refine ⟨other,present,?_,parts.2⟩
    intro same
    rw [decide_eq_true same] at parts
    cases parts.1

theorem frontierRetainsIncomparable (feasible : List String) (criteria : Criteria) (candidate : String)
    (member : candidate ∈ feasible)
    (incomparable : ∀ other, other ∈ feasible → other ≠ candidate →
      ∃ row, row ∈ criteria ∧ ¬ (other,candidate) ∈ row.2) :
    candidate ∈ paretoFrontier feasible criteria := by
  apply (frontierMembership _ _ _).mpr
  refine ⟨member,?_⟩
  intro other present different
  cases d : dominates criteria other candidate with
  | false => rfl
  | true =>
    obtain ⟨row,rowMember,missing⟩ := incomparable other present different
    have premise := ((dominatesMeaning _ _ _).mp d).1 row rowMember
    cases premise with
    | inl pair => exact False.elim (missing pair)
    | inr same => exact False.elim (different same)

theorem emptyCriteriaFrontier (feasible : List String) : paretoFrontier feasible [] = feasible := by
  have no (items : List String) (candidate : String) :
      items.any (fun other => !decide (other = candidate) && dominates [] other candidate) = false := by
    induction items with
    | nil => rfl
    | cons other rest ih =>
      change ((!decide (other = candidate) && false) || rest.any _) = false
      rw [Bool.and_false,ih]
      rfl
  unfold paretoFrontier
  induction feasible with
  | nil => rfl
  | cons head rest ih =>
    have allKeep (items carrier : List String) :
        items.filter (fun candidate => !carrier.any (fun other => !decide (other = candidate) && dominates [] other candidate)) = items := by
      induction items with
      | nil => rfl
      | cons item tail ht =>
        rw [List.filter_cons_of_pos (by rw [no]; rfl)]
        exact congrArg (List.cons item) ht
    exact allKeep (head::rest) (head::rest)

theorem approximationAdmitted (candidate optimum : Nat) (positive : 0 < optimum) (bound : optimum ≤ candidate) :
    exactApproximation (.ofNat candidate) (.ofNat optimum) = .ok (normalizePart optimum candidate positive bound) := by
  unfold exactApproximation
  dsimp only
  rw [dif_pos positive,dif_pos bound]

theorem approximationRatio (candidate optimum : Nat) (positive : 0 < optimum) (bound : optimum ≤ candidate) :
    optimum * (normalizePart optimum candidate positive bound).denominator =
      (normalizePart optimum candidate positive bound).numerator * candidate :=
  normalizedValuePreserved optimum candidate positive (Nat.lt_of_lt_of_le positive bound)

theorem approximationThroughOne (candidate optimum : Nat) (positive : 0 < optimum) (bound : optimum ≤ candidate) :
    (normalizePart optimum candidate positive bound).numerator ≤ (normalizePart optimum candidate positive bound).denominator :=
  (normalizePart optimum candidate positive bound).throughOne

theorem approximationRejectsZero (candidate : Nat) :
    exactApproximation (.ofNat candidate) (.ofNat 0) =
      .error "approximation requires positive generated cell counts and a valid lower optimum" := rfl

theorem approximationRejectsInvalidBound (candidate optimum : Nat) (positive : 0 < optimum) (bad : ¬ optimum ≤ candidate) :
    exactApproximation (.ofNat candidate) (.ofNat optimum) =
      .error "approximation requires positive generated cell counts and a valid lower optimum" := by
  unfold exactApproximation
  dsimp only
  rw [dif_pos positive,dif_neg bad]

end SFT.Mathematics.OptimizationBounds
