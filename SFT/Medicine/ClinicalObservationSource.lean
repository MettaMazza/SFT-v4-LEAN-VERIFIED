import SFT.Medicine.PatientIdentitySource
namespace SFT.Medicine.ClinicalObservationSource
abbrev Snapshot := PatientIdentitySource.Snapshot
abbrev readSnapshot := PatientIdentitySource.readSnapshot
abbrev requirements := PatientIdentitySource.requirements
abbrev sources := PatientIdentitySource.sources
def expectedLabel : String := "medicine:patient-state-and-observer-record__observation-with-retained-method__source-method-result-provenance__declared-observer-instrument-setting-time"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← PatientIdentitySource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalObservationSource
