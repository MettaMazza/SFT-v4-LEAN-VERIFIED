import SFT.Physics.InverseSquareInterval
import SFT.Host.Text
namespace SFT.Physics.InverseSquareIntervalSource
open SFT.Host SFT.Physics.InverseSquareInterval SFT.Physics.FoldFirstReturn

-- Exact fields reconstructed from the registered JSON record.
structure Record where
 lower : Rat
 upper : Rat
 sourceId : String
 doi : String

def sourceId := "APS-WILLIAMS-FALLER-HILL-1971-COULOMB"
def doi := "10.1103/physrevlett.26.721"

def precheck (record : Record) : Except String Unit := do
 if !Text.equal record.sourceId sourceId then
  .error "ValueError: inverse-square target source identity changed"
 else if !Text.equal (Text.lowerAscii record.doi) doi then
  .error "ValueError: inverse-square target DOI changed"
 else
  let survivors ← checked (.fraction record.lower) (.fraction record.upper)
  if survivors == [2] then .ok ()
  else .error "ValueError: registered experimental interval does not uniquely retain exponent two"

def registered : Record := ⟨SFT.Physics.BoundaryGrowth.asFraction reportedLower,SFT.Physics.BoundaryGrowth.asFraction reportedUpper,
 sourceId,"10.1103/PhysRevLett.26.721"⟩

theorem registeredPasses : precheck registered = .ok () := rfl

theorem changedSourceRejected (record : Record)
 (changed : Text.equal record.sourceId sourceId = false) :
 precheck record = .error "ValueError: inverse-square target source identity changed" := by
 unfold precheck
 rw [changed]
 rfl

theorem changedDoiRejected (record : Record)
 (same : Text.equal record.sourceId sourceId = true)
 (changed : Text.equal (Text.lowerAscii record.doi) doi = false) :
 precheck record = .error "ValueError: inverse-square target DOI changed" := by
 unfold precheck
 rw [same,changed]
 rfl

def validateWith {α : Type} (record : Record) (blind : Unit → Except String α) : Except String α := do
 precheck record
 blind ()

theorem registeredDelegates {α : Type} (blind : Unit → Except String α) :
 validateWith registered blind = blind () := rfl

theorem failedRecordStops {α : Type} (record : Record) (blind : Unit → Except String α)
 (message : String) (failed : precheck record = .error message) :
 validateWith record blind = .error message := by
 unfold validateWith
 rw [failed]
 rfl
end SFT.Physics.InverseSquareIntervalSource
