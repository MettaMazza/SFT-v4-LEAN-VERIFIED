import SFT.Foundation.FormEquivalenceRaw
namespace SFT.Foundation.MeasurementProtocol

/-! protocol_accepts on the source's four Boolean protocol flags, with its
original defaults and conjunction order. -/
def accepts (targetBeforeSeal : Bool := false) (measurementChangesLaw : Bool := false)
    (allRows : Bool := true) (source : Bool := true) : Bool :=
  !targetBeforeSeal && !measurementChangesLaw && allRows && source

theorem acceptanceIff (targetBeforeSeal measurementChangesLaw allRows source : Bool) :
    accepts targetBeforeSeal measurementChangesLaw allRows source = true ↔
    targetBeforeSeal = false ∧ measurementChangesLaw = false ∧ allRows = true ∧ source = true := by
  cases targetBeforeSeal <;> cases measurementChangesLaw <;> cases allRows <;> cases source
  all_goals constructor <;> intro h
  all_goals first
    | exact ⟨rfl,rfl,rfl,rfl⟩
    | rfl
    | (cases h; done)
    | (obtain ⟨ha,hb,hc,hd⟩ := h; first | (cases ha; done) | (cases hb; done) | (cases hc; done) | (cases hd; done))

theorem defaultsAccepted : accepts = true := rfl

theorem preSealRejected (mutation allRows source : Bool) : accepts true mutation allRows source = false := by
  cases mutation <;> cases allRows <;> cases source <;> rfl

theorem mutationRejected (preSeal allRows source : Bool) : accepts preSeal true allRows source = false := by
  cases preSeal <;> cases allRows <;> cases source <;> rfl

theorem selectiveRowsRejected (preSeal mutation source : Bool) : accepts preSeal mutation false source = false := by
  cases preSeal <;> cases mutation <;> cases source <;> rfl

theorem unidentifiedSourceRejected (preSeal mutation allRows : Bool) : accepts preSeal mutation allRows false = false := by
  cases preSeal <;> cases mutation <;> cases allRows <;> rfl

end SFT.Foundation.MeasurementProtocol
