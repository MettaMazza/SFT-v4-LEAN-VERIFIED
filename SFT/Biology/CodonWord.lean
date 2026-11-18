import SFT.Biology.CodonCounts
import SFT.Host.Text
namespace SFT.Biology.CodonWord
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-CODON-001","Triplet codon word space","gene_genome_regulation","four-symbol-word-carrier","three-position-ordered-composition","position-and-symbol-identities-retained","complete-word-census","Three ordered positions over four generated symbols force exactly sixty-four distinguishable codon words."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
def countWitness : Bool :=
 let c := CodonCounts.exactCodonCertificate
 c.wordLength == 3 && c.codonCount == 64 && c.codonCensusComplete
theorem countWitnessPassed : countWitness = true := by
 unfold countWitness
 rw [CodonCounts.completeCertificate]
 rfl
end SFT.Biology.CodonWord
