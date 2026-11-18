import SFT.Medicine.PatientIdentitySource
namespace SFT.Medicine.ClinicalPopulationSource
abbrev Snapshot := PatientIdentitySource.Snapshot
abbrev readSnapshot := PatientIdentitySource.readSnapshot
abbrev requirements := PatientIdentitySource.requirements
abbrev sources := PatientIdentitySource.sources
def expectedLabel : String := "medicine:finite-person-carriers__membership-under-declared-criteria__population-with-each-person-held__place-time-source-frame"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← PatientIdentitySource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalPopulationSource
