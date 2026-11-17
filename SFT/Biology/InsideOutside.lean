import SFT.Host.Text
namespace SFT.Biology.InsideOutside
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-INSIDE-OUTSIDE-001","Inside/outside orientation","compartment_identity","oriented-boundary-carrier","opposed-side-label-relation","two-sides-never-merged","observer-orientation-declared","A retained compartment boundary forces two held side labels, inside and outside, whose distinction cannot be erased by a lawful transfer description."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.InsideOutside
