import SFT.Host.Text
namespace SFT.Biology.Organism
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-ORGANISM-001","Organism identity","organism_physiology","integrated-living-lineage-carrier","part-to-whole-functional-integration","boundaries-life-cycle-and-environment-held","taxon-stage-condition-bounded","An organism is an integrated lineage-bound living whole whose parts participate in coordinated maintenance, development, reproduction or continuation within a declared life cycle."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.Organism
