import SFT.Medicine.IndividualInferenceSource
namespace SFT.Medicine.ClinicalDecisionSource
abbrev Snapshot := IndividualInferenceSource.Snapshot
abbrev readSnapshot := IndividualInferenceSource.readSnapshot
abbrev requirements := IndividualInferenceSource.requirements
abbrev sources := IndividualInferenceSource.sources
def expectedLabel : String := "medicine:patient-action-alternatives__evidence-consequence-preference-relation__all-actions-outcomes-and-values__decision-maker-time-and-resource-boundary"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← IndividualInferenceSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalDecisionSource
