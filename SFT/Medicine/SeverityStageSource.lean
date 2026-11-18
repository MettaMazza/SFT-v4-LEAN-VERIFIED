import SFT.Medicine.NormalVariationSource
namespace SFT.Medicine.SeverityStageSource
abbrev Snapshot := NormalVariationSource.Snapshot
abbrev readSnapshot := NormalVariationSource.readSnapshot
abbrev requirements := NormalVariationSource.requirements
abbrev sources := NormalVariationSource.sources
def expectedLabel : String := "medicine:disease-or-injury-course__ordered-extent-relation__criteria-specific-partial-order__method-time-and-organ-system"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← NormalVariationSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.SeverityStageSource
