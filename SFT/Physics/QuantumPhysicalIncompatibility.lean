import SFT.Physics.QuantumPhysicalWeight
namespace SFT.Physics.QuantumPhysicalIncompatibility

-- Source occurrences and complete phase/action/provenance records are retained.
-- The candidate family is the original generated family of joint refinements.
structure Refinement (Source Joint Left Right : Type) where
  generated : Source → Joint
  left : Joint → Left
  right : Joint → Right

variable {Source Joint Left Right : Type} [DecidableEq Left] [DecidableEq Right]

def retains (a : Source → Left) (b : Source → Right)
    (r : Refinement Source Joint Left Right) (s : Source) : Bool :=
  decide (r.left (r.generated s) = a s) && decide (r.right (r.generated s) = b s)

def preserves (support : List Source) (a : Source → Left) (b : Source → Right)
    (r : Refinement Source Joint Left Right) : Bool := support.all (retains a b r)

theorem rowMeaning (a : Source → Left) (b : Source → Right)
    (r : Refinement Source Joint Left Right) (s : Source) :
    retains a b r s = true ↔ r.left (r.generated s) = a s ∧ r.right (r.generated s) = b s := by
  constructor
  · intro h
    have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp h
    exact ⟨of_decide_eq_true both.1,of_decide_eq_true both.2⟩
  · intro h
    unfold retains
    rw [decide_eq_true h.1,decide_eq_true h.2]
    rfl

theorem preservesExactly (support : List Source) (a : Source → Left) (b : Source → Right)
    (r : Refinement Source Joint Left Right) : preserves support a b r = true ↔
      ∀ s ∈ support, r.left (r.generated s) = a s ∧ r.right (r.generated s) = b s := by
  constructor
  · intro h s hs
    exact (rowMeaning a b r s).mp ((SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mp h s hs)
  · intro h
    exact (SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mpr (fun s hs => (rowMeaning a b r s).mpr (h s hs))

theorem failedRow (support : List Source) (a : Source → Left) (b : Source → Right)
    (r : Refinement Source Joint Left Right) (failed : preserves support a b r = false) :
    ∃ s ∈ support, r.left (r.generated s) ≠ a s ∨ r.right (r.generated s) ≠ b s := by
  induction support with
  | nil => cases failed
  | cons s rest ih =>
    by_cases hl : r.left (r.generated s) = a s
    · by_cases hr : r.right (r.generated s) = b s
      · have retained := (rowMeaning a b r s).mpr ⟨hl,hr⟩
        change (retains a b r s && preserves rest a b r) = false at failed
        rw [retained] at failed
        obtain ⟨t,ht,missing⟩ := ih failed
        exact ⟨t,.tail _ ht,missing⟩
      · exact ⟨s,.head _,Or.inr hr⟩
    · exact ⟨s,.head _,Or.inl hl⟩

def incompatible (support : List Source) (a : Source → Left) (b : Source → Right)
    (family : List (Refinement Source Joint Left Right)) : Prop :=
  ∀ r ∈ family, preserves support a b r = false

theorem noCommonRefinementIff (support : List Source) (a : Source → Left) (b : Source → Right)
    (family : List (Refinement Source Joint Left Right)) : incompatible support a b family ↔
    ¬ ∃ r ∈ family, ∀ s ∈ support,
      r.left (r.generated s) = a s ∧ r.right (r.generated s) = b s := by
  constructor
  · intro h ⟨r,hr,kept⟩
    have yes := (preservesExactly support a b r).mpr kept
    have no := h r hr
    rw [no] at yes
    cases yes
  · intro absent r hr
    cases h : preserves support a b r with
    | false => rfl
    | true => exact False.elim (absent ⟨r,hr,(preservesExactly support a b r).mp h⟩)

theorem resolutionClosesRequiredRecord (support : List Source) (a : Source → Left) (b : Source → Right)
    (family : List (Refinement Source Joint Left Right)) (h : incompatible support a b family)
    (r : Refinement Source Joint Left Right) (hr : r ∈ family)
    (resolvesLeft : ∀ s ∈ support, r.left (r.generated s) = a s) :
    ∃ s ∈ support, r.right (r.generated s) ≠ b s := by
  obtain ⟨s,hs,lost⟩ := failedRow support a b r (h r hr)
  cases lost with
  | inl no => exact False.elim (no (resolvesLeft s hs))
  | inr no => exact ⟨s,hs,no⟩

theorem resolutionClosesRequiredLeftRecord (support : List Source) (a : Source → Left) (b : Source → Right)
    (family : List (Refinement Source Joint Left Right)) (h : incompatible support a b family)
    (r : Refinement Source Joint Left Right) (hr : r ∈ family)
    (resolvesRight : ∀ s ∈ support, r.right (r.generated s) = b s) :
    ∃ s ∈ support, r.left (r.generated s) ≠ a s := by
  obtain ⟨s,hs,lost⟩ := failedRow support a b r (h r hr)
  cases lost with
  | inl no => exact ⟨s,hs,no⟩
  | inr no => exact False.elim (no (resolvesRight s hs))

def trace (support : List Source) (r : Refinement Source Joint Left Right) :=
  support.map (fun s => (s,r.generated s,r.left (r.generated s),r.right (r.generated s)))

theorem completeSourceTrace (support : List Source) (r : Refinement Source Joint Left Right) :
    (trace support r).map Prod.fst = support := by
  induction support with
  | nil => rfl
  | cons s rest ih => exact congrArg (List.cons s) ih
end SFT.Physics.QuantumPhysicalIncompatibility
