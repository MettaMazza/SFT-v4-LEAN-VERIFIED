import SFT.Medicine.PatientIdentitySource
namespace SFT.Medicine.LongitudinalCourseSource
abbrev Snapshot := PatientIdentitySource.Snapshot
abbrev readSnapshot := PatientIdentitySource.readSnapshot
abbrev requirements := PatientIdentitySource.requirements
abbrev sources := PatientIdentitySource.sources
def expectedLabel : String := "medicine:ordered-patient-states__within-person-transition-relation__course-with-missing-visits-held__declared-follow-up-and-censoring"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← PatientIdentitySource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.LongitudinalCourseSource
