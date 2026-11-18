import SFT.Medicine.SymptomRecordSource
namespace SFT.Medicine.ClinicalSignSource
abbrev Snapshot := SymptomRecordSource.Snapshot
abbrev readSnapshot := SymptomRecordSource.readSnapshot
abbrev requirements := SymptomRecordSource.requirements
abbrev sources := SymptomRecordSource.sources
def expectedLabel : String := "medicine:observer-elicited-patient-feature__feature-to-method-relation__observer-method-result-record__setting-time-and-observer"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← SymptomRecordSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalSignSource
