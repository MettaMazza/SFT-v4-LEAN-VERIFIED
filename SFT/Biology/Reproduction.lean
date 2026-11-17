import SFT.Host.Text
namespace SFT.Biology.Reproduction
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-REPRODUCTION-001","Organismal reproduction","organism_physiology","parent-offspring-lineage-carrier","generation-of-new-organism","carrier-contributions-development-and-errors-held","life-cycle-bounded","Organismal reproduction generates a new lineage-bound organism through declared parental carrier contributions and development, with variation and failures retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.Reproduction
