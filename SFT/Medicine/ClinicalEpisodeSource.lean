import SFT.Medicine.PatientIdentitySource
namespace SFT.Medicine.ClinicalEpisodeSource
abbrev Snapshot := PatientIdentitySource.Snapshot
abbrev readSnapshot := PatientIdentitySource.readSnapshot
abbrev requirements := PatientIdentitySource.requirements
abbrev sources := PatientIdentitySource.sources
def expectedLabel : String := "medicine:patient-episode__ordered-observation-and-action-trace__bounded-episode-with-start-and-stop__declared-setting-and-follow-up"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← PatientIdentitySource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalEpisodeSource
