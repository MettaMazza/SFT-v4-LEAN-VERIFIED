import SFT.Host.Text
namespace SFT.Medicine.Blinding
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-BLINDING-001","Clinical blinding","trial_observational_synthesis","participant-carer-assessor-role-word","role-to-allocation-access-restriction","access-and-unblinding-trace","stage-role-and-information-boundary","Blinding is an exact information-access restriction by role and stage with every planned or accidental unblinding event retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Blinding
