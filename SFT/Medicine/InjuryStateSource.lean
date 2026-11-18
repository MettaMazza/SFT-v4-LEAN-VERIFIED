import SFT.Medicine.NormalVariationSource
namespace SFT.Medicine.InjuryStateSource
abbrev Snapshot := NormalVariationSource.Snapshot
abbrev readSnapshot := NormalVariationSource.readSnapshot
abbrev requirements := NormalVariationSource.requirements
abbrev sources := NormalVariationSource.sources
def expectedLabel : String := "medicine:patient-tissue-or-function-state__damage-following-declared-exposure__exposure-damage-consequence-trace__site-time-severity-method"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← NormalVariationSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.InjuryStateSource
