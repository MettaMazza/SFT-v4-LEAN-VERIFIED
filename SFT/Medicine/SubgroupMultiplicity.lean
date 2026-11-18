import SFT.Host.Text
namespace SFT.Medicine.SubgroupMultiplicity
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-SUBGROUP-MULTIPLICITY-001","Subgroups and multiplicity","individual_population_inference","generated-subgroup-comparisons","comparison-count-and-result-incidence","complete-tested-family","predeclaration-and-selection-boundary","Every generated subgroup and outcome comparison remains in one complete family so selection after outcomes cannot masquerade as prior inference."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.SubgroupMultiplicity
