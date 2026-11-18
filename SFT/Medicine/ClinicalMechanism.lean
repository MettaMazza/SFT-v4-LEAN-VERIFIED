import SFT.Host.Text
namespace SFT.Medicine.ClinicalMechanism
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-MECHANISM-001","Clinical mechanism","cause_association_mechanism_confounding","ordered-biological-clinical-mediators","exposure-to-mediator-to-outcome","noncollapsed-causal-chain","patient-condition-and-temporal-order","A clinical mechanism is an ordered, independently observed chain connecting exposure to outcome; a plausible biological name alone cannot close it."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalMechanism
