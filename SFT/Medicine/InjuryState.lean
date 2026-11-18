import SFT.Host.Text
namespace SFT.Medicine.InjuryState
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-INJURY-001","Injury state","variation_dysfunction_disease_injury","patient-tissue-or-function-state","damage-following-declared-exposure","exposure-damage-consequence-trace","site-time-severity-method","An injury binds a declared exposure to damage and consequence at a retained site, time, severity and observation method."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.InjuryState
