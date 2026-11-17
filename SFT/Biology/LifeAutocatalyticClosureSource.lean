import SFT.Biology.LifeOrganizationSource
namespace SFT.Biology.LifeAutocatalyticClosureSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := LifeOrganizationSource.Snapshot
abbrev Source := LifeOrganizationSource.Source
abbrev Requirement := LifeOrganizationSource.Requirement
abbrev sources := LifeOrganizationSource.sources
abbrev distinctIds := LifeOrganizationSource.distinctIds
abbrev readSnapshot := LifeOrganizationSource.readSnapshot
abbrev corpus := LifeOrganizationSource.corpus
abbrev validateSources := LifeOrganizationSource.validateSources
def requirements : List Requirement := [⟨"SFT-BIO-SRC-NASEM-UNITY-BIOLOGY-2010","cell is the smallest independent unit of life"⟩,⟨"SFT-BIO-SRC-NCBI-CELL-ORIGIN-METABOLISM","metabolic energy"⟩]
def expectedLabel : String := "biology:complete-catalytic-network__product-to-required-catalyst-recurrence__boundary-and-resource-input-retained__finite-network-closure-test"
theorem sourceRequirementsExact : requirements = LifeOrganizationSource.requirements := rfl

def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← LifeOrganizationSource.extractRequirements files
 return (expectedLabel,extractionHash)
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← LifeOrganizationSource.sourceDerivedTarget files
 return (expectedLabel,extractionHash)
theorem sourceReuse (files : List Snapshot) (label extractionHash : String)
 (checked : LifeOrganizationSource.sourceDerivedTarget files = .ok (label,extractionHash)) :
 sourceDerivedTarget files = .ok (expectedLabel,extractionHash) := by
 unfold sourceDerivedTarget
 rw [checked]
 rfl
end SFT.Biology.LifeAutocatalyticClosureSource
