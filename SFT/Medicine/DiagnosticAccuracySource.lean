import SFT.Medicine.SymptomRecordSource
namespace SFT.Medicine.DiagnosticAccuracySource
abbrev Snapshot := SymptomRecordSource.Snapshot
abbrev readSnapshot := SymptomRecordSource.readSnapshot
abbrev requirements := SymptomRecordSource.requirements
abbrev sources := SymptomRecordSource.sources
def expectedLabel : String := "medicine:paired-index-and-reference-results__agreement-disagreement-incidence__complete-two-by-two-observation-table__target-population-spectrum-and-verification"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← SymptomRecordSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.DiagnosticAccuracySource
