import SFT.Medicine.EfficacySource
namespace SFT.Medicine.EffectivenessSource
abbrev Snapshot := EfficacySource.Snapshot
abbrev readSnapshot := EfficacySource.readSnapshot
abbrev requirements := EfficacySource.requirements
abbrev sources := EfficacySource.sources
def expectedLabel : String := "medicine:practice-intervention-comparison__outcome-contrast-under-usual-care__delivery-adherence-context-variation__practice-population-and-horizon"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← EfficacySource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.EffectivenessSource
