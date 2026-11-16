import SFT.Physics.StrongCPCertificate
namespace SFT.Physics.StrongCPObservationWitnesses
open StrongCPCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _=>false | .ok c=>SFT.Host.Text.equal c.alignment.strongPhase.1 "aligned-One"
def witness1 : Bool := match theoremCertificate with | .error _=>false | .ok c=>match c.alignment.electricDipoleCarrier with | []=>false | h::_=>SFT.Host.Text.equal h "empty-One"
def witness2 : Bool := match theoremCertificate with | .error _=>false | .ok c=>c.actions.allActionsFibrePreserving && c.actions.generatedCrossFibreActions.isEmpty
def witness3 : Bool := match theoremCertificate with | .error _=>false | .ok c=>c.baryonOneInvariant
def witnesses : List Witness := [⟨"formal-alignment","The formal carrier is aligned One before measurement.",witness0⟩,⟨"formal-empty-dipole","The formal strong electric-dipole carrier is empty-One before measurement.",witness1⟩,⟨"formal-sector-exclusion","All formal mediator actions preserve fibre and no cross-fibre action exists.",witness2⟩,⟨"formal-baryon-One","The proton baryon-One invariant is closed before measurement.",witness3⟩]
theorem witness0Passed : witness0=true := rfl
#print axioms witness0Passed
theorem witness1Passed : witness1=true := rfl
#print axioms witness1Passed
theorem witness2Passed : witness2=true := rfl
#print axioms witness2Passed
theorem witness3Passed : witness3=true := rfl
#print axioms witness3Passed
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 unfold witnesses
 change (witness0 && (witness1 && (witness2 && (witness3 && true)))) = true
 rw [witness0Passed,witness1Passed,witness2Passed,witness3Passed]
 rfl
#print axioms allWitnessesPass
end SFT.Physics.StrongCPObservationWitnesses
