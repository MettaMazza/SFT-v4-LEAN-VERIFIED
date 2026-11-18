import SFT.Host.Text
namespace SFT.Medicine.EffectModification
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-EFFECT-MODIFICATION-001","Clinical effect modification","cause_association_mechanism_confounding","stratified-patient-carriers","contrast-varies-by-held-stratum","joint-treatment-stratum-outcome","predeclared-strata-and-scale","Effect modification is a retained variation of a treatment or exposure contrast across predeclared strata on a declared comparison scale."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.EffectModification
