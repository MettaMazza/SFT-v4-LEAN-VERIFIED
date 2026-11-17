import SFT.Biology.PopulationSource
namespace SFT.Biology.TrophicNetworkSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := PopulationSource.Snapshot
abbrev Source := PopulationSource.Source
abbrev Requirement := PopulationSource.Requirement
abbrev sources := PopulationSource.sources
abbrev distinctIds := PopulationSource.distinctIds
abbrev requirements := PopulationSource.requirements
def expectedLabel : String := "biology:population-resource-directed-network__consumption-and-transfer-edge__amount-direction-loss-and-provenance-held__ecosystem-window-declared"
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← PopulationSource.extractRequirements files
 return (expectedLabel,extractionHash)
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,extractionHash) ← PopulationSource.sourceDerivedTarget files
 return (expectedLabel,extractionHash)
theorem sourceReuse (files : List Snapshot) (label extractionHash : String)
 (checked : PopulationSource.sourceDerivedTarget files = .ok (label,extractionHash)) :
 sourceDerivedTarget files = .ok (expectedLabel,extractionHash) := by
 unfold sourceDerivedTarget
 rw [checked]
 rfl
end SFT.Biology.TrophicNetworkSource
