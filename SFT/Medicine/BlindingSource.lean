import SFT.Medicine.ClinicalTrialSource
namespace SFT.Medicine.BlindingSource
abbrev Snapshot := ClinicalTrialSource.Snapshot
abbrev readSnapshot := ClinicalTrialSource.readSnapshot
abbrev requirements := ClinicalTrialSource.requirements
abbrev sources := ClinicalTrialSource.sources
def expectedLabel : String := "medicine:participant-carer-assessor-role-word__role-to-allocation-access-restriction__access-and-unblinding-trace__stage-role-and-information-boundary"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalTrialSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.BlindingSource
