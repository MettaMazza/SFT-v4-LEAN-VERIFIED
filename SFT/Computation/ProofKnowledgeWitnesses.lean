import SFT.Computation.SecurityPartition
namespace SFT.Computation.ProofKnowledgeWitnesses
structure Witness where
  name : String
  statement : String
  passed : Bool

def checks : Bool × Bool × Bool := match SecurityPartition.partition ["m1","m2"] [("m1","same-view"),("m2","same-view")] with
  | .error _ => (false,false,false)
  | .ok rows => (decide (rows.length = 1),decide (rows.head?.map Prod.snd = some ["m1","m2"]),SFT.Host.Text.isPrefix "SFT-COMP".toUTF8.data.toList "SFT-COMP-SEC-PROOF-KNOWLEDGE".toUTF8.data.toList)
def witnesses : List Witness := [
 ⟨"cryptography_security-witness-1","cryptography_security exact operational witness 1 for SFT-COMP-SEC-PROOF-KNOWLEDGE-001",checks.1⟩,
 ⟨"cryptography_security-witness-2","cryptography_security exact operational witness 2 for SFT-COMP-SEC-PROOF-KNOWLEDGE-001",checks.2.1⟩,
 ⟨"cryptography_security-witness-3","cryptography_security exact operational witness 3 for SFT-COMP-SEC-PROOF-KNOWLEDGE-001",checks.2.2⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := by decide
end SFT.Computation.ProofKnowledgeWitnesses
