import SFT.Host.Text
namespace SFT.Medicine.SeverityStage
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-SEVERITY-STAGE-001","Severity and stage","variation_dysfunction_disease_injury","disease-or-injury-course","ordered-extent-relation","criteria-specific-partial-order","method-time-and-organ-system","Severity and stage are declared finite order relations over retained criteria and may not be silently treated as interchangeable or universal scales."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.SeverityStage
