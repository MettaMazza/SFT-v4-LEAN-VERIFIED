import SFT.Host.Text
namespace SFT.Biology.SpeciesBoundary
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-SPECIES-BOUNDARY-001","Species and reproductive boundary","population_ecology","population-lineage-carrier","within-between-continuation-comparison","gene-flow-history-and-method-held","species-concept-declared","A species claim is an explicitly chosen, evidence-bound equivalence class over populations; reproductive, phylogenetic and ecological criteria may not be silently merged."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.SpeciesBoundary
