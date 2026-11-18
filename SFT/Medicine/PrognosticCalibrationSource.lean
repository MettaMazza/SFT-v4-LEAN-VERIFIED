import SFT.Medicine.ClinicalRiskSource
namespace SFT.Medicine.PrognosticCalibrationSource
abbrev Snapshot := ClinicalRiskSource.Snapshot
abbrev readSnapshot := ClinicalRiskSource.readSnapshot
abbrev requirements := ClinicalRiskSource.requirements
abbrev sources := ClinicalRiskSource.sources
def expectedLabel : String := "medicine:predicted-and-observed-risk-groups__prediction-observation-incidence__complete-calibration-table__new-population-and-time-window"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalRiskSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.PrognosticCalibrationSource
