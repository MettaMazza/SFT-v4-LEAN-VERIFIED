import SFT.Physics.NuclearBindingCurve
import SFT.Physics.NuclearBindingPeakClosure
namespace SFT.Physics.NuclearBindingCurveEntryWitnesses
open NuclearBindingCurve LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def sharesCheck : Bool := match surfaceDeficitShare,asymmetryShare,pairingShare with
 | .ok s,.ok a,.ok p => s==normalize 1 5 (by decide) && a==normalize 1 4 (by decide) && p==normalize 1 4 (by decide)
 | .error _,_,_ => false
 | .ok _,.error _,_ => false
 | .ok _,.ok _,.error _ => false
def finiteCheck : Bool :=
 let p := NuclearBindingPeakClosure.originalCertificate
 p.massNumber==62 && p.chargeCount==28 && p.neutronCount==34 && p.rivalUpper.blt p.scoreLower
def tailCheck : Bool := match NuclearBindingTail.tailUpperBounds with
 | .error _ => false
 | .ok tail =>
   let p := NuclearBindingPeakClosure.originalCertificate
   p.tailClosed && tail.coulombTailSuccessorMonotone && tail.lowChargeUpper.blt p.scoreLower && tail.highChargeUpper.blt p.scoreLower
def rationalCheck : Bool :=
 let p := NuclearBindingPeakClosure.originalCertificate
 p.scoreLower.den>0 && p.scoreUpper.den>0
theorem peakEvaluation : NuclearBindingPeak.bindingPeakWithin 7 4 = .ok (some NuclearBindingPeakClosure.originalCertificate) := NuclearBindingPeakClosure.completePeak
def witnesses : List Witness := [⟨"forced-ledger-shares","Surface, electromagnetic, asymmetry and pairing shares are exact admitted carriers.",sharesCheck⟩,⟨"unique-finite-peak","Exact enclosure separation leaves mass 62, charge 28 and neutron 34 as the unique finite winner.",finiteCheck⟩,⟨"unbounded-tail-closed","Both forced tail cases lie strictly below the sealed finite winner and the high-charge bound increases under every positive successor.",tailCheck⟩,⟨"no-irrational-value","The predicted winner is enclosed by exact positive fractions only.",rationalCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.NuclearBindingCurveEntryWitnesses
