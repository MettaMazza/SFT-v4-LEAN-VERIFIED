import SFT.Biology.MulticellularCompositionSource
namespace SFT.Biology.MorphogenesisSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := MulticellularCompositionSource.Snapshot
abbrev Source := MulticellularCompositionSource.Source
abbrev Requirement := MulticellularCompositionSource.Requirement
abbrev sources := MulticellularCompositionSource.sources
abbrev distinctIds := MulticellularCompositionSource.distinctIds
abbrev requirements := MulticellularCompositionSource.requirements
def expectedLabel : String := "biology:cell-state-spatial-carrier__local-transition-to-global-form__neighbour-boundary-force-and-time-held__scale-and-stage-bounded"
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
end SFT.Biology.MorphogenesisSource
