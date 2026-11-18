import SFT.Medicine.NormalVariationSource
namespace SFT.Medicine.ComorbiditySource
abbrev Snapshot := NormalVariationSource.Snapshot
abbrev readSnapshot := NormalVariationSource.readSnapshot
abbrev requirements := NormalVariationSource.requirements
abbrev sources := NormalVariationSource.sources
def expectedLabel : String := "medicine:joint-patient-condition-state__co-occurrence-with-interaction-held__noncollapsed-joint-condition-word__shared-patient-and-interval"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← NormalVariationSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ComorbiditySource
