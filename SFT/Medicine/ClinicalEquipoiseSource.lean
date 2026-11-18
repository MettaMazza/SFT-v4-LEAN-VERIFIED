import SFT.Medicine.InformedConsentSource
namespace SFT.Medicine.ClinicalEquipoiseSource
abbrev Snapshot := InformedConsentSource.Snapshot
abbrev readSnapshot := InformedConsentSource.readSnapshot
abbrev requirements := InformedConsentSource.requirements
abbrev sources := InformedConsentSource.sources
def expectedLabel : String := "medicine:competing-care-support__unresolved-comparative-benefit-harm__monitoring-and-stopping-rules__evidence-date-population-and-oversight"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← InformedConsentSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalEquipoiseSource
