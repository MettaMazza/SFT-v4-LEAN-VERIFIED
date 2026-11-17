import SFT.Host.Text
namespace SFT.Biology.Senescence
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-SENESCENCE-001","Senescence and longevity","organism_physiology","lineage-maintenance-history-carrier","age-linked-maintenance-loss-relation","survival-repair-reproduction-and-censoring-held","population-condition-bounded","Senescence is an age-linked change in maintenance or continuation measured on a declared lineage and population; longevity requires survival and censoring records and is not forced by denominator parity alone."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.Senescence
