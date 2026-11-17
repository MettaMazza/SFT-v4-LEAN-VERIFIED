import SFT.Host.Text
namespace SFT.Biology.BioUncertainty
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-BIO-UNCERTAINTY-001","Biological uncertainty and missingness","observation_handoffs","complete-observation-record","result-to-uncertainty-partition","variation-error-missing-and-censored-held","inference-boundary-declared","Biological evidence must retain biological variation, measurement error, missingness, censoring and unresolved states rather than collapsing them into one favorable estimate."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.BioUncertainty
