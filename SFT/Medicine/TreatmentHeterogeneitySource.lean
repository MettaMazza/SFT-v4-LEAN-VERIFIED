import SFT.Medicine.EfficacySource
namespace SFT.Medicine.TreatmentHeterogeneitySource
abbrev Snapshot := EfficacySource.Snapshot
abbrev readSnapshot := EfficacySource.readSnapshot
abbrev requirements := EfficacySource.requirements
abbrev sources := EfficacySource.sources
def expectedLabel : String := "medicine:predeclared-patient-strata__arm-contrast-by-stratum__joint-stratum-arm-outcome__multiplicity-and-scale-boundary"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← EfficacySource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.TreatmentHeterogeneitySource
