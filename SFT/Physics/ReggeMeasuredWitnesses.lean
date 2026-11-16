import SFT.Physics.ReggeDimensional
namespace SFT.Physics.ReggeMeasuredWitnesses
open LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalLaw : Bool := match ReggeDimensional.theoremCertificate (.count (.integer 64)) with | .error _ => false | .ok c => c.firstFive == [normalize 3 5 (by decide),normalize 9 5 (by decide),normalize 3 1 (by decide),normalize 21 5 (by decide),normalize 27 5 (by decide)]
def allPositive : Bool := ((List.range 5).map (fun n => ReggeDimensional.squaredResonanceCarrier (.count (.integer (.ofNat (n+1)))))).all (fun result => match result with | .error _ => false | .ok q => zero.blt q)
def witnesses : List Witness := [⟨"formal-law","The formal carrier has exact 3/5 base and 6/5 successor.",formalLaw⟩,⟨"all-positive","Every registered exact squared carrier is positive.",allPositive⟩]
theorem formalLawPassed : formalLaw=true := rfl
theorem allPositivePassed : allPositive=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.ReggeMeasuredWitnesses
