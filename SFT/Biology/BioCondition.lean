import SFT.Host.Text
namespace SFT.Biology.BioCondition
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-BIO-CONDITION-001","Biological condition and control","observation_handoffs","experimental-unit-condition-carrier","condition-to-outcome-comparison","controls-exposure-time-and-context-held","design-boundary-declared","A biological comparison requires experimental units, conditions, controls, timing and context to be registered before the outcome is opened."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.BioCondition
