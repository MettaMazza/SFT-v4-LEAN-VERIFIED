import SFT.Host.Text
namespace SFT.Medicine.Prevention
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-PREVENTION-001","Prevention","screening_prevention_treatment_rehabilitation","at-risk-person-or-population","action-before-target-outcome","primary-secondary-tertiary-boundary","risk-frame-time-and-outcomes","Prevention is an action preceding a declared outcome in an at-risk carrier, with prevention level, comparator and all later outcomes retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Prevention
