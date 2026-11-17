import SFT.Host.Text
namespace SFT.Biology.EcologicalNetwork
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-ECOLOGICAL-NETWORK-001","Ecological network topology","population_ecology","complete-population-interaction-graph","degree-path-and-clustering-census","nodes-edges-effort-and-missing-links-held","sampling-scale-declared","Ecological network topology is the exact degree, path and clustering census of a declared interaction graph; scale-free or small-world labels require whole-graph and unfavorable-model comparison."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.EcologicalNetwork
