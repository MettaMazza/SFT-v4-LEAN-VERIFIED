import SFT.Medicine.ClinicalAssociationSource
namespace SFT.Medicine.ConfoundingSource
abbrev Snapshot := ClinicalAssociationSource.Snapshot
abbrev readSnapshot := ClinicalAssociationSource.readSnapshot
abbrev requirements := ClinicalAssociationSource.requirements
abbrev sources := ClinicalAssociationSource.sources
def expectedLabel : String := "medicine:exposure-outcome-common-cause-word__common-cause-distortion-relation__measured-and-unmeasured-support__design-and-adjustment-boundary"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalAssociationSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ConfoundingSource
