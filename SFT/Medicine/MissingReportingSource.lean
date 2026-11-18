import SFT.Medicine.ClinicalTrialSource
namespace SFT.Medicine.MissingReportingSource
abbrev Snapshot := ClinicalTrialSource.Snapshot
abbrev readSnapshot := ClinicalTrialSource.readSnapshot
abbrev requirements := ClinicalTrialSource.requirements
abbrev sources := ClinicalTrialSource.sources
def expectedLabel : String := "medicine:registered-and-observed-study-results__registration-publication-correspondence__reported-unreported-support__registry-search-and-cutoff-date"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalTrialSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.MissingReportingSource
