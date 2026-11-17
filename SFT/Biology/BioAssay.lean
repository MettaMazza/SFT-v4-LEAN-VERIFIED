import SFT.Host.Text
namespace SFT.Biology.BioAssay
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-BIO-ASSAY-001","Biological assay","observation_handoffs","specimen-method-result-carrier","method-to-observation-relation","calibration-detection-and-processing-held","method-validity-bounded","A biological assay is a specimen-bound observation process with calibration, detection, processing, exclusions and method-validity boundaries retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.BioAssay
