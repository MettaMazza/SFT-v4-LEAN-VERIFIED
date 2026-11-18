import SFT.Medicine.IndividualInferenceSource
namespace SFT.Medicine.PopulationInferenceSource
abbrev Snapshot := IndividualInferenceSource.Snapshot
abbrev readSnapshot := IndividualInferenceSource.readSnapshot
abbrev requirements := IndividualInferenceSource.requirements
abbrev sources := IndividualInferenceSource.sources
def expectedLabel : String := "medicine:sample-and-source-population__sample-to-population-relation__selection-weights-and-missingness__eligibility-place-time-and-method"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← IndividualInferenceSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.PopulationInferenceSource
