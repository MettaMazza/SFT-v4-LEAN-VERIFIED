import SFT.Host.Text
namespace SFT.Medicine.ClinicalTrial
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-TRIAL-001","Clinical trial","trial_observational_synthesis","eligible-participant-traces","prospective-allocation-and-outcome","protocol-arms-flow-and-analysis","registered-setting-time-and-endpoints","A trial is a prospective finite process retaining protocol, eligibility, allocation, arm flow, outcomes, deviations and all analyses."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalTrial
