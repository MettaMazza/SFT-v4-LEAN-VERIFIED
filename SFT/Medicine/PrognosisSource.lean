import SFT.Medicine.ClinicalRiskSource
namespace SFT.Medicine.PrognosisSource
abbrev Snapshot := ClinicalRiskSource.Snapshot
abbrev readSnapshot := ClinicalRiskSource.readSnapshot
abbrev requirements := ClinicalRiskSource.requirements
abbrev sources := ClinicalRiskSource.sources
def expectedLabel : String := "medicine:patient-baseline-state__baseline-to-future-outcome-support__conditioned-course-alternatives__care-context-horizon-and-censoring"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalRiskSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.PrognosisSource
