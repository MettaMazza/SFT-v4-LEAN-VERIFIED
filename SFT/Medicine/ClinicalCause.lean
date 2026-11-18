import SFT.Host.Text
namespace SFT.Medicine.ClinicalCause
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-CAUSE-001","Clinical causal claim","cause_association_mechanism_confounding","exposure-intervention-and-outcome-traces","difference-under-lawful-comparison","counterfactual-or-interventional-contrast","exchangeability-time-and-follow-up","A clinical causal claim requires a lawful contrast with timing, exchangeability boundary, intervention or counterfactual meaning and complete outcome follow-up."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalCause
