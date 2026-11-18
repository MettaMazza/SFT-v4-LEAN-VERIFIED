import SFT.Medicine.ClinicalAssociationSource
namespace SFT.Medicine.ClinicalMechanismSource
abbrev Snapshot := ClinicalAssociationSource.Snapshot
abbrev readSnapshot := ClinicalAssociationSource.readSnapshot
abbrev requirements := ClinicalAssociationSource.requirements
abbrev sources := ClinicalAssociationSource.sources
def expectedLabel : String := "medicine:ordered-biological-clinical-mediators__exposure-to-mediator-to-outcome__noncollapsed-causal-chain__patient-condition-and-temporal-order"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalAssociationSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalMechanismSource
