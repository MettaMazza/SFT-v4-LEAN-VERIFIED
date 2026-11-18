import SFT.Medicine.ClinicalAssociationSource
namespace SFT.Medicine.MediationSource
abbrev Snapshot := ClinicalAssociationSource.Snapshot
abbrev readSnapshot := ClinicalAssociationSource.readSnapshot
abbrev requirements := ClinicalAssociationSource.requirements
abbrev sources := ClinicalAssociationSource.sources
def expectedLabel : String := "medicine:exposure-mediator-outcome-word__ordered-indirect-and-direct-paths__path-specific-support__intervention-and-measurement-times"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalAssociationSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.MediationSource
