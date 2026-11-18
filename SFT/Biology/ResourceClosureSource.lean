import SFT.Biology.MetabolismSource
namespace SFT.Biology.ResourceClosureSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := MetabolismSource.Snapshot
abbrev Source := MetabolismSource.Source
abbrev Requirement := MetabolismSource.Requirement
abbrev sources := MetabolismSource.sources
abbrev distinctIds := MetabolismSource.distinctIds
abbrev requirements := MetabolismSource.requirements
def expectedLabel : String := "biology:organism-environment-joint-carrier__uptake-transformation-export-cycle__all-required-inputs-and-losses-retained__finite-window-closure-test"
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
end SFT.Biology.ResourceClosureSource
