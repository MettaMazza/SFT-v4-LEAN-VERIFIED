import SFT.Host.Text
namespace SFT.Biology.Population
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-POPULATION-001","Biological population","population_ecology","individual-set-space-time-carrier","membership-and-interaction-relation","identities-lineages-and-sampling-held","taxon-place-time-bounded","A population is a declared set of organismal individuals connected by place, time and relevant biological interaction, with membership and sampling rules explicit."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.Population
