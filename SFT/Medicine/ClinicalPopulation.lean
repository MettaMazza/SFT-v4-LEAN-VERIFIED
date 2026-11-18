import SFT.Host.Text
namespace SFT.Medicine.ClinicalPopulation
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-POPULATION-001","Clinical population","patient_population_health","finite-person-carriers","membership-under-declared-criteria","population-with-each-person-held","place-time-source-frame","A clinical population is a finite set of retained person carriers selected by declared criteria, never an average that erases membership or source frame."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalPopulation
