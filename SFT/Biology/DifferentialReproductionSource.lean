import SFT.Biology.BiologicalVariationSource
namespace SFT.Biology.DifferentialReproductionSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := BiologicalVariationSource.Snapshot
abbrev Source := BiologicalVariationSource.Source
abbrev Requirement := BiologicalVariationSource.Requirement
abbrev sources := BiologicalVariationSource.sources
abbrev distinctIds := BiologicalVariationSource.distinctIds
abbrev requirements := BiologicalVariationSource.requirements
def expectedLabel : String := "biology:typed-lineage-carrier__type-specific-successor-count__exposure-survival-and-fecundity-ledger__generation-window-declared"
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
end SFT.Biology.DifferentialReproductionSource
