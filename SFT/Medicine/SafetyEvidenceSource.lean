import SFT.Medicine.EfficacySource
namespace SFT.Medicine.SafetyEvidenceSource
abbrev Snapshot := EfficacySource.Snapshot
abbrev readSnapshot := EfficacySource.readSnapshot
abbrev requirements := EfficacySource.requirements
abbrev sources := EfficacySource.sources
def expectedLabel : String := "medicine:all-exposed-and-comparator-participants__favorable-and-unfavorable-event-incidence__complete-event-severity-time-support__exposure-duration-and-follow-up"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← EfficacySource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.SafetyEvidenceSource
