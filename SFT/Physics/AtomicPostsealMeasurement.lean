import SFT.Physics.AtomicPostsealRecords
import SFT.Physics.CubicAtomicSupport
import SFT.Physics.HydrogenSpectrum
namespace SFT.Physics.AtomicPostsealMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals AtomicPostsealRecords
def cubicObservedCoordination (record : Value) : Except String Nat := do
 let row ← reportedRow record "NIST-NCNR-DCS-SUPERFLUID-HELIUM"
 match (field row "simple_cubic_nearest_neighbours").toOption.getD .null with
 | .integer (.ofNat (n+1)) => pure (n+1)
 | .integer (.ofNat 0) => throw "NIST cubic coordination is not a positive exact count"
 | .integer (.negSucc _) => throw "NIST cubic coordination is not a positive exact count"
 | .boolean _ => throw "NIST cubic coordination is not a positive exact count"
 | .text _ => throw "NIST cubic coordination is not a positive exact count"
 | .array _ => throw "NIST cubic coordination is not a positive exact count"
 | .object _ => throw "NIST cubic coordination is not a positive exact count"
 | .null => throw "NIST cubic coordination is not a positive exact count"
structure HydrogenComparison where
 scale : Rat
 lymanPrediction : Rat
 lymanLower : Rat
 lymanUpper : Rat
 lymanPassed : Bool
 balmerPrediction : Rat
 balmerLower : Rat
 balmerUpper : Rat
 balmerPassed : Bool
def hydrogenComparison (record : Value) : Except String HydrogenComparison := do
 let atomic ← reportedRow record "NIST-ASD-HYDROGEN-ATOMIC-DATA"
 let lines ← reportedRow record "NIST-KRAMIDA-HYDROGEN-CRITICAL-COMPILATION-2010-2019"
 let scale ← decimalField atomic "hydrogen_ionization_wavenumber_cm_inverse"
 let lc ← decimalField lines "lyman_alpha_observed_wavenumber_cm_inverse"
 let lu ← decimalField lines "lyman_alpha_uncertainty_cm_inverse"
 let bc ← decimalField lines "balmer_alpha_observed_wavenumber_cm_inverse"
 let bu ← decimalField lines "balmer_alpha_uncertainty_cm_inverse"
 let ll ← RunningConvergence.positiveTake lc lu
 let bl ← RunningConvergence.positiveTake bc bu
 let lh := add lc lu
 let bh := add bc bu
 let lp := multiply scale (← HydrogenSpectrum.hydrogenTransition (.integer 2) (.integer 1))
 let bp := multiply scale (← HydrogenSpectrum.hydrogenTransition (.integer 3) (.integer 2))
 pure ⟨scale,lp,ll,lh,!(lp.blt ll) && !(lh.blt lp),bp,bl,bh,!(bp.blt bl) && !(bh.blt bp)⟩
theorem originalCubicCount : cubicObservedCoordination registeredRecord=.ok 6 := rfl
def cubicComparison (record : Value) : Except String Bool := do
 pure ((← cubicObservedCoordination record)==(← CubicAtomicSupport.cubicCoordination))
theorem originalCubicComparison : cubicComparison registeredRecord=.ok true := rfl
def hydrogenPassed (record : Value) : Except String Bool := do
 let comparison ← hydrogenComparison record
 pure (comparison.lymanPassed && comparison.balmerPassed)
theorem originalHydrogenComparison : hydrogenPassed registeredRecord=.ok true := rfl
def formalCountCheck : Bool := CubicAtomicSupport.cubicCoordination.toOption.getD 0 == 6
def observedCountCheck : Bool := (cubicObservedCoordination registeredRecord).toOption.getD 0 == 6
def cubicEqualityCheck : Bool := (cubicComparison registeredRecord).toOption.getD false
def lymanRatioCheck : Bool :=
 let q := ((HydrogenSpectrum.hydrogenTransition (.integer 2) (.integer 1)).toOption.getD zero)
 let expected := normalize 3 4 (by decide)
 !(q.blt expected) && !(expected.blt q)
def balmerRatioCheck : Bool :=
 let q := ((HydrogenSpectrum.hydrogenTransition (.integer 3) (.integer 2)).toOption.getD zero)
 let expected := normalize 5 36 (by decide)
 !(q.blt expected) && !(expected.blt q)
def lymanIntervalCheck : Bool := ((hydrogenComparison registeredRecord).map HydrogenComparison.lymanPassed).toOption.getD false
def balmerIntervalCheck : Bool := ((hydrogenComparison registeredRecord).map HydrogenComparison.balmerPassed).toOption.getD false
theorem formalCountCheckPassed : formalCountCheck=true := rfl
theorem observedCountCheckPassed : observedCountCheck=true := rfl
theorem cubicEqualityCheckPassed : cubicEqualityCheck=true := rfl
theorem lymanRatioCheckPassed : lymanRatioCheck=true := rfl
theorem balmerRatioCheckPassed : balmerRatioCheck=true := rfl
theorem lymanIntervalCheckPassed : lymanIntervalCheck=true := rfl
theorem balmerIntervalCheckPassed : balmerIntervalCheck=true := rfl
def cubicClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 let record ← authoritativeRecord bytes files payload
 if !(← cubicComparison record) then throw "sealed cubic count differs from the complete NIST row"
 pure "sealed-six-neighbour-cubic-support-exactly-matches-complete-nist-row"
def hydrogenClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 let record ← authoritativeRecord bytes files payload
 if !(← hydrogenPassed record) then throw "sealed hydrogen vector lies outside a complete NIST interval"
 pure "sealed-hydrogen-gross-ratios-lie-inside-both-complete-nist-line-intervals"
end SFT.Physics.AtomicPostsealMeasurement
