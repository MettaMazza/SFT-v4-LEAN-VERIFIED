import SFT.Medicine.ClinicalAssociationSource
namespace SFT.Medicine.ClinicalCauseSource
abbrev Snapshot := ClinicalAssociationSource.Snapshot
abbrev readSnapshot := ClinicalAssociationSource.readSnapshot
abbrev requirements := ClinicalAssociationSource.requirements
abbrev sources := ClinicalAssociationSource.sources
def expectedLabel : String := "medicine:exposure-intervention-and-outcome-traces__difference-under-lawful-comparison__counterfactual-or-interventional-contrast__exchangeability-time-and-follow-up"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalAssociationSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalCauseSource
