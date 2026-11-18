import SFT.Medicine.ClinicalTrialSource
namespace SFT.Medicine.ObservationalStudySource
abbrev Snapshot := ClinicalTrialSource.Snapshot
abbrev readSnapshot := ClinicalTrialSource.readSnapshot
abbrev requirements := ClinicalTrialSource.requirements
abbrev sources := ClinicalTrialSource.sources
def expectedLabel : String := "medicine:sampled-person-records__observed-exposure-outcome-relation__sampling-selection-and-confounders__source-population-time-and-follow-up"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalTrialSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ObservationalStudySource
