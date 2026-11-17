import SFT.Host.Text
namespace SFT.Biology.DysregulatedDivision
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-DYSREGULATED-DIVISION-001","Dysregulated cell continuation and cancer boundary","cell_process","lineage-control-state-carrier","division-death-differentiation-control-comparison","mutations-context-and-clonal-history-held","tissue-and-time-bounded","Dysregulated cellular continuation is a lineage-supported failure of normal division, death or differentiation control under a declared tissue context; cycling alone is not sufficient to identify cancer."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.DysregulatedDivision
