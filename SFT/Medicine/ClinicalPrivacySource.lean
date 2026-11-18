import SFT.Medicine.InformedConsentSource
namespace SFT.Medicine.ClinicalPrivacySource
abbrev Snapshot := InformedConsentSource.Snapshot
abbrev readSnapshot := InformedConsentSource.readSnapshot
abbrev requirements := InformedConsentSource.requirements
abbrev sources := InformedConsentSource.sources
def expectedLabel : String := "medicine:person-linked-health-record__purpose-bound-access-and-disclosure__identity-content-recipient-trace__consent-law-purpose-and-time"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← InformedConsentSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ClinicalPrivacySource
