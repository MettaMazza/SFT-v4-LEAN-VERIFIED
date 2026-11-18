import SFT.Biology.CodonCounts
import SFT.Host.Text
namespace SFT.Biology.CodonBox
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-CODON-BOX-001","First-two-position codon boxes","gene_genome_regulation","complete-codon-support","prefix-equivalence-partition","third-position-variation-retained","complete-partition-census","The sixty-four codons partition by their first two positions into exactly sixteen boxes of exactly four third-position words each."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
def countWitness : Bool :=
 let c := CodonCounts.exactCodonCertificate
 c.boxCount == 16 && c.boxWidths == [4] && c.partitionComplete && c.eachWordOnce
theorem countWitnessPassed : countWitness = true := by
 unfold countWitness
 rw [CodonCounts.completeCertificate]
 rfl
end SFT.Biology.CodonBox
