import SFT.Host.Text
namespace SFT.Biology.ExcitableThreshold
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-EXCITABLE-THRESHOLD-001","Excitable-cell threshold transition","cell_process","resting-excitable-state-carrier","threshold-crossing-to-regenerative-transition","subthreshold-and-refractory-controls-held","cell-condition-bounded","An excitable-cell event is a regenerative state transition after a declared threshold is crossed, distinguished from subthreshold and refractory responses; no universal voltage is imported."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.ExcitableThreshold
