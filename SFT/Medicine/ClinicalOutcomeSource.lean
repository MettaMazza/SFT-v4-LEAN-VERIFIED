import SFT.Medicine.ClinicalRiskSource
namespace SFT.Medicine.ClinicalOutcomeSource
abbrev Snapshot := ClinicalRiskSource.Snapshot
abbrev readSnapshot := ClinicalRiskSource.readSnapshot
abbrev requirements := ClinicalRiskSource.requirements
abbrev sources := ClinicalRiskSource.sources
def expectedLabel : String := "medicine:patient-endpoint-state__change-or-event-from-baseline__endpoint-definition-and-components__assessment-time-method-and-blinding"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalRiskSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalOutcomeSource
