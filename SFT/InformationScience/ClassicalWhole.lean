import SFT.InformationScience.ClassicalResolution
namespace SFT.InformationScience.ClassicalWhole
open SFT.Foundation.ExactOperations
open SFT.Mathematics.ProbabilityObservations
open SFT.Mathematics.DiscreteObjects
open SFT.Mathematics.GeometryTopology
open SFT.Mathematics.ProbabilityIndependence

-- The raw helper accepts Fraction values; signed and zero inputs are retained.
-- Cross multiplication avoids introducing normalization into a Boolean sum test.
def sumParts (parts : List Rat) (numerator : Int := 0) (denominator : Nat := 1) : Int × Nat :=
  match parts with
  | [] => (numerator,denominator)
  | part :: rest => sumParts rest
      (numerator * Int.ofNat part.den + part.num * Int.ofNat denominator)
      (denominator * part.den)

def ledgerIsExactWhole (parts : List Rat) : Bool :=
  match parts with
  | [] => false
  | _ :: _ => let total := sumParts parts; decide (total.1 = Int.ofNat total.2)

def positiveRat (part : PositiveFraction) : Rat :=
  ⟨Int.ofNat part.numerator,part.denominator,part.denominatorNonzero,part.reduced⟩

def probabilityWhole (rows : List ClassicalLedger.ProbabilityRow) : Bool :=
  ledgerIsExactWhole (rows.map (fun row => positiveRat row.exactSupportPart))

def pushforwardWhole (rows : List ClassicalLedger.PushforwardRow) : Bool :=
  ledgerIsExactWhole (rows.map (fun row => positiveRat row.exactSupportPart))

theorem wholeMeaning (first : Rat) (rest : List Rat) :
    ledgerIsExactWhole (first :: rest) = true ↔
      (sumParts (first :: rest)).1 = Int.ofNat (sumParts (first :: rest)).2 := by
  constructor
  · intro h; exact of_decide_eq_true h
  · intro h; exact decide_eq_true h

theorem emptyNotWhole : ledgerIsExactWhole [] = false := rfl

def labelHits (labels : List String) (label : String) : Nat :=
  match labels with
  | [] => 0
  | first :: rest => (if first = label then 1 else 0) + labelHits rest label

def classCount (support : List String) (mapping : Observation) (labels : List String) : Nat :=
  match labels with
  | [] => 0
  | label :: rest => (fibre support mapping label).length + classCount support mapping rest

theorem absentHits (labels : List String) (label : String)
    (absent : ¬ label ∈ labels) : labelHits labels label = 0 := by
  induction labels with
  | nil => rfl
  | cons first rest ih =>
    have ne : first ≠ label := fun h => absent (h ▸ List.Mem.head rest)
    have tail : ¬ label ∈ rest := fun h => absent (List.Mem.tail first h)
    change (if first = label then 1 else 0) + labelHits rest label = 0
    rw [ite_eq_right ne,ih tail]

theorem distinctHits (labels : List String) (label : String)
    (unique : distinct labels = true) (member : label ∈ labels) : labelHits labels label = 1 := by
  induction labels with
  | nil => cases member
  | cons first rest ih =>
    have p := (distinctCons _ _).mp unique
    change (if first = label then 1 else 0) + labelHits rest label = 1
    by_cases eq : first = label
    · cases eq
      rw [ite_eq_left rfl,absentHits rest label ((absentIff _ _).mp p.1)]
    · rw [ite_eq_right eq]
      cases member with
      | head => exact False.elim (eq rfl)
      | tail _ hm => exact (Nat.zero_add _).trans (ih p.2 hm)

theorem emptyClassCount (mapping : Observation) (labels : List String) : classCount [] mapping labels = 0 := by
  induction labels with
  | nil => rfl
  | cons label rest ih =>
    change 0 + classCount [] mapping rest = 0
    exact (Nat.zero_add _).trans ih

theorem classCountCons (support : List String) (mapping : Observation) (labels : List String)
    (state label : String) (observed : image mapping state = some label) :
    classCount (state :: support) mapping labels = labelHits labels label + classCount support mapping labels := by
  induction labels with
  | nil => rfl
  | cons first rest ih =>
    have cell : belongs mapping first state = decide (first = label) := by
      unfold belongs
      rw [observed]
      change decide (label = first) = decide (first = label)
      by_cases eq : first = label
      · cases eq; rfl
      · have ne : label ≠ first := fun h => eq h.symm
        rw [decide_eq_false ne,decide_eq_false eq]
    change (List.filter (belongs mapping first) (state :: support)).length + classCount (state :: support) mapping rest = _
    by_cases eq : first = label
    · rw [List.filter_cons_of_pos (cell.trans (decide_eq_true eq))]
      change ((fibre support mapping first).length+1) + classCount (state :: support) mapping rest =
        ((if first = label then 1 else 0) + labelHits rest label) + ((fibre support mapping first).length + classCount support mapping rest)
      rw [ite_eq_left eq,ih]
      rw [Nat.add_assoc, Nat.add_assoc, Nat.add_left_comm (fibre support mapping first).length 1,
        Nat.add_left_comm (fibre support mapping first).length (labelHits rest label)]
    · rw [List.filter_cons_of_neg (by rw [cell,decide_eq_false eq]; intro h; cases h)]
      change (fibre support mapping first).length + classCount (state :: support) mapping rest =
        ((if first = label then 1 else 0) + labelHits rest label) + ((fibre support mapping first).length + classCount support mapping rest)
      rw [ite_eq_right eq,ih]
      rw [Nat.zero_add]
      exact Nat.add_left_comm _ _ _

theorem completeClassCount (support : List String) (mapping : Observation) (labels : List String)
    (unique : distinct labels = true)
    (covered : ∀ state, state ∈ support → ∃ label, label ∈ labels ∧ image mapping state = some label) :
    classCount support mapping labels = support.length := by
  induction support with
  | nil => exact emptyClassCount mapping labels
  | cons state rest ih =>
    obtain ⟨label,member,observed⟩ := covered state (List.Mem.head rest)
    rw [classCountCons rest mapping labels state label observed,distinctHits labels label unique member,
      ih (fun s hs => covered s (List.Mem.tail state hs))]
    exact Nat.add_comm 1 rest.length

theorem originalClassCount (support : List String) (mapping : Observation)
    (valid : keysMatch support mapping = true) :
    classCount support mapping (firstLabels (observedValues mapping support)) = support.length := by
  apply completeClassCount support mapping _ (firstLabelsDistinct _)
  intro state member
  obtain ⟨label,observed⟩ := admittedImage support mapping valid state member
  exact ⟨label,(firstLabelsMembership _ _).mpr ((observedMembership _ _ _).mpr ⟨state,member,observed⟩),observed⟩

end SFT.InformationScience.ClassicalWhole
