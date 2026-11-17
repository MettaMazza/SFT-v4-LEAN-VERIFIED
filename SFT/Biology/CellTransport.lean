import SFT.Host.Text
namespace SFT.Biology.CellTransport
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-CELL-TRANSPORT-001","Cellular transport","cell_process","cell-boundary-species-carrier","directed-cross-boundary-transition","route-gradient-resource-and-fate-held","time-condition-bounded","Cellular transport is a counted species-state transition through a declared membrane route with direction, driving relation and intracellular fate retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.CellTransport
