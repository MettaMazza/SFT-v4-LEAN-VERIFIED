import SFT.Host.Text
import SFT.Medicine.StructuralCounts
namespace SFT.Medicine.AbsoluteRelativeEffect
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-ABSOLUTE-RELATIVE-EFFECT-001","Absolute and relative effects","efficacy_effectiveness_safety_benefit_harm","arm-specific-outcome-counts","absolute-and-relative-comparison","complete-two-arm-event-table","population-and-horizon","Absolute and relative effects are distinct exact readings of the same complete arm-by-outcome table; neither may replace the underlying counts."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
def armOutcomeWitness : Bool := StructuralCounts.twoArmOutcomeCertificate.complete && StructuralCounts.twoArmOutcomeCertificate.cellCount == 4
theorem armOutcomeWitnessPassed : armOutcomeWitness = true := rfl
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.AbsoluteRelativeEffect
