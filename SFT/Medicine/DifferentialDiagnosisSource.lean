import SFT.Medicine.SymptomRecordSource
namespace SFT.Medicine.DifferentialDiagnosisSource
abbrev Snapshot := SymptomRecordSource.Snapshot
abbrev readSnapshot := SymptomRecordSource.readSnapshot
abbrev requirements := SymptomRecordSource.requirements
abbrev sources := SymptomRecordSource.sources
def expectedLabel : String := "medicine:candidate-condition-support__evidence-conditioned-elimination__retained-alternative-support__patient-context-and-test-sequence"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← SymptomRecordSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.DifferentialDiagnosisSource
