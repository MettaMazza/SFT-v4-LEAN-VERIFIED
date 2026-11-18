import SFT.Medicine.IndividualInferenceSource
namespace SFT.Medicine.SubgroupMultiplicitySource
abbrev Snapshot := IndividualInferenceSource.Snapshot
abbrev readSnapshot := IndividualInferenceSource.readSnapshot
abbrev requirements := IndividualInferenceSource.requirements
abbrev sources := IndividualInferenceSource.sources
def expectedLabel : String := "medicine:generated-subgroup-comparisons__comparison-count-and-result-incidence__complete-tested-family__predeclaration-and-selection-boundary"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← IndividualInferenceSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.SubgroupMultiplicitySource
