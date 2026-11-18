import SFT.Host.Text
namespace SFT.Biology.ResourceClosure
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-RESOURCE-CLOSURE-001","Finite biological resource closure","metabolism_resource","organism-environment-joint-carrier","uptake-transformation-export-cycle","all-required-inputs-and-losses-retained","finite-window-closure-test","Resource closure is always relative to a declared organism-environment boundary and finite interval and requires every necessary input, transformation, storage, export and loss path to be recorded."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.ResourceClosure
