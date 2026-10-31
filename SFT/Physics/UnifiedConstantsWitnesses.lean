import SFT.Physics.UnifiedConstants
namespace SFT.Physics.UnifiedConstantsWitnesses
open UnifiedConstantsCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 16000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def passed : Except String Bool → Bool
 | .error _ => false
 | .ok value => value
def check0 : Bool := passed ((theoremCertificate.map fiveChecks).map (fun v => v.1))
def check1 : Bool := passed ((theoremCertificate.map fiveChecks).map (fun v => v.2.1))
def check2 : Bool := passed ((theoremCertificate.map fiveChecks).map (fun v => v.2.2.1))
def check3 : Bool := passed ((theoremCertificate.map fiveChecks).map (fun v => v.2.2.2.1))
def check4 : Bool := passed ((theoremCertificate.map fiveChecks).map (fun v => v.2.2.2.2))
def witnesses : List Witness := [⟨"rooted-object","Every registered sector node is reachable from the foundational One.",check0⟩,⟨"shared-incidence","Every sector has at least one explicit incoming shared-carrier edge.",check1⟩,⟨"leading-terminal-cross-lock","All common-order carriers equal their independently admitted V3 implementations.",check2⟩,⟨"dependency-probe","Every generator-dependent common-order carrier moves under three-to-four.",check3⟩,⟨"independence-control","Binary-only half-One and independently held ranks remain fixed.",check4⟩]
theorem check0Passed : check0=true := by
 unfold check0
 rw [allOriginalChecks]
 rfl
theorem check1Passed : check1=true := by
 unfold check1
 rw [allOriginalChecks]
 rfl
theorem check2Passed : check2=true := by
 unfold check2
 rw [allOriginalChecks]
 rfl
theorem check3Passed : check3=true := by
 unfold check3
 rw [allOriginalChecks]
 rfl
theorem check4Passed : check4=true := by
 unfold check4
 rw [allOriginalChecks]
 rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 unfold witnesses
 rw [check0Passed,check1Passed,check2Passed,check3Passed,check4Passed]
 rfl
end SFT.Physics.UnifiedConstantsWitnesses
