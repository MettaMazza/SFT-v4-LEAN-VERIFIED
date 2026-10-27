import SFT.Mathematics.ArrangementCounting
import SFT.Mathematics.SelectionCompleteness
namespace SFT.Mathematics.CombinatorialCollections
open DiscreteObjects CombinatorialArrangements CombinatorialSelections
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

theorem arrangementCollection (items : List String) (nonempty : items ≠ [])
    (unique : distinct items = true) :
    generatedCollection (arrangementsCore items) = .ok (arrangementsCore items) := by
  unfold generatedCollection
  rw [arrangementTraceNonempty items nonempty unique,arrangementFamilyDistinct items unique]
  rfl

theorem arrangementConstructionTrace (items : List String) (nonempty : items ≠ [])
    (unique : distinct items = true) : CollectionTrace (arrangementsCore items) :=
  acceptedCollectionTrace _ (arrangementCollection items nonempty unique)

theorem selectionCollection (items : List String) (unique : distinct items = true)
    (absent : ¬ "empty-One" ∈ items) :
    generatedCollection ((rawSelections items).map encodeEmpty) =
      .ok ((rawSelections items).map encodeEmpty) := by
  unfold generatedCollection
  rw [encodedTracePositive items,encodedSelectionsDistinct items unique absent]
  rfl

theorem selectionConstructionTrace (items : List String) (unique : distinct items = true)
    (absent : ¬ "empty-One" ∈ items) : CollectionTrace ((rawSelections items).map encodeEmpty) :=
  acceptedCollectionTrace _ (selectionCollection items unique absent)

theorem heldSubsetAdmitted (collection held : Collection)
    (contained : ∀ form, form ∈ held → form ∈ collection)
    (unique : distinct held = true) (nonempty : held.isEmpty = false) :
    heldSelection collection held = .ok (collectionValue held) := by
  have guard : held.any (fun form => !has collection form) = false := by
    apply anyFalseOfMembers
    intro form member
    rw [(hasIff collection form).mpr (contained form member)]
    rfl
  unfold heldSelection
  rw [guard,unique,nonempty]
  rfl

theorem arrangementHeldBranchAdmitted (first second : String) (rest : List String)
    (held : String) (member : held ∈ first::second::rest)
    (unique : distinct (first::second::rest) = true) :
    heldSelection (arrangementsCore (first::second::rest))
      ((arrangementsCore (remainder (first::second::rest) held)).map (List.cons held)) =
      .ok (collectionValue
        ((arrangementsCore (remainder (first::second::rest) held)).map (List.cons held))) := by
  have guards := recursiveRemainderAdmitted first second rest held unique member
  apply heldSubsetAdmitted
  · intro form branch
    rw [arrangementsStepByValues]
    exact memFlatMap _ _ held form member branch
  · exact mapDistinct (List.cons held) (fun a b eq => (List.cons.inj eq).2) _
      (arrangementFamilyDistinct _ guards.2)
  · exact heldTraceNonempty _ held guards.1 guards.2

theorem encodedLiteralCollectionRejected :
    (selections ["empty-One"]).bind generatedCollection =
      .error "ValueError: a generated collection requires distinct nonempty forms" := rfl

end SFT.Mathematics.CombinatorialCollections
