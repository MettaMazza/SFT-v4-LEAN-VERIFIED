import SFT.Mathematics.SelectionCompleteness
namespace SFT.Mathematics.CombinatorialSelections
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

theorem sublistAppendAbsent {α : Type} {xs ys : List α} (choice : List.Sublist xs ys) (fresh : α) :
    List.Sublist xs (ys ++ [fresh]) := by
  induction choice with
  | slnil => exact List.Sublist.cons fresh List.Sublist.slnil
  | cons a prior ih => exact List.Sublist.cons a ih
  | cons_cons a prior ih => exact List.Sublist.cons_cons a ih

theorem sublistAppendHeld {α : Type} {xs ys : List α} (choice : List.Sublist xs ys) (fresh : α) :
    List.Sublist (xs ++ [fresh]) (ys ++ [fresh]) := by
  induction choice with
  | slnil => exact List.Sublist.cons_cons fresh List.Sublist.slnil
  | cons a prior ih => exact List.Sublist.cons a ih
  | cons_cons a prior ih => exact List.Sublist.cons_cons a ih

theorem heldChoicePreservesOrder (items : List String) (form : Form)
    (choice : HeldChoice items form) : List.Sublist form items := by
  induction choice with
  | base => exact List.Sublist.slnil
  | absent items form fresh prior ih => exact sublistAppendAbsent ih fresh
  | held items form fresh prior ih => exact sublistAppendHeld ih fresh

theorem choicePrefixAbsent (items : List String) (form : Form) (label : String)
    (choice : HeldChoice items form) : HeldChoice (label::items) form := by
  induction choice with
  | base => exact HeldChoice.absent [] [] label HeldChoice.base
  | absent items form fresh prior ih => exact HeldChoice.absent (label::items) form fresh ih
  | held items form fresh prior ih => exact HeldChoice.held (label::items) form fresh ih

theorem choicePrefixHeld (items : List String) (form : Form) (label : String)
    (choice : HeldChoice items form) : HeldChoice (label::items) (label::form) := by
  induction choice with
  | base => exact HeldChoice.held [] [] label HeldChoice.base
  | absent items form fresh prior ih => exact HeldChoice.absent (label::items) (label::form) fresh ih
  | held items form fresh prior ih => exact HeldChoice.held (label::items) (label::form) fresh ih

theorem everyOrderedChoiceDerived (items : List String) (form : Form)
    (ordered : List.Sublist form items) : HeldChoice items form := by
  induction ordered with
  | slnil => exact HeldChoice.base
  | cons label prior ih => exact choicePrefixAbsent _ _ label ih
  | cons_cons label prior ih => exact choicePrefixHeld _ _ label ih

theorem rawMembershipIffOrderedChoice (items : List String) (form : Form) :
    form ∈ rawSelections items ↔ List.Sublist form items :=
  ⟨fun member => heldChoicePreservesOrder items form (everyGeneratedFormHasChoice items form member),
    fun ordered => everyHeldChoiceGenerated items form (everyOrderedChoiceDerived items form ordered)⟩

theorem encodedMembershipIffOrderedChoice (items : List String) (form : Form) :
    form ∈ (rawSelections items).map encodeEmpty ↔
      ∃ raw, List.Sublist raw items ∧ encodeEmpty raw = form := by
  constructor
  · intro member
    obtain ⟨raw,choice,eq⟩ := (encodedMembershipIff items form).mp member
    exact ⟨raw,heldChoicePreservesOrder items raw choice,eq⟩
  · intro h
    obtain ⟨raw,ordered,eq⟩ := h
    exact (encodedMembershipIff items form).mpr
      ⟨raw,everyOrderedChoiceDerived items raw ordered,eq⟩

theorem heldExtensionRetainsFoldProvenance (items : List String) (form : Form) (fresh : String)
    (generated : form ∈ rawSelections items) :
    SFT.Foundation.FoldAssembly.appendLabel form fresh ∈ rawSelections (items ++ [fresh]) ∧
    SFT.Foundation.FoldAssembly.returnWord (SFT.Foundation.FoldAssembly.appendLabel form fresh) = some form ∧
    SFT.Foundation.FoldAssembly.lastLabel (SFT.Foundation.FoldAssembly.appendLabel form fresh) = some fresh := by
  constructor
  · rw [rawSuccessor]
    exact heldRetained _ _ _ generated
  · exact ⟨SFT.Foundation.FoldAssembly.appendReturns form fresh,
      SFT.Foundation.FoldAssembly.appendedLabelRetained form fresh⟩

end SFT.Mathematics.CombinatorialSelections
