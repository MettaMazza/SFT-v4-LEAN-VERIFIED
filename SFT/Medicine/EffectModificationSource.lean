import SFT.Medicine.ClinicalAssociationSource
namespace SFT.Medicine.EffectModificationSource
abbrev Snapshot := ClinicalAssociationSource.Snapshot
abbrev readSnapshot := ClinicalAssociationSource.readSnapshot
abbrev requirements := ClinicalAssociationSource.requirements
abbrev sources := ClinicalAssociationSource.sources
def expectedLabel : String := "medicine:stratified-patient-carriers__contrast-varies-by-held-stratum__joint-treatment-stratum-outcome__predeclared-strata-and-scale"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalAssociationSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.EffectModificationSource
