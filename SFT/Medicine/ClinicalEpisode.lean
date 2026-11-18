import SFT.Host.Text
namespace SFT.Medicine.ClinicalEpisode
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-EPISODE-001","Clinical episode","patient_population_health","patient-episode","ordered-observation-and-action-trace","bounded-episode-with-start-and-stop","declared-setting-and-follow-up","A clinical episode is a finite ordered patient trace with explicit entry, observations, actions, exit and retained follow-up boundary."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalEpisode
