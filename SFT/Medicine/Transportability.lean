import SFT.Host.Text
namespace SFT.Medicine.Transportability
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-TRANSPORTABILITY-001","Clinical transportability","individual_population_inference","source-and-target-populations","invariant-and-different-features","joint-population-treatment-outcome","setting-time-and-care-system","Transportability requires explicit source-target comparison and may carry only relations invariant under every retained population and setting difference."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Transportability
