import SFT.Medicine.EfficacySource
namespace SFT.Medicine.AbsoluteRelativeEffectSource
abbrev Snapshot := EfficacySource.Snapshot
abbrev readSnapshot := EfficacySource.readSnapshot
abbrev requirements := EfficacySource.requirements
abbrev sources := EfficacySource.sources
def expectedLabel : String := "medicine:arm-specific-outcome-counts__absolute-and-relative-comparison__complete-two-arm-event-table__population-and-horizon"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← EfficacySource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.AbsoluteRelativeEffectSource
