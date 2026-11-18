import SFT.Host.Text
namespace SFT.Medicine.DataMinimization
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-DATA-MINIMIZATION-001","Clinical data minimization","consent_ethics_privacy_uncertainty","purpose-declared-data-fields","field-necessity-to-purpose","included-excluded-and-derived-fields","protocol-access-and-retention-period","A clinical dataset may retain only fields forced by its declared purpose while preserving an auditable record of exclusion, derivation, access and retention."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.DataMinimization
