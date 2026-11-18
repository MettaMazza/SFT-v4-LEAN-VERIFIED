import SFT.Medicine.DoseSource
namespace SFT.Medicine.ClinicalExposureSource
abbrev Snapshot := DoseSource.Snapshot
abbrev readSnapshot := DoseSource.readSnapshot
abbrev requirements := DoseSource.requirements
abbrev sources := DoseSource.sources
def expectedLabel : String := "medicine:person-agent-contact-word__contact-intensity-duration-route__source-path-person-time__measurement-and-reconstruction-method"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← DoseSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalExposureSource
