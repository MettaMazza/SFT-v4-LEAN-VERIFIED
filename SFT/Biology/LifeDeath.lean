import SFT.Host.Text
namespace SFT.Biology.LifeDeath
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-LIFE-DEATH-001","Loss of living closure","life_boundary","formerly-living-process-carrier","irrecoverable-closure-loss","material-remains-process-identity-not-retained","recovery-boundary-declared","Biological death is the condition-bounded loss of the jointly required maintenance, regulation and integrated continuation relations, not numerical zero or disappearance of material."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.LifeDeath
