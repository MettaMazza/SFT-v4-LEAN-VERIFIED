import SFT.Computation.CausalOperations
namespace SFT.Computation.CommunicationWitnesses
open SFT.Mathematics.DiscreteObjects CausalOperations
structure Witness where
  name : String
  statement : String
  passed : Bool

def checks : Bool × Bool × Bool := match causalClosure ["a","b","c"] [("a","b"),("b","c")] with
 | .error _ => (false,false,false)
 | .ok rows => (has rows ("a","c"),!has rows ("c","a"),decide (rows.length = 3))
def witnesses : List Witness := [
 ⟨"distributed_computation-witness-1","distributed_computation exact operational witness 1 for SFT-COMP-DIST-COMMUNICATION-001",checks.1⟩,
 ⟨"distributed_computation-witness-2","distributed_computation exact operational witness 2 for SFT-COMP-DIST-COMMUNICATION-001",checks.2.1⟩,
 ⟨"distributed_computation-witness-3","distributed_computation exact operational witness 3 for SFT-COMP-DIST-COMMUNICATION-001",checks.2.2⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
  have result : checks = (true,true,true) := by unfold checks; rw [sourceWitnessClosure]; rfl
  change (checks.1 && (checks.2.1 && (checks.2.2 && true))) = true
  rw [result]; rfl
end SFT.Computation.CommunicationWitnesses
