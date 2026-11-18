import SFT.Medicine.ClinicalTrialSource
namespace SFT.Medicine.EvidenceSynthesisSource
abbrev Snapshot := ClinicalTrialSource.Snapshot
abbrev readSnapshot := ClinicalTrialSource.readSnapshot
abbrev requirements := ClinicalTrialSource.requirements
abbrev sources := ClinicalTrialSource.sources
def expectedLabel : String := "medicine:study-level-evidence-carriers__question-matched-composition__heterogeneity-bias-and-dependence-held__protocol-search-selection-and-date"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalTrialSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.EvidenceSynthesisSource
