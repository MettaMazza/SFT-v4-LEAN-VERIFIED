import SFT.Physics.AtomicFieldSplitting
namespace SFT.Physics.AtomicFieldSplittingEntryWitnesses
open AtomicFieldSplitting LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def multiplicityCheck : Bool := [1,2,3,4,5,6].map (fun n => (magneticSublevelCount (.count (.integer (.ofNat n)))).toOption)==[some 2,some 3,some 4,some 5,some 6,some 7]
def zeemanCheck : Bool := match zeemanShiftMagnitude (.fraction (normalize 3 2 (by decide))) (.count (.integer 2)) (.fraction (normalize 2 5 (by decide))) with
 | .error _ => false
 | .ok doubled => match zeemanShiftMagnitude (.fraction (normalize 3 2 (by decide))) (.count (.integer 2)) (.fraction (normalize 1 5 (by decide))) with
  | .error _ => false
  | .ok base => doubled == multiply (wholeRatio 2) base
def linearCheck : Bool := match linearStarkMagnitude (.fraction (normalize 4 7 (by decide))) (.fraction (normalize 2 5 (by decide))) with
 | .error _ => false
 | .ok doubled => match linearStarkMagnitude (.fraction (normalize 4 7 (by decide))) (.fraction (normalize 1 5 (by decide))) with
  | .error _ => false
  | .ok base => doubled == multiply (wholeRatio 2) base
def quadraticCheck : Bool := match quadraticStarkMagnitude (.fraction (normalize 4 7 (by decide))) (.fraction (normalize 2 5 (by decide))) with
 | .error _ => false
 | .ok doubled => match quadraticStarkMagnitude (.fraction (normalize 4 7 (by decide))) (.fraction (normalize 1 5 (by decide))) with
  | .error _ => false
  | .ok base => doubled == multiply (wholeRatio 4) base
def witnesses : List Witness := [⟨"multiplicity","Positive doubled-angular counts generate conventional 2J+1 multiplicities.",multiplicityCheck⟩,⟨"linear-zeeman","Doubling the field doubles every exact Zeeman magnitude.",zeemanCheck⟩,⟨"linear-degenerate-Stark","Doubling the field doubles the degenerate response.",linearCheck⟩,⟨"quadratic-nondegenerate-Stark","Doubling the field quadruples the nondegenerate response.",quadraticCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.AtomicFieldSplittingEntryWitnesses
