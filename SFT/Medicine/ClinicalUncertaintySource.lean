import SFT.Medicine.IndividualInferenceSource
namespace SFT.Medicine.ClinicalUncertaintySource
abbrev Snapshot := IndividualInferenceSource.Snapshot
abbrev readSnapshot := IndividualInferenceSource.readSnapshot
abbrev requirements := IndividualInferenceSource.requirements
abbrev sources := IndividualInferenceSource.sources
def expectedLabel : String := "medicine:retained-admissible-clinical-states__evidence-conditioned-support__known-missing-and-unknown-record__decision-and-observation-boundary"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← IndividualInferenceSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalUncertaintySource
