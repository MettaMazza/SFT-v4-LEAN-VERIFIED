import SFT.Host.Text
namespace SFT.Biology.HeritableVariation
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-HERITABLE-VARIATION-001","Heritable copy variation","inheritance_replication","variant-product-and-lineage-carrier","copy-difference-retained-across-generation","location-state-and-origin-held","observation-window-declared","A copy difference is heritable variation only when its exact state and location persist through a registered successor relation rather than appearing only as transient damage or observation error."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.HeritableVariation
