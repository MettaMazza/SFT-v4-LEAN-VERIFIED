import SFT.Host.Text
namespace SFT.Biology.DifferentialReproduction
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-DIFFERENTIAL-REPRODUCTION-001","Differential reproduction","variation_evolution","typed-lineage-carrier","type-specific-successor-count","exposure-survival-and-fecundity-ledger","generation-window-declared","Differential reproduction is an exact comparison of retained successor counts among biological types under one declared environment and generation window."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.DifferentialReproduction
