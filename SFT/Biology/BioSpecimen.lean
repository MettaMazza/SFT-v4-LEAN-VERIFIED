import SFT.Host.Text
namespace SFT.Biology.BioSpecimen
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-BIO-SPECIMEN-001","Biological specimen and sampling","observation_handoffs","source-bound-biological-part","specimen-to-source-provenance","collection-preservation-and-subselection-held","representativeness-declared","A biological specimen is a finite source-bound part with collection, preservation, preparation, subsampling and representativeness boundaries explicit."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.BioSpecimen
