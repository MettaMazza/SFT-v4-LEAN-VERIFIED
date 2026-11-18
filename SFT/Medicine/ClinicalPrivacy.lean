import SFT.Host.Text
namespace SFT.Medicine.ClinicalPrivacy
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-PRIVACY-001","Clinical privacy","consent_ethics_privacy_uncertainty","person-linked-health-record","purpose-bound-access-and-disclosure","identity-content-recipient-trace","consent-law-purpose-and-time","Clinical privacy requires purpose-bound access, minimized disclosure and a complete identity-content-recipient-time trace; public evidence may not expose an unnecessary person link."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalPrivacy
