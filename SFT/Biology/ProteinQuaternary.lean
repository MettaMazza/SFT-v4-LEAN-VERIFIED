import SFT.Host.Text
namespace SFT.Biology.ProteinQuaternary
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-PROTEIN-QUATERNARY-001","Quaternary protein assembly","protein_structure_function","multi-chain-labelled-carrier","interface-compatible-composition","chain-identity-symmetry-and-contact-held","structure-method-bounded","Quaternary assembly is a generated multi-chain joint state that retains chain identities, stoichiometry, symmetry, interface contacts and adverse steric alternatives; no fitted docking score may select it."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.ProteinQuaternary
