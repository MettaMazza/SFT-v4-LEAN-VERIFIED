import SFT.Biology.CellIdentitySource
namespace SFT.Biology.CellDivisionSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := CellIdentitySource.Snapshot
abbrev Source := CellIdentitySource.Source
abbrev Requirement := CellIdentitySource.Requirement
abbrev sources := CellIdentitySource.sources
abbrev distinctIds := CellIdentitySource.distinctIds
abbrev requirements := CellIdentitySource.requirements
def expectedLabel : String := "biology:one-cell-lineage-carrier__one-predecessor-to-partitioned-successors__genome-cytoplasm-boundary-and-errors-held__division-cycle-bounded"
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← CellIdentitySource.extractRequirements files
 return (expectedLabel,extractionHash)
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← CellIdentitySource.sourceDerivedTarget files
 return (expectedLabel,extractionHash)
theorem sourceReuse (files : List Snapshot) (label extractionHash : String)
 (checked : CellIdentitySource.sourceDerivedTarget files = .ok (label,extractionHash)) :
 sourceDerivedTarget files = .ok (expectedLabel,extractionHash) := by
 unfold sourceDerivedTarget
 rw [checked]
 rfl
end SFT.Biology.CellDivisionSource
