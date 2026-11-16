import SFT.Physics.SmithionWitnesses
namespace SFT.Physics.SmithionObservationWitnesses
open SmithionSpectrum SmithionFlavour LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _=>false | .ok c=>c.quarkCrossLock
def witness1 : Bool := match theoremCertificate with | .error _=>false | .ok c=>c.fourSpectra && c.twelveRoots && c.allRootsDisjointPositive
def witness2 : Bool := match abundanceCertificate with | .error _=>false | .ok c=>c.darkToBaryon==normalize 27 5 (by decide)
def witness3 : Bool := SmithionWitnesses.witness4
def witnesses : List Witness := [⟨"formal-cross-lock","Both quark carrier cross-locks survive before measurement.",witness0⟩,⟨"formal-spectra","All four spectra and twelve exact roots survive before measurement.",witness1⟩,⟨"formal-abundance","The sealed abundance ratio is 27/5.",witness2⟩,⟨"formal-lfv","The sealed LFV ratio is 3:5:20 with tau ratio four.",witness3⟩]
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
end SFT.Physics.SmithionObservationWitnesses
