import SFT.Host.Text
namespace SFT.Medicine.TreatmentHeterogeneity
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-TREATMENT-HETEROGENEITY-001","Treatment-effect heterogeneity","efficacy_effectiveness_safety_benefit_harm","predeclared-patient-strata","arm-contrast-by-stratum","joint-stratum-arm-outcome","multiplicity-and-scale-boundary","Treatment heterogeneity requires the complete joint stratum, arm and outcome support with predeclared comparisons and multiplicity retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.TreatmentHeterogeneity
