import SFT.Host.Text
namespace SFT.Medicine.IncidencePrevalence
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-INCIDENCE-PREVALENCE-001","Incidence and prevalence","risk_prognosis_outcome","population-condition-records","new-event-versus-state-support","flow-and-stock-kept-distinct","population-and-time-boundary","Incidence counts new condition transitions while prevalence counts supported states; the two observation relations may not be merged."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.IncidencePrevalence
