import SFT.Host.Text
namespace SFT.Medicine.Screening
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-SCREENING-001","Screening","screening_prevention_treatment_rehabilitation","asymptomatic-eligible-population","test-to-follow-up-care-path","benefit-harm-and-overdiagnosis-chain","population-interval-and-program","Screening is the whole test-to-confirmation-to-care pathway in a declared asymptomatic population, including false results, overdiagnosis and downstream harms."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Screening
