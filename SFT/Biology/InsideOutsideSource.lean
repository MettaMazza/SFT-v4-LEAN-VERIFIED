import SFT.Biology.CompartmentSource
namespace SFT.Biology.InsideOutsideSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := CompartmentSource.Snapshot
abbrev Source := CompartmentSource.Source
abbrev Requirement := CompartmentSource.Requirement
abbrev sources := CompartmentSource.sources
abbrev distinctIds := CompartmentSource.distinctIds
abbrev requirements := CompartmentSource.requirements
def expectedLabel : String := "biology:oriented-boundary-carrier__opposed-side-label-relation__two-sides-never-merged__observer-orientation-declared"
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← CompartmentSource.extractRequirements files
 return (expectedLabel,extractionHash)
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← CompartmentSource.sourceDerivedTarget files
 return (expectedLabel,extractionHash)
theorem sourceReuse (files : List Snapshot) (label extractionHash : String)
 (checked : CompartmentSource.sourceDerivedTarget files = .ok (label,extractionHash)) :
 sourceDerivedTarget files = .ok (expectedLabel,extractionHash) := by
 unfold sourceDerivedTarget
 rw [checked]
 rfl
end SFT.Biology.InsideOutsideSource
