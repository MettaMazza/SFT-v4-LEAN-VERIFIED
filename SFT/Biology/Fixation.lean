import SFT.Host.Text
namespace SFT.Biology.Fixation
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-FIXATION-001","Fixation and loss boundary","variation_evolution","complete-population-support","variant-count-to-population-count","all-sampled-lineages-retained","finite-population-generation-bounded","Fixation is whole support of one retained variant in the declared population; loss is structural absence of that variant from the same support, never a universal guarantee from benefit alone."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.Fixation
