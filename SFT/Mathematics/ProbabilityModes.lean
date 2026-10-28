import SFT.Mathematics.ProbabilityIndependence
namespace SFT.Mathematics.ProbabilityModes
open DiscreteObjects ProbabilityIndependence

def occurrences (trace : List String) (label : String) : Nat :=
  (trace.filter (fun item => decide (item = label))).length

def greatestCount (trace : List String) : List String → Nat
  | [] => 0
  | label :: rest =>
    let tail := greatestCount trace rest
    if occurrences trace label ≤ tail then tail else occurrences trace label

def modeLabels (trace : List String) : List String :=
  (firstLabels trace).filter (fun label => decide (occurrences trace label = greatestCount trace (firstLabels trace)))

def exactMode (trace : List String) : Except String (List String) :=
  if trace.isEmpty then .error "a statistical trace must be generated and nonempty"
  else .ok (modeLabels trace)

theorem occurrencesEmpty (label : String) : occurrences [] label = 0 := rfl

theorem occurrencesCons (item label : String) (rest : List String) :
    occurrences (item :: rest) label = if item = label then occurrences rest label + 1 else occurrences rest label := by
  by_cases same : item = label
  · rw [ite_eq_left same]
    unfold occurrences
    rw [List.filter_cons_of_pos (p := fun x => decide (x = label)) (a := item) (decide_eq_true same)]
    rfl
  · rw [ite_eq_right same]
    unfold occurrences
    rw [List.filter_cons_of_neg (p := fun x => decide (x = label)) (a := item) (fun h => same (of_decide_eq_true h))]

theorem greatestBounds (trace labels : List String) (label : String) (member : label ∈ labels) :
    occurrences trace label ≤ greatestCount trace labels := by
  induction labels with
  | nil => cases member
  | cons head rest ih =>
    change _ ≤ if occurrences trace head ≤ greatestCount trace rest then greatestCount trace rest else occurrences trace head
    split
    · rename_i h
      cases member with
      | head => exact h
      | tail _ hm => exact ih hm
    · rename_i h
      cases member with
      | head => exact Nat.le_refl _
      | tail _ hm => exact Nat.le_trans (ih hm) (Nat.le_of_lt (Nat.lt_of_not_ge h))

theorem greatestLeast (trace labels : List String) (bound : Nat)
    (upper : ∀ label, label ∈ labels → occurrences trace label ≤ bound) :
    greatestCount trace labels ≤ bound := by
  induction labels with
  | nil => exact Nat.zero_le _
  | cons head rest ih =>
    change (if occurrences trace head ≤ greatestCount trace rest then greatestCount trace rest else occurrences trace head) ≤ bound
    split
    · exact ih (fun label h => upper label (List.Mem.tail _ h))
    · exact upper head (List.Mem.head _)

theorem modeMembership (trace : List String) (label : String) :
    label ∈ modeLabels trace ↔ label ∈ trace ∧
      ∀ other, other ∈ trace → occurrences trace other ≤ occurrences trace label := by
  constructor
  · intro member
    have parts := (filterMemberIff _ _ _).mp member
    have equal := of_decide_eq_true parts.2
    refine ⟨(firstLabelsMembership _ _).mp parts.1,?_⟩
    intro other hm
    rw [equal]
    exact greatestBounds _ _ other ((firstLabelsMembership _ _).mpr hm)
  · intro parts
    have member := (firstLabelsMembership _ _).mpr parts.1
    have equal := Nat.le_antisymm (greatestBounds _ _ label member)
      (greatestLeast _ _ (occurrences trace label) (fun other hm => parts.2 other ((firstLabelsMembership _ _).mp hm)))
    exact (filterMemberIff _ _ _).mpr ⟨member,decide_eq_true equal⟩

theorem greatestAttained (trace labels : List String) (nonempty : labels ≠ []) :
    ∃ label, label ∈ labels ∧ occurrences trace label = greatestCount trace labels := by
  induction labels with
  | nil => exact False.elim (nonempty rfl)
  | cons head rest ih =>
    cases rest with
    | nil =>
      refine ⟨head,List.Mem.head [],?_⟩
      change _ = if occurrences trace head ≤ 0 then 0 else occurrences trace head
      split
      · rename_i h; exact Nat.le_antisymm h (Nat.zero_le _)
      · rfl
    | cons next tail =>
      obtain ⟨label,member,equal⟩ := ih (fun h => by cases h)
      by_cases selected : occurrences trace head ≤ greatestCount trace (next :: tail)
      · refine ⟨label,List.Mem.tail head member,?_⟩
        change _ = if occurrences trace head ≤ greatestCount trace (next :: tail) then greatestCount trace (next :: tail) else occurrences trace head
        rw [ite_eq_left selected]
        exact equal
      · refine ⟨head,List.Mem.head _,?_⟩
        change _ = if occurrences trace head ≤ greatestCount trace (next :: tail) then greatestCount trace (next :: tail) else occurrences trace head
        rw [ite_eq_right selected]

theorem modeExists (trace : List String) (nonempty : trace ≠ []) :
    ∃ label, label ∈ modeLabels trace := by
  have labelsNonempty : firstLabels trace ≠ [] := by
    intro empty
    cases trace with
    | nil => exact nonempty rfl
    | cons head tail =>
      have member := (firstLabelsMembership (head :: tail) head).mpr (List.Mem.head tail)
      rw [empty] at member
      cases member
  obtain ⟨label,member,equal⟩ := greatestAttained trace (firstLabels trace) labelsNonempty
  exact ⟨label,(filterMemberIff _ _ _).mpr ⟨member,decide_eq_true equal⟩⟩

theorem modeDistinct (trace : List String) : distinct (modeLabels trace) = true :=
  filterDistinct _ _ (firstLabelsDistinct trace)

theorem modeRetainsEveryTie (trace : List String) (label other : String)
    (mode : label ∈ modeLabels trace) (member : other ∈ trace)
    (tie : occurrences trace other = occurrences trace label) : other ∈ modeLabels trace := by
  have maximal := (modeMembership _ _).mp mode
  apply (modeMembership _ _).mpr
  refine ⟨member,?_⟩
  intro candidate hm
  rw [tie]
  exact maximal.2 candidate hm

theorem exactModeEmpty : exactMode [] = .error "a statistical trace must be generated and nonempty" := rfl

theorem exactModeNonempty (trace : List String) (nonempty : trace.isEmpty = false) :
    exactMode trace = .ok (modeLabels trace) := by
  unfold exactMode
  rw [nonempty]
  rfl

end SFT.Mathematics.ProbabilityModes
