import SFT.Host.Text
namespace SFT.Medicine.ClinicalOutcome
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-OUTCOME-001","Clinical outcome","risk_prognosis_outcome","patient-endpoint-state","change-or-event-from-baseline","endpoint-definition-and-components","assessment-time-method-and-blinding","A clinical outcome retains endpoint definition, baseline, assessment time, method, assessor and every component or adverse alternative."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalOutcome
