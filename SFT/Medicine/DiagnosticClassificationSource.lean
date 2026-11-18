import SFT.Medicine.SymptomRecordSource
namespace SFT.Medicine.DiagnosticClassificationSource
abbrev Snapshot := SymptomRecordSource.Snapshot
abbrev readSnapshot := SymptomRecordSource.readSnapshot
abbrev requirements := SymptomRecordSource.requirements
abbrev sources := SymptomRecordSource.sources
def expectedLabel : String := "medicine:patient-evidence-word__criteria-to-class-relation__classification-with-alternatives-held__reference-standard-and-verification"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← SymptomRecordSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.DiagnosticClassificationSource
