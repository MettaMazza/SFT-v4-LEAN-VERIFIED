import SFT.Computation.Inference
namespace SFT.Computation.InterpretabilityWitnesses
structure Witness where
  name : String
  statement : String
  passed : Bool

def checks : Bool × Bool × Bool := match Inference.consistentHypotheses [("a","held")] [("h1",[("a","held"),("b","returned")]),("h2",[("a","returned")])] with
  | .error _ => (false,false,false)
  | .ok names => (decide (names = ["h1"]),decide (names.length = 1),SFT.Host.Text.isPrefix "SFT-COMP".toUTF8.data.toList "SFT-COMP-LEARN-INTERPRETABILITY-VERIFICATION".toUTF8.data.toList)

def witnesses : List Witness := [
 ⟨"learning_intelligence-witness-1","learning_intelligence exact operational witness 1 for SFT-COMP-LEARN-INTERPRETABILITY-VERIFICATION-001",checks.1⟩,
 ⟨"learning_intelligence-witness-2","learning_intelligence exact operational witness 2 for SFT-COMP-LEARN-INTERPRETABILITY-VERIFICATION-001",checks.2.1⟩,
 ⟨"learning_intelligence-witness-3","learning_intelligence exact operational witness 3 for SFT-COMP-LEARN-INTERPRETABILITY-VERIFICATION-001",checks.2.2⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := by decide
end SFT.Computation.InterpretabilityWitnesses
