import SFT.Physics.ThermoHeatWork
namespace SFT.Physics.ThermoHeatWorkClasses
open ThermoHeatWork SFT.InformationScience SFT.Mathematics.GeometryTopology
variable {Node Carrier : Type}

theorem closedSelectionIff (o : ObservedTransfers Node Carrier) (pair : String × String)
    (member : pair ∈ EncodingLoss.sourcePairs o.sourceSupport) :
    classify o pair = .closed ↔ pair ∈ closedLabels o := by
  by_cases h : image o.receiver pair.1 = image o.receiver pair.2
  · have result : classify o pair = .closed := by unfold classify; rw [ite_eq_left h]
    exact ⟨fun _ => (closedMeaning o pair).mpr ⟨member,h⟩,fun _ => result⟩
  · have result : classify o pair = .held := by unfold classify; rw [ite_eq_right h]
    constructor
    · intro bad; rw [result] at bad; cases bad
    · intro bad; exact False.elim (h ((closedMeaning o pair).mp bad).2)

theorem heldSelectionIff (o : ObservedTransfers Node Carrier) (pair : String × String)
    (member : pair ∈ EncodingLoss.sourcePairs o.sourceSupport) :
    classify o pair = .held ↔ pair ∈ heldLabels o := by
  by_cases h : image o.receiver pair.1 = image o.receiver pair.2
  · have result : classify o pair = .closed := by unfold classify; rw [ite_eq_left h]
    constructor
    · intro bad; rw [result] at bad; cases bad
    · intro bad; exact False.elim (((heldMeaning o pair).mp bad).2 h)
  · have result : classify o pair = .held := by unfold classify; rw [ite_eq_right h]
    exact ⟨fun _ => (heldMeaning o pair).mpr ⟨member,h⟩,fun _ => result⟩
end SFT.Physics.ThermoHeatWorkClasses
