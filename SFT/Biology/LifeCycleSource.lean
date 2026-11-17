import SFT.Biology.OrganismSource
namespace SFT.Biology.LifeCycleSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := OrganismSource.Snapshot
abbrev Source := OrganismSource.Source
abbrev Requirement := OrganismSource.Requirement
abbrev sources := OrganismSource.sources
abbrev distinctIds := OrganismSource.distinctIds
abbrev requirements := OrganismSource.requirements
def expectedLabel : String := "biology:stage-transition-carrier__ordered-recurrent-stage-relation__development-reproduction-and-death-held__taxon-environment-bounded"
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← OrganismSource.extractRequirements files
 return (expectedLabel,extractionHash)
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← OrganismSource.sourceDerivedTarget files
 return (expectedLabel,extractionHash)
theorem sourceReuse (files : List Snapshot) (label extractionHash : String)
 (checked : OrganismSource.sourceDerivedTarget files = .ok (label,extractionHash)) :
 sourceDerivedTarget files = .ok (expectedLabel,extractionHash) := by
 unfold sourceDerivedTarget
 rw [checked]
 rfl
end SFT.Biology.LifeCycleSource
