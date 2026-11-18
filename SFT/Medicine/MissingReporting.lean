import SFT.Host.Text
namespace SFT.Medicine.MissingReporting
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-MISSING-REPORTING-001","Missing and selective reporting","trial_observational_synthesis","registered-and-observed-study-results","registration-publication-correspondence","reported-unreported-support","registry-search-and-cutoff-date","A registered outcome or study absent from the visible report remains an explicit missing distinction and cannot be interpreted as a favorable absence."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.MissingReporting
