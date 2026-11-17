import SFT.Host.Text
namespace SFT.Biology.Homeostasis
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-HOMEOSTASIS-001","Homeostatic regulation","organism_physiology","regulated-variable-control-carrier","departure-sensing-response-return-relation","set-range-delay-and-failure-held","condition-and-time-bounded","Homeostasis is a closed sensing-and-response recurrence that returns a biological variable to a declared viable range while preserving delays, overshoot and failure cases."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.Homeostasis
