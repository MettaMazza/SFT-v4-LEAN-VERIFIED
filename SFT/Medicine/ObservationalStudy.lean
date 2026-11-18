import SFT.Host.Text
namespace SFT.Medicine.ObservationalStudy
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-OBSERVATIONAL-STUDY-001","Observational clinical study","trial_observational_synthesis","sampled-person-records","observed-exposure-outcome-relation","sampling-selection-and-confounders","source-population-time-and-follow-up","An observational study retains source population, sampling, exposure, outcomes, confounders, missingness and follow-up and does not silently become an intervention."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ObservationalStudy
