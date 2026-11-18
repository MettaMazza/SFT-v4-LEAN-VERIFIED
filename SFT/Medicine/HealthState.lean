import SFT.Host.Text
namespace SFT.Medicine.HealthState
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-HEALTH-STATE-001","Health state","patient_population_health","person-or-population-state","function-and-capacity-relation","multidomain-state-with-context","declared-measures-and-time","A health state is a context- and time-bound organization of retained functional, experiential and survival distinctions rather than an unqualified single label."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.HealthState
