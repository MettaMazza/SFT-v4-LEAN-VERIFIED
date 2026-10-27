import SFT.Foundation.FormEquivalenceRaw
import SFT.Host.Canonical
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

/-! Python truth testing and operand-returning `and` for the literal host values
used in protocol records. These are host data, not scientific free parameters. -/
def truthy : SFT.Host.Canonical.Value → Bool
  | .boolean b => b
  | .null => false
  | .text s => !s.isEmpty
  | .integer n => match n with
    | .ofNat k => match k with
      | .zero => false
      | .succ _ => true
    | .negSucc _ => true
  | .array xs => !xs.isEmpty
  | .object fields => !fields.isEmpty

def andValue (left right : SFT.Host.Canonical.Value) : SFT.Host.Canonical.Value :=
  if truthy left then right else left

def acceptsValue (targetBeforeSeal : SFT.Host.Canonical.Value := .boolean false)
    (measurementChangesLaw : SFT.Host.Canonical.Value := .boolean false)
    (allRows : SFT.Host.Canonical.Value := .boolean true)
    (source : SFT.Host.Canonical.Value := .boolean true) : SFT.Host.Canonical.Value :=
  if truthy targetBeforeSeal then .boolean false
  else if truthy measurementChangesLaw then .boolean false
  else andValue allRows source

theorem sourceExpression (pre mutation rows source : SFT.Host.Canonical.Value) :
    acceptsValue pre mutation rows source =
      andValue (andValue (andValue (.boolean (!truthy pre))
        (.boolean (!truthy mutation))) rows) source := by
  unfold acceptsValue andValue
  cases hp : truthy pre <;> cases hm : truthy mutation <;> rfl

theorem booleanSpecialization (pre mutation rows source : Bool) :
    acceptsValue (.boolean pre) (.boolean mutation) (.boolean rows) (.boolean source) =
      .boolean (accepts pre mutation rows source) := by
  cases pre <;> cases mutation <;> cases rows <;> cases source <;> rfl

theorem preSealOperandRejected (pre mutation rows source : SFT.Host.Canonical.Value)
    (h : truthy pre = true) : acceptsValue pre mutation rows source = .boolean false := by
  unfold acceptsValue
  rw [h]
  rfl

theorem mutationOperandRejected (pre mutation rows source : SFT.Host.Canonical.Value)
    (h : truthy mutation = true) : acceptsValue pre mutation rows source = .boolean false := by
  unfold acceptsValue
  rw [h]
  cases truthy pre <;> rfl

theorem falseRowsReturned (pre mutation rows source : SFT.Host.Canonical.Value)
    (hp : truthy pre = false) (hm : truthy mutation = false) (hr : truthy rows = false) :
    acceptsValue pre mutation rows source = rows := by
  unfold acceptsValue andValue
  rw [hp,hm,hr]
  rfl

theorem sourceOperandReturned (pre mutation rows source : SFT.Host.Canonical.Value)
    (hp : truthy pre = false) (hm : truthy mutation = false) (hr : truthy rows = true) :
    acceptsValue pre mutation rows source = source := by
  unfold acceptsValue andValue
  rw [hp,hm,hr]
  rfl

theorem sourceIdentifierReturned :
    acceptsValue (.boolean false) (.boolean false) (.boolean true) (.text "source-id") =
      .text "source-id" := rfl

theorem emptyRowsRetained :
    acceptsValue (.boolean false) (.boolean false) (.array []) (.text "source-id") = .array [] := rfl

theorem defaultsValueAccepted : acceptsValue = .boolean true := rfl

end SFT.Foundation.MeasurementProtocol
