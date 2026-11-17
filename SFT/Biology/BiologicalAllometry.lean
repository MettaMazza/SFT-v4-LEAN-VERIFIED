import SFT.Host.Text
namespace SFT.Biology.BiologicalAllometry
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-BIOLOGICAL-ALLOMETRY-001","Biological allometric relation","population_ecology","organism-trait-size-carrier","trait-to-size-scaling-comparison","taxon-stage-condition-and-residuals-held","range-and-sample-bounded","A biological allometric claim is a population-bounded comparison of trait and body-size recurrence with taxa, stages, conditions, residuals and alternative exponents retained; no universal exponent is imported."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.BiologicalAllometry
