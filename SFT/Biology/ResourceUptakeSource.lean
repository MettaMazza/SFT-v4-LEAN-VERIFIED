import SFT.Biology.MetabolismSource
namespace SFT.Biology.ResourceUptakeSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := MetabolismSource.Snapshot
abbrev Source := MetabolismSource.Source
abbrev Requirement := MetabolismSource.Requirement
abbrev sources := MetabolismSource.sources
abbrev distinctIds := MetabolismSource.distinctIds
abbrev requirements := MetabolismSource.requirements
def expectedLabel : String := "biology:external-resource-and-boundary-carrier__external-to-internal-transfer__source-identity-and-path-retained__availability-and-time-bounded"
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← MetabolismSource.extractRequirements files
 return (expectedLabel,extractionHash)
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← MetabolismSource.sourceDerivedTarget files
 return (expectedLabel,extractionHash)
theorem sourceReuse (files : List Snapshot) (label extractionHash : String)
 (checked : MetabolismSource.sourceDerivedTarget files = .ok (label,extractionHash)) :
 sourceDerivedTarget files = .ok (expectedLabel,extractionHash) := by
 unfold sourceDerivedTarget
 rw [checked]
 rfl
end SFT.Biology.ResourceUptakeSource
