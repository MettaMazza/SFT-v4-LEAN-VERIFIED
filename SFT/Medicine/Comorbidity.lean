import SFT.Host.Text
namespace SFT.Medicine.Comorbidity
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-COMORBIDITY-001","Comorbidity composition","variation_dysfunction_disease_injury","joint-patient-condition-state","co-occurrence-with-interaction-held","noncollapsed-joint-condition-word","shared-patient-and-interval","Comorbidity is a joint condition word on one patient and interval; component conditions and their interactions may not be collapsed into one label."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Comorbidity
