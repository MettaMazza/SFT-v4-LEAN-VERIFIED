import SFT.Physics.InteractionUnification
namespace SFT.Physics.InteractionUnificationWitnesses
open InteractionUnification SFT.Mathematics.LimitComputations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def tableCheck : Bool :=
 ([2,3,5,7] : List Nat).all fun m =>
  match baseSectorTable (.integer (.ofNat m)) with
  | .error _ => false
  | .ok row => match m with
   | 2 => equalRat row.coupling half && equalRat row.massShortfall half && row.mediatorCount==3
   | 3 => equalRat row.coupling (SFT.Physics.LeptonIntervals.normalize 2 3 (by decide)) && equalRat row.massShortfall (SFT.Physics.LeptonIntervals.normalize 1 3 (by decide)) && row.mediatorCount==8
   | 5 => equalRat row.coupling (SFT.Physics.LeptonIntervals.normalize 4 5 (by decide)) && equalRat row.massShortfall (SFT.Physics.LeptonIntervals.normalize 1 5 (by decide)) && row.mediatorCount==24
   | 7 => equalRat row.coupling (SFT.Physics.LeptonIntervals.normalize 6 7 (by decide)) && equalRat row.massShortfall (SFT.Physics.LeptonIntervals.normalize 1 7 (by decide)) && row.mediatorCount==48
   | _ => false
def halfCheck : Bool :=
 (match commonHalfOneSectors with | .ok ns => ns==[3,5,7] | .error _ => false) &&
 (match standingModes (.integer 2) with | .ok qs => qs.isEmpty | .error _ => false)
def depthCheck : Bool := (List.range 16).all fun k =>
 match allDepthOrderAndNoncoincidence (.integer (.ofNat (k+1))) with | .ok b => b | .error _ => false
def periodCheck : Bool := match periodDictionary with
 | .error _ => false
 | .ok p => p.gravity==1 && p.electromagnetic==2 && p.strong==3 && p.joint==6
def adverseCheck : Bool := !priorFlatSlopeBundleIsConsistent
def witnesses : List Witness := [⟨"complete-table","The sector table yields couplings, mass shortfalls and mediator counts for all four forced primes.",tableCheck⟩,⟨"shared-half-One","Half-One is present in every odd forced sector and absent from the two-sector interior.",halfCheck⟩,⟨"all-depth-order","Every tested common-support depth retains strict order and no coincidence.",depthCheck⟩,⟨"period-dictionary","Exact Fold traces yield gravity one, EM two, strong three and joint six.",periodCheck⟩,⟨"adverse-slope-bundle","The prior simultaneous slope=m-1 and slope(2)=0 statements fail their own exact substitution.",adverseCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.InteractionUnificationWitnesses
