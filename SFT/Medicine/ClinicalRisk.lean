import SFT.Host.Text
namespace SFT.Medicine.ClinicalRisk
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-RISK-001","Clinical risk","risk_prognosis_outcome","eligible-person-support","outcome-incidence-over-follow-up","at-risk-set-with-competing-events","population-start-time-and-horizon","Risk is an exact outcome share among an explicitly eligible at-risk set over a declared positive finite horizon, with competing events and loss retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalRisk
