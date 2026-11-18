import SFT.Medicine.InformedConsentSource
namespace SFT.Medicine.ClinicalEvidenceHandoffSource
abbrev Snapshot := InformedConsentSource.Snapshot
abbrev readSnapshot := InformedConsentSource.readSnapshot
abbrev requirements := InformedConsentSource.requirements
abbrev sources := InformedConsentSource.sources
def expectedLabel : String := "medicine:consented-deidentified-evidence-record__claim-to-reviewer-reconstruction__derivation-data-code-adverse-results__purpose-access-version-and-custody"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← InformedConsentSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalEvidenceHandoffSource
