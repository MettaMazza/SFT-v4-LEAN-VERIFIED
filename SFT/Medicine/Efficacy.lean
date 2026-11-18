import SFT.Host.Text
import SFT.Medicine.StructuralCounts
namespace SFT.Medicine.Efficacy
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-EFFICACY-001","Efficacy","efficacy_effectiveness_safety_benefit_harm","controlled-intervention-comparison","outcome-contrast-under-explanatory-conditions","assigned-arms-and-complete-outcomes","protocol-population-and-horizon","Efficacy is a complete intervention-comparator outcome contrast under declared explanatory trial conditions."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
def armOutcomeWitness : Bool := StructuralCounts.twoArmOutcomeCertificate.complete && StructuralCounts.twoArmOutcomeCertificate.cellCount == 4
theorem armOutcomeWitnessPassed : armOutcomeWitness = true := rfl
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Efficacy
