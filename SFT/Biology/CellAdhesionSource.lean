import SFT.Biology.MulticellularCompositionSource
namespace SFT.Biology.CellAdhesionSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := MulticellularCompositionSource.Snapshot
abbrev Source := MulticellularCompositionSource.Source
abbrev Requirement := MulticellularCompositionSource.Requirement
abbrev sources := MulticellularCompositionSource.sources
abbrev distinctIds := MulticellularCompositionSource.distinctIds
abbrev requirements := MulticellularCompositionSource.requirements
def expectedLabel : String := "biology:cell-interface-carrier__specific-persistent-contact-relation__adhesion-components-mechanics-and-controls-held__tissue-condition-bounded"
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← MulticellularCompositionSource.extractRequirements files
 return (expectedLabel,extractionHash)
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← MulticellularCompositionSource.sourceDerivedTarget files
 return (expectedLabel,extractionHash)
theorem sourceReuse (files : List Snapshot) (label extractionHash : String)
 (checked : MulticellularCompositionSource.sourceDerivedTarget files = .ok (label,extractionHash)) :
 sourceDerivedTarget files = .ok (expectedLabel,extractionHash) := by
 unfold sourceDerivedTarget
 rw [checked]
 rfl
end SFT.Biology.CellAdhesionSource
