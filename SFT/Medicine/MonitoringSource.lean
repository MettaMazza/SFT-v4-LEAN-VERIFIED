import SFT.Medicine.ScreeningSource
namespace SFT.Medicine.MonitoringSource
abbrev Snapshot := ScreeningSource.Snapshot
abbrev readSnapshot := ScreeningSource.readSnapshot
abbrev requirements := ScreeningSource.requirements
abbrev sources := ScreeningSource.sources
def expectedLabel : String := "medicine:ordered-patient-measurements__change-to-decision-relation__schedule-threshold-action-trace__method-interval-and-care-context"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ScreeningSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.MonitoringSource
