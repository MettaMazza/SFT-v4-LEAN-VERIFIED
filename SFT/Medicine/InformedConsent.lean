import SFT.Host.Text
namespace SFT.Medicine.InformedConsent
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-INFORMED-CONSENT-001","Informed consent boundary","consent_ethics_privacy_uncertainty","person-information-choice-record","understanding-voluntariness-authorization","versioned-scope-and-withdrawal","purpose-time-capacity-and-recorder","A consent record is valid only for its declared person, information, understanding, voluntariness, purpose, scope and time, with refusal and withdrawal retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.InformedConsent
