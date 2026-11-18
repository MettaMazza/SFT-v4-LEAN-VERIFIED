import SFT.Medicine.ClinicalRiskSource
namespace SFT.Medicine.CensoringCompetingSource
abbrev Snapshot := ClinicalRiskSource.Snapshot
abbrev readSnapshot := ClinicalRiskSource.readSnapshot
abbrev requirements := ClinicalRiskSource.requirements
abbrev sources := ClinicalRiskSource.sources
def expectedLabel : String := "medicine:incomplete-patient-course__observability-and-competing-transition__retained-unobserved-support__reason-time-and-follow-up"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalRiskSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.CensoringCompetingSource
