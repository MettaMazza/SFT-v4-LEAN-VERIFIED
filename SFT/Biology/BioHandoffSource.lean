import SFT.Biology.BioSpecimenSource
namespace SFT.Biology.BioHandoffSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := BioSpecimenSource.Snapshot
abbrev Source := BioSpecimenSource.Source
abbrev Requirement := BioSpecimenSource.Requirement
abbrev sources := BioSpecimenSource.sources
abbrev distinctIds := BioSpecimenSource.distinctIds
abbrev requirements := BioSpecimenSource.requirements
def expectedLabel : String := "biology:source-law-interface-carrier__upstream-to-biological-composition__ownership-assumptions-and-losses-held__discipline-boundary-declared"
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← BioSpecimenSource.extractRequirements files
 return (expectedLabel,extractionHash)
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← BioSpecimenSource.sourceDerivedTarget files
 return (expectedLabel,extractionHash)
theorem sourceReuse (files : List Snapshot) (label extractionHash : String)
 (checked : BioSpecimenSource.sourceDerivedTarget files = .ok (label,extractionHash)) :
 sourceDerivedTarget files = .ok (expectedLabel,extractionHash) := by
 unfold sourceDerivedTarget
 rw [checked]
 rfl
end SFT.Biology.BioHandoffSource
