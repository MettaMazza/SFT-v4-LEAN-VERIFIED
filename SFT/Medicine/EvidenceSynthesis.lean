import SFT.Host.Text
namespace SFT.Medicine.EvidenceSynthesis
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-EVIDENCE-SYNTHESIS-001","Clinical evidence synthesis","trial_observational_synthesis","study-level-evidence-carriers","question-matched-composition","heterogeneity-bias-and-dependence-held","protocol-search-selection-and-date","Evidence synthesis composes purpose-matched study carriers while retaining design differences, dependence, heterogeneity, bias, adverse and absent results."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.EvidenceSynthesis
