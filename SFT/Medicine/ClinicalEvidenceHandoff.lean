import SFT.Host.Text
namespace SFT.Medicine.ClinicalEvidenceHandoff
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-EVIDENCE-HANDOFF-001","Clinical evidence handoff","consent_ethics_privacy_uncertainty","consented-deidentified-evidence-record","claim-to-reviewer-reconstruction","derivation-data-code-adverse-results","purpose-access-version-and-custody","A medical claim may cross to a reviewer only with reconstructible derivation, data provenance, code, adverse/null/unresolved rows, privacy boundary and custody record."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalEvidenceHandoff
