import SFT.Medicine.ClinicalRiskSource
namespace SFT.Medicine.IncidencePrevalenceSource
abbrev Snapshot := ClinicalRiskSource.Snapshot
abbrev readSnapshot := ClinicalRiskSource.readSnapshot
abbrev requirements := ClinicalRiskSource.requirements
abbrev sources := ClinicalRiskSource.sources
def expectedLabel : String := "medicine:population-condition-records__new-event-versus-state-support__flow-and-stock-kept-distinct__population-and-time-boundary"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalRiskSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.IncidencePrevalenceSource
