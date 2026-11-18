import SFT.Biology.CodonCounts
import SFT.Host.Text
namespace SFT.Biology.NucleotideAlphabet
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-NUCLEOTIDE-ALPHABET-001","Nucleic-acid symbol alphabet","gene_genome_regulation","two-distinction-symbol-carrier","ordered-pair-label-generation","four-code-symbols-retained","DNA-alphabet-boundary","Two independent held distinctions generate exactly four nucleic-acid symbol labels at the DNA coding boundary."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
def countWitness : Bool :=
 let c := CodonCounts.exactCodonCertificate
 c.alphabetCount == 4 && c.alphabetComplete
theorem countWitnessPassed : countWitness = true := by
 unfold countWitness
 rw [CodonCounts.completeCertificate]
 rfl
end SFT.Biology.NucleotideAlphabet
