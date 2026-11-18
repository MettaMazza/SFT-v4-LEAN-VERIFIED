import SFT.Host.Text
namespace SFT.Medicine.Mediation
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-MEDIATION-001","Clinical mediation","cause_association_mechanism_confounding","exposure-mediator-outcome-word","ordered-indirect-and-direct-paths","path-specific-support","intervention-and-measurement-times","Mediation separates direct and mediator-carried paths only when their temporal and intervention meanings are explicitly generated and observed."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Mediation
