import SFT.Host.Text
namespace SFT.Medicine.DiseaseState
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-DISEASE-001","Disease state","variation_dysfunction_disease_injury","patient-process-state","persistent-or-recurrent-harmful-process","mechanism-manifestation-course","diagnostic-criteria-and-time","A disease state is a criteria-bound harmful process whose mechanism, manifestations and course remain distinct; a label alone is not the state."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.DiseaseState
