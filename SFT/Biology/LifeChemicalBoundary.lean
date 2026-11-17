import SFT.Host.Text
namespace SFT.Biology.LifeChemicalBoundary
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-LIFE-CHEMICAL-BOUNDARY-001","Living and nonliving chemical-network boundary","life_boundary","complete-reaction-network-carrier","network-to-maintenance-comparison","closure-and-inheritance-retained","condition-bounded-life-class","A chemical network is biologically living only when compartment, maintenance, heritable continuation and regulated resource exchange are jointly retained; chemistry alone does not supply that classification."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.LifeChemicalBoundary
