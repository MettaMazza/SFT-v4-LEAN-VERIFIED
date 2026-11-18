import SFT.Medicine.DoseSource
namespace SFT.Medicine.AdverseEventSource
abbrev Snapshot := DoseSource.Snapshot
abbrev readSnapshot := DoseSource.readSnapshot
abbrev requirements := DoseSource.requirements
abbrev sources := DoseSource.sources
def expectedLabel : String := "medicine:participant-unfavorable-event__event-after-exposure-or-care__seriousness-severity-relatedness-outcome__solicitation-time-and-follow-up"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← DoseSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.AdverseEventSource
