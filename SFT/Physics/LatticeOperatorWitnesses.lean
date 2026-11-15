import SFT.Physics.LatticeOperator
namespace SFT.Physics.LatticeOperatorWitnesses
open LatticeOperator
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def certificateCheck (f : Certificate → Bool) : Bool :=
 match latticeFamilyCertificate with
 | .error _ => false
 | .ok c => f c
def stencilCheck : Bool := certificateCheck (fun c =>
 c.stencils.all (fun s => equalRat s.completeTotal one) && (c.stencils.map Stencil.neighbourCount)==[2,4,6])
def quarterCheck : Bool := equalRat (stencil 1 (by decide)).neighbourShare quarter &&
 certificateCheck (fun c => equalRat c.bumpCentre (SFT.Physics.LeptonIntervals.normalize 3 8 (by decide)))
def sourceCheck : Bool := certificateCheck (fun c =>
 (c.operators.map (fun p => (p.peakMagnitude,p.ringCount,p.balancedMagnitude)))==[(2,2,true),(4,4,true),(6,6,true)])
def causalCheck : Bool := certificateCheck (fun c =>
 c.causalCounts==[(1,[3,5,7]),(2,[5,13,25]),(3,[7,25,63])])
def modesCheck : Bool := certificateCheck (fun c => c.modeCount==7 && c.identityModeCount==1 &&
 c.flatStationary && !c.irrationalModeValueEvaluated)
def witnesses : List Witness := [⟨"conservative-stencils","The one-, two- and three-direction stencils each reassemble the One and give neighbour counts two, four and six.",stencilCheck⟩,⟨"half-quarter-quarter","The one-direction stencil is exactly half-One, quarter-One, quarter-One and the symmetric bump centre becomes three-eighths.",quarterCheck⟩,⟨"point-source-family","Point-source peak and ring counts are two, four and six with exact magnitude balance.",sourceCheck⟩,⟨"causal-balls","Complete oriented causal enumeration gives the full one-, two- and three-direction vectors.",causalCheck⟩,⟨"modes-and-flat-state","A seven-site cycle has seven exact phase carriers, exactly one identity mode and stationary flat support.",modesCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.LatticeOperatorWitnesses
