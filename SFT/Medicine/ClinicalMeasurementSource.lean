import SFT.Medicine.SymptomRecordSource
namespace SFT.Medicine.ClinicalMeasurementSource
abbrev Snapshot := SymptomRecordSource.Snapshot
abbrev readSnapshot := SymptomRecordSource.readSnapshot
abbrev requirements := SymptomRecordSource.requirements
abbrev sources := SymptomRecordSource.sources
def expectedLabel : String := "medicine:patient-specimen-or-signal__traceable-measurement-relation__method-unit-calibration-result__preanalytic-analytic-postanalytic-boundary"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← SymptomRecordSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalMeasurementSource
