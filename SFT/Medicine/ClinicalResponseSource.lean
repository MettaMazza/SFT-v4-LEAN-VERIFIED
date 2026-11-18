import SFT.Medicine.DoseSource
namespace SFT.Medicine.ClinicalResponseSource
abbrev Snapshot := DoseSource.Snapshot
abbrev readSnapshot := DoseSource.readSnapshot
abbrev requirements := DoseSource.requirements
abbrev sources := DoseSource.sources
def expectedLabel : String := "medicine:patient-baseline-and-follow-up-state__change-after-exposure-or-intervention__multidomain-course-with-controls__outcome-method-and-time"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← DoseSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalResponseSource
