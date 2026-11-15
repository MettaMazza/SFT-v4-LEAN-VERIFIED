import SFT.Physics.MediatorRangeChannelTrace
namespace SFT.Physics.MediatorRangeChannelWitnesses
open MediatorRangeChannel LeptonIntervals
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def emptyCheck : Except String MassRecord → Bool
 | .error _ => false
 | .ok .emptyOne => true
 | .ok (.positive _) => false
def ratCheck : Except String Rat → Rat → Bool
 | .ok p,q => equalRat p q | .error _,_ => false
def countCheck : Except String Nat → Nat → Bool
 | .ok n,m => n==m | .error _,_ => false
def boolCheck : Except String Bool → Bool
 | .ok b => b | .error _ => false
def traceCheck : Except String (List Rat) → Bool
 | .ok xs => xs.length==9 && xs.all (fun q => equalRat q one)
 | .error _ => false
def positiveCheck : Except String Rat → Bool
 | .ok q => zero.blt q | .error _ => false
def half : Rat := normalize 1 2 (by decide)
def third : Rat := normalize 1 3 (by decide)
def twoThirds : Rat := normalize 2 3 (by decide)
def seventh : Rat := normalize 1 7 (by decide)
def preservedCheck : Bool := emptyCheck (preservedMassRecord (.fraction (add half half))) && emptyCheck (preservedMassRecord (.fraction (add twoThirds third)))
def brokenCheck : Bool := ratCheck (brokenChannelMass (.fraction half)) half && ratCheck (brokenChannelMass (.fraction twoThirds)) third
def reachCheck : Bool := countCheck (finiteReachCount (.fraction third)) 2 && countCheck (finiteReachCount (.fraction seventh)) 6 && countCheck (finiteReachCount (.fraction half)) 1 && countCheck (finiteReachCount (.fraction twoThirds)) 1
def conservationCheck : Bool := [seventh,third,half,twoThirds].all (fun m => boolCheck (ledgerConservesOne (.fraction m)))
def orderCheck : Bool := boolCheck (largerMassShorterRange (.fraction seventh) (.fraction third))
def masslessCheck : Bool := traceCheck (masslessForwardTrace (.integer 8)) && (List.range 16).all (fun r => positiveCheck (masslessInverseSquare (.fraction one) (.fraction (normalize (.ofNat (r+1)) 1 (by decide)))))
def witnesses : List Witness := [⟨"preserved-combinations","Both registered channel pairs reassemble the One and have empty mass records.",preservedCheck⟩,⟨"broken-shortfalls","Each proper channel has its exact positive One-shortfall.",brokenCheck⟩,⟨"v2-reach","Mass one-third reaches two acts, one-seventh reaches six, half-One reaches one and two-thirds reaches one.",reachCheck⟩,⟨"conservation","Every exact massive control trace retains forward plus rest equal to the One.",conservationCheck⟩,⟨"range-order","The lighter exact mediator has the longer reciprocal scale.",orderCheck⟩,⟨"massless-finite-radius","Massless forward support remains One and inverse-square response stays positive at every tested finite radius.",masslessCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MediatorRangeChannelWitnesses
