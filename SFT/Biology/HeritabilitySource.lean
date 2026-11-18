import SFT.Biology.BiologicalVariationSource
namespace SFT.Biology.HeritabilitySource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := BiologicalVariationSource.Snapshot
abbrev Source := BiologicalVariationSource.Source
abbrev Requirement := BiologicalVariationSource.Requirement
abbrev sources := BiologicalVariationSource.sources
abbrev distinctIds := BiologicalVariationSource.distinctIds
abbrev requirements := BiologicalVariationSource.requirements
def expectedLabel : String := "biology:related-generation-carrier__predecessor-successor-covariation__environment-and-carrier-context-retained__population-and-generation-bounded"
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← BiologicalVariationSource.extractRequirements files
 return (expectedLabel,extractionHash)
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← BiologicalVariationSource.sourceDerivedTarget files
 return (expectedLabel,extractionHash)
theorem sourceReuse (files : List Snapshot) (label extractionHash : String)
 (checked : BiologicalVariationSource.sourceDerivedTarget files = .ok (label,extractionHash)) :
 sourceDerivedTarget files = .ok (expectedLabel,extractionHash) := by
 unfold sourceDerivedTarget
 rw [checked]
 rfl
end SFT.Biology.HeritabilitySource
