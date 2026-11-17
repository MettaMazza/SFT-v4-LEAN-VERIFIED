import SFT.Biology.ProteinSequenceSource
namespace SFT.Biology.ProteinFunctionSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := ProteinSequenceSource.Snapshot
abbrev Source := ProteinSequenceSource.Source
abbrev Requirement := ProteinSequenceSource.Requirement
abbrev sources := ProteinSequenceSource.sources
abbrev distinctIds := ProteinSequenceSource.distinctIds
abbrev requirements := ProteinSequenceSource.requirements
def expectedLabel : String := "biology:protein-context-process-carrier__protein-dependent-process-difference__sequence-structure-context-and-controls-held__assay-and-organism-bounded"
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← ProteinSequenceSource.extractRequirements files
 return (expectedLabel,extractionHash)
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← ProteinSequenceSource.sourceDerivedTarget files
 return (expectedLabel,extractionHash)
theorem sourceReuse (files : List Snapshot) (label extractionHash : String)
 (checked : ProteinSequenceSource.sourceDerivedTarget files = .ok (label,extractionHash)) :
 sourceDerivedTarget files = .ok (expectedLabel,extractionHash) := by
 unfold sourceDerivedTarget
 rw [checked]
 rfl
end SFT.Biology.ProteinFunctionSource
