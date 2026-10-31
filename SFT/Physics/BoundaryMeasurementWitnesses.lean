import SFT.Physics.BoundaryGrowthDiscriminator
namespace SFT.Physics.BoundaryMeasurementWitnesses
open BoundaryGrowthDiscriminator SFT.Physics.LeptonIntervals
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := match checkedCompatible (.fraction (normalize 3 1 (by decide))) (.fraction (normalize 27 1 (by decide))) (.fraction (normalize 27 1 (by decide))) with | .error _ => false | .ok ns => ns == [3]
theorem check0Passed : check0 = true := rfl
def check1 : Bool := match checkedCompatible (.fraction (normalize 2 1 (by decide))) (.fraction (normalize 7 1 (by decide))) (.fraction (normalize 9 1 (by decide))) with | .error _ => false | .ok ns => ns == [3]
theorem check1Passed : check1 = true := rfl
def check2 : Bool := match checkedStopCertificate (normalize 5 2 (by decide)) (normalize 40 1 (by decide)) with | .error _ => false | .ok ns => ns
theorem check2Passed : check2 = true := rfl
def witnesses : List Witness := [⟨"generic-exponent","A synthetic exact cubic relation retains only the third positive exponent.",check0⟩,⟨"interval-family","An interval comparison retains every compatible exponent rather than fitting a point.",check1⟩,⟨"monotonic-closure","Strict excess remains strict at the generated successor.",check2⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.Physics.BoundaryMeasurementWitnesses
