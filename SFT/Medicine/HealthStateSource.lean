import SFT.Medicine.PatientIdentitySource
namespace SFT.Medicine.HealthStateSource
abbrev Snapshot := PatientIdentitySource.Snapshot
abbrev readSnapshot := PatientIdentitySource.readSnapshot
abbrev requirements := PatientIdentitySource.requirements
abbrev sources := PatientIdentitySource.sources
def expectedLabel : String := "medicine:person-or-population-state__function-and-capacity-relation__multidomain-state-with-context__declared-measures-and-time"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← PatientIdentitySource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.HealthStateSource
