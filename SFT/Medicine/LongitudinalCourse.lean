import SFT.Host.Text
namespace SFT.Medicine.LongitudinalCourse
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-LONGITUDINAL-COURSE-001","Longitudinal clinical course","patient_population_health","ordered-patient-states","within-person-transition-relation","course-with-missing-visits-held","declared-follow-up-and-censoring","A longitudinal course is an ordered within-person state relation that preserves every observed interval, missing visit, intervention and censoring event."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.LongitudinalCourse
