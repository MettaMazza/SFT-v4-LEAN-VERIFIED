import SFT.Mathematics.SelectionProvenance
import SFT.Mathematics.CombinatorialCollections
namespace SFT.Mathematics.CombinatorialSelections
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

theorem sublistMemberRetained {α : Type} {xs ys : List α} (ordered : List.Sublist xs ys)
    (item : α) (member : item ∈ xs) : item ∈ ys := by
  induction ordered with
  | slnil => cases member
  | cons label prior ih => exact List.Mem.tail _ (ih member)
  | cons_cons label prior ih =>
    cases member with
    | head => exact List.Mem.head _
    | tail _ m => exact List.Mem.tail _ (ih m)

theorem sublistPreservesDistinct {α : Type} [DecidableEq α] {xs ys : List α}
    (ordered : List.Sublist xs ys) (unique : distinct ys = true) : distinct xs = true := by
  induction ordered with
  | slnil => rfl
  | cons label prior ih => exact ih ((distinctCons _ _).mp unique).2
  | cons_cons label prior ih =>
    have parts := (distinctCons _ _).mp unique
    apply (distinctCons _ _).mpr
    exact ⟨(absentIff _ _).mpr (fun m => (absentIff _ _).mp parts.1
      (sublistMemberRetained prior label m)),ih parts.2⟩

theorem eachRawSelectionDistinct (items : List String) (form : Form)
    (unique : distinct items = true) (generated : form ∈ rawSelections items) :
    distinct form = true :=
  sublistPreservesDistinct ((rawMembershipIffOrderedChoice items form).mp generated) unique

theorem singletonLabelsInjective (a b : String) (eq : [a] = [b]) : a = b :=
  (List.cons.inj eq).1

theorem carrierMemberCollection (items : List String) (nonempty : items ≠ [])
    (unique : distinct items = true) :
    generatedCollection (items.map (fun label => [label])) = .ok (items.map (fun label => [label])) := by
  have mapped := mapDistinct (fun label => [label]) singletonLabelsInjective items unique
  cases items with
  | nil => exact False.elim (nonempty rfl)
  | cons label rest => unfold generatedCollection; rw [mapped]; rfl

theorem rawSelectionDiscreteAdmission (items : List String) (form : Form)
    (unique : distinct items = true) (generated : form ∈ rawSelections items) :
    heldSelection (items.map (fun label => [label])) (form.map (fun label => [label])) =
      .ok (if form.isEmpty then formValue emptyOne else collectionValue (form.map (fun label => [label]))) := by
  cases form with
  | nil => exact heldEmptySelection _
  | cons label rest =>
    apply CombinatorialCollections.heldSubsetAdmitted
    · intro singleton member
      obtain ⟨item,retained,eq⟩ := memMapPreimage (fun item => [item]) singleton _ member
      rw [← eq]
      exact memMap _ _ _ (rawSelectionContained items (label::rest) generated item retained)
    · exact mapDistinct (fun item => [item]) singletonLabelsInjective _
        (eachRawSelectionDistinct items (label::rest) unique generated)
    · rfl

end SFT.Mathematics.CombinatorialSelections
