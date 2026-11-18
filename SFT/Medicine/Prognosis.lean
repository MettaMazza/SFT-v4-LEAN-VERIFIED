import SFT.Host.Text
namespace SFT.Medicine.Prognosis
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-PROGNOSIS-001","Clinical prognosis","risk_prognosis_outcome","patient-baseline-state","baseline-to-future-outcome-support","conditioned-course-alternatives","care-context-horizon-and-censoring","Prognosis is the exact support of future outcomes conditional on a complete baseline and care context, never an unqualified fate label."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Prognosis
