import SFT.Medicine.NormalVariationSource
namespace SFT.Medicine.DiseaseStateSource
abbrev Snapshot := NormalVariationSource.Snapshot
abbrev readSnapshot := NormalVariationSource.readSnapshot
abbrev requirements := NormalVariationSource.requirements
abbrev sources := NormalVariationSource.sources
def expectedLabel : String := "medicine:patient-process-state__persistent-or-recurrent-harmful-process__mechanism-manifestation-course__diagnostic-criteria-and-time"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← NormalVariationSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.DiseaseStateSource
