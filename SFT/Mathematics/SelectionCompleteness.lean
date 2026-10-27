import SFT.Mathematics.SelectionEncoding
namespace SFT.Mathematics.CombinatorialSelections
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

theorem emptyChoiceEveryCarrier (items : List String) : HeldChoice items [] := by
  apply snocInduction (fun items => HeldChoice items [])
  · exact HeldChoice.base
  · intro prior fresh ih
    exact HeldChoice.absent prior [] fresh ih

theorem encodedMembershipIff (items : List String) (form : Form) :
    form ∈ (rawSelections items).map encodeEmpty ↔
      ∃ raw, HeldChoice items raw ∧ encodeEmpty raw = form := by
  constructor
  · intro member
    obtain ⟨raw,generated,eq⟩ := memMapPreimage _ _ _ member
    exact ⟨raw,everyGeneratedFormHasChoice items raw generated,eq⟩
  · intro h
    obtain ⟨raw,choice,eq⟩ := h
    rw [← eq]
    exact memMap _ _ _ (everyHeldChoiceGenerated items raw choice)

theorem encodedEmptyRetained (items : List String) :
    emptyOne ∈ (rawSelections items).map encodeEmpty :=
  (encodedMembershipIff items emptyOne).mpr ⟨[],emptyChoiceEveryCarrier items,rfl⟩

theorem encodedTracePositive (items : List String) :
    ((rawSelections items).map encodeEmpty).isEmpty = false := by
  have member := encodedEmptyRetained items
  cases eq : (rawSelections items).map encodeEmpty with
  | nil => rw [eq] at member; cases member
  | cons x xs => rfl

theorem encodedFormHasUniqueRawChoice (items : List String) (form : Form)
    (absent : ¬ "empty-One" ∈ items)
    (member : form ∈ (rawSelections items).map encodeEmpty) :
    ∃ raw, HeldChoice items raw ∧ encodeEmpty raw = form ∧
      ∀ other, HeldChoice items other → encodeEmpty other = form → other = raw := by
  obtain ⟨raw,choice,eq⟩ := (encodedMembershipIff items form).mp member
  refine ⟨raw,choice,eq,?_⟩
  intro other otherChoice otherEq
  exact encodingInjectiveAwayMarker other raw
    (rawFormAvoidsMarker items other absent (everyHeldChoiceGenerated items other otherChoice))
    (rawFormAvoidsMarker items raw absent (everyHeldChoiceGenerated items raw choice))
    (otherEq.trans eq.symm)

theorem acceptedSelectionsComplete (items : List String) (results : List Form)
    (accepted : selections items = .ok results) :
    results.isEmpty = false ∧ emptyOne ∈ results ∧
      ∀ form, form ∈ results ↔ ∃ raw, HeldChoice items raw ∧ encodeEmpty raw = form := by
  unfold selections at accepted
  cases nonempty : items.isEmpty with
  | true => rw [nonempty] at accepted; cases accepted
  | false =>
    cases unique : distinct items with
    | false => rw [nonempty,unique] at accepted; cases accepted
    | true =>
      rw [nonempty,unique] at accepted
      cases accepted
      exact ⟨encodedTracePositive items,encodedEmptyRetained items,encodedMembershipIff items⟩

theorem acceptedSelectionsCompleteUnique (items : List String) (results : List Form)
    (absent : ¬ "empty-One" ∈ items) (accepted : selections items = .ok results) :
    distinct results = true ∧
      ∀ form, form ∈ results → ∃ raw, HeldChoice items raw ∧ encodeEmpty raw = form ∧
        ∀ other, HeldChoice items other → encodeEmpty other = form → other = raw := by
  unfold selections at accepted
  cases nonempty : items.isEmpty with
  | true => rw [nonempty] at accepted; cases accepted
  | false =>
    cases unique : distinct items with
    | false => rw [nonempty,unique] at accepted; cases accepted
    | true =>
      rw [nonempty,unique] at accepted
      cases accepted
      exact ⟨encodedSelectionsDistinct items unique absent,
        fun form member => encodedFormHasUniqueRawChoice items form absent member⟩

end SFT.Mathematics.CombinatorialSelections
