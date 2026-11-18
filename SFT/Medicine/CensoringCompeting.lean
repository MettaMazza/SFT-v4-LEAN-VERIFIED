import SFT.Host.Text
namespace SFT.Medicine.CensoringCompeting
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CENSORING-COMPETING-001","Censoring and competing events","risk_prognosis_outcome","incomplete-patient-course","observability-and-competing-transition","retained-unobserved-support","reason-time-and-follow-up","Censoring and competing events are explicit course outcomes; neither may be silently treated as absence of the target event."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.CensoringCompeting
