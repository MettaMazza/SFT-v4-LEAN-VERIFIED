import SFT.Biology.ProteinSequenceSource
namespace SFT.Biology.ProteinEnsembleSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := ProteinSequenceSource.Snapshot
abbrev Source := ProteinSequenceSource.Source
abbrev Requirement := ProteinSequenceSource.Requirement
abbrev sources := ProteinSequenceSource.sources
abbrev distinctIds := ProteinSequenceSource.distinctIds
abbrev requirements := ProteinSequenceSource.requirements
def expectedLabel : String := "biology:complete-observed-conformation-support__interconversion-recurrence__populations-times-and-conditions-held__method-resolution-bounded"
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
end SFT.Biology.ProteinEnsembleSource
