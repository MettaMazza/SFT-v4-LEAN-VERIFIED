import SFT.Physics.HiggsCertificate
namespace SFT.Physics.HiggsObservationWitnesses
open HiggsCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(@decide (c.terminalMassRatio.num=2563352914777) (Int.decEq _ _)) && c.terminalMassRatio.den==5038463954690
def witness1 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(@decide (c.terminalSelfCoupling.num=6570778165695741824959729) (Int.decEq _ _))
def witness2 : Bool := match theoremCertificate with | .error _=>false | .ok c=>c.routeCrossLock.routesEqual
def witnesses : List Witness := [⟨"formal-ratio","The exact terminal mass ratio is sealed before measurement.",witness0⟩,⟨"formal-coupling","The native self-coupling is sealed before measurement.",witness1⟩,⟨"formal-cross-lock","The squared mass route equals twice the coupling route before measurement.",witness2⟩]
theorem witness0Passed : witness0=true := rfl
#print axioms witness0Passed
theorem witness1Passed : witness1=true := rfl
#print axioms witness1Passed
theorem witness2Passed : witness2=true := rfl
#print axioms witness2Passed
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 unfold witnesses
 change (witness0 && (witness1 && (witness2 && true))) = true
 rw [witness0Passed,witness1Passed,witness2Passed]
 rfl
#print axioms allWitnessesPass
end SFT.Physics.HiggsObservationWitnesses
