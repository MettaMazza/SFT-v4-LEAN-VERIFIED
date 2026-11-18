import SFT.Medicine.DoseSource
namespace SFT.Medicine.ClinicalToxicitySource
abbrev Snapshot := DoseSource.Snapshot
abbrev readSnapshot := DoseSource.readSnapshot
abbrev requirements := DoseSource.requirements
abbrev sources := DoseSource.sources
def expectedLabel : String := "medicine:exposure-and-harm-state__exposure-linked-dysfunction-or-injury__organ-course-dose-and-recovery__method-population-and-time"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← DoseSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalToxicitySource
