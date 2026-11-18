import SFT.Host.Text
namespace SFT.Medicine.SafetyEvidence
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-SAFETY-001","Safety evidence","efficacy_effectiveness_safety_benefit_harm","all-exposed-and-comparator-participants","favorable-and-unfavorable-event-incidence","complete-event-severity-time-support","exposure-duration-and-follow-up","Safety is a complete comparative adverse-outcome record at a declared exposure and follow-up boundary, never proof that harm is absent."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.SafetyEvidence
