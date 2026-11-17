import SFT.Biology.OrganismSource
namespace SFT.Biology.PhysiologySource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := OrganismSource.Snapshot
abbrev Source := OrganismSource.Source
abbrev Requirement := OrganismSource.Requirement
abbrev sources := OrganismSource.sources
abbrev distinctIds := OrganismSource.distinctIds
abbrev requirements := OrganismSource.requirements
def expectedLabel : String := "biology:organ-system-state-carrier__coordinated-function-transition__parts-flows-controls-and-time-held__organism-condition-bounded"
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
end SFT.Biology.PhysiologySource
