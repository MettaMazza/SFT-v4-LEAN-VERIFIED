import SFT.Host.Text
namespace SFT.Medicine.ClinicalAssociation
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-ASSOCIATION-001","Clinical association","cause_association_mechanism_confounding","paired-exposure-outcome-records","joint-incidence-relation","strata-and-missingness-held","population-time-and-selection","A clinical association is an exact joint-incidence relation at a declared population and interval and does not by itself assert cause."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalAssociation
