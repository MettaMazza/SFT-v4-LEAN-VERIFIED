import SFT.Medicine.IndividualInferenceSource
namespace SFT.Medicine.TransportabilitySource
abbrev Snapshot := IndividualInferenceSource.Snapshot
abbrev readSnapshot := IndividualInferenceSource.readSnapshot
abbrev requirements := IndividualInferenceSource.requirements
abbrev sources := IndividualInferenceSource.sources
def expectedLabel : String := "medicine:source-and-target-populations__invariant-and-different-features__joint-population-treatment-outcome__setting-time-and-care-system"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← IndividualInferenceSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.TransportabilitySource
