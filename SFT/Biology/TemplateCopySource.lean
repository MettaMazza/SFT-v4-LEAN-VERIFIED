import SFT.Biology.InheritanceSource
namespace SFT.Biology.TemplateCopySource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := InheritanceSource.Snapshot
abbrev Source := InheritanceSource.Source
abbrev Requirement := InheritanceSource.Requirement
abbrev sources := InheritanceSource.sources
abbrev distinctIds := InheritanceSource.distinctIds
abbrev requirements := InheritanceSource.requirements
def expectedLabel : String := "biology:template-and-product-carrier__positionwise-complement-or-copy-relation__template-product-distinction-retained__finite-word-boundary"
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← InheritanceSource.extractRequirements files
 return (expectedLabel,extractionHash)
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← InheritanceSource.sourceDerivedTarget files
 return (expectedLabel,extractionHash)
theorem sourceReuse (files : List Snapshot) (label extractionHash : String)
 (checked : InheritanceSource.sourceDerivedTarget files = .ok (label,extractionHash)) :
 sourceDerivedTarget files = .ok (expectedLabel,extractionHash) := by
 unfold sourceDerivedTarget
 rw [checked]
 rfl
end SFT.Biology.TemplateCopySource
