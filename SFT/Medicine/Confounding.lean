import SFT.Host.Text
namespace SFT.Medicine.Confounding
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CONFOUNDING-001","Clinical confounding","cause_association_mechanism_confounding","exposure-outcome-common-cause-word","common-cause-distortion-relation","measured-and-unmeasured-support","design-and-adjustment-boundary","Confounding is retained whenever a pre-exposure cause bears on both exposure and outcome; adjustment must state exactly which distinctions it conditions on."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Confounding
