import SFT.Medicine.ClinicalTrialSource
namespace SFT.Medicine.RandomizationSource
abbrev Snapshot := ClinicalTrialSource.Snapshot
abbrev readSnapshot := ClinicalTrialSource.readSnapshot
abbrev requirements := ClinicalTrialSource.requirements
abbrev sources := ClinicalTrialSource.sources
def expectedLabel : String := "medicine:eligible-participants-and-held-generator-state__concealed-unpredictable-assignment__reconstructible-sequence-and-custody__generation-concealment-release-boundary"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ClinicalTrialSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.RandomizationSource
