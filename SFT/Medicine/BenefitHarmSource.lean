import SFT.Medicine.EfficacySource
namespace SFT.Medicine.BenefitHarmSource
abbrev Snapshot := EfficacySource.Snapshot
abbrev readSnapshot := EfficacySource.readSnapshot
abbrev requirements := EfficacySource.requirements
abbrev sources := EfficacySource.sources
def expectedLabel : String := "medicine:joint-benefit-and-harm-outcomes__noncollapsed-outcome-comparison__patient-valued-components-held__population-horizon-and-preference-boundary"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← EfficacySource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.BenefitHarmSource
