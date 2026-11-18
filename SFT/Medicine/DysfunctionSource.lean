import SFT.Medicine.NormalVariationSource
namespace SFT.Medicine.DysfunctionSource
abbrev Snapshot := NormalVariationSource.Snapshot
abbrev readSnapshot := NormalVariationSource.readSnapshot
abbrev requirements := NormalVariationSource.requirements
abbrev sources := NormalVariationSource.sources
def expectedLabel : String := "medicine:person-function-state__impaired-relation-to-declared-function__function-context-and-consequence__method-and-baseline-boundary"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← NormalVariationSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.DysfunctionSource
