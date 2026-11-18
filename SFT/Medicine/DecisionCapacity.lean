import SFT.Host.Text
namespace SFT.Medicine.DecisionCapacity
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-DECISION-CAPACITY-001","Decision capacity boundary","consent_ethics_privacy_uncertainty","person-decision-context","understand-retain-weigh-communicate","decision-specific-support-and-assistance","time-decision-and-assessment-method","Capacity is decision- and time-specific evidence over retained abilities and assistance; diagnosis or status alone cannot erase the person's choice."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.DecisionCapacity
