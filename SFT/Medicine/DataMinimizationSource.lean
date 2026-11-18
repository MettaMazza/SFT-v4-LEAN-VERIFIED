import SFT.Medicine.InformedConsentSource
namespace SFT.Medicine.DataMinimizationSource
abbrev Snapshot := InformedConsentSource.Snapshot
abbrev readSnapshot := InformedConsentSource.readSnapshot
abbrev requirements := InformedConsentSource.requirements
abbrev sources := InformedConsentSource.sources
def expectedLabel : String := "medicine:purpose-declared-data-fields__field-necessity-to-purpose__included-excluded-and-derived-fields__protocol-access-and-retention-period"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← InformedConsentSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.DataMinimizationSource
