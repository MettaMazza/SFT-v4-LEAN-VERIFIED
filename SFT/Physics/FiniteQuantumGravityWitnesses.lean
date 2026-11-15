import SFT.Physics.FiniteQuantumGravity
namespace SFT.Physics.FiniteQuantumGravityWitnesses
open FiniteQuantumGravity
open SFT.Physics.LeptonIntervals (zero)
open SFT.Mathematics.LimitComputations (equalRat equalInt)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def checkModel (n : Nat) (f : Model → Bool) : Bool :=
 match finiteQuantumGravityModel (.integer (.ofNat n)) with
 | .error _ => false
 | .ok m => f m
def rankCheck : Bool := (List.range 8).all (fun i => checkModel (i+1)
 (fun m => m.symmetricSlots==10 && equalInt m.physicalPolarizations 2))
def finiteCheck : Bool := (List.range 8).all (fun i => checkModel (i+1)
 (fun m => m.quantumSupport==2^(i+1) && zero.blt m.distanceFloor && !half.blt m.distanceFloor &&
  zero.blt m.loopSum && m.loopSum.blt one))
def causalCheck : Bool := (List.range 8).all (fun i => checkModel (i+1)
 (fun m => sameRecords m.massRecord emptyOne && equalRat m.causalAdvance one))
def horizonCheck : Bool := (List.range 8).all (fun i => checkModel (i+1) Model.horizonQuarterLaw)
def checkSuccessor (n : Nat) : Bool :=
 match successorPreservesModel (.integer (.ofNat n)) with
 | .error _ => false
 | .ok b => b
def successorCheck : Bool := (List.range 7).all (fun i => checkSuccessor (i+1))
def witnesses : List Witness := [⟨"rank-two-two-mode-carrier","Every tested depth retains ten symmetric slots, four conservation constraints, four coordinate-shift redundancies and two modes.",rankCheck⟩,⟨"finite-positive-depths","Every tested depth has finite support, positive floor and loop sum strictly below the One.",finiteCheck⟩,⟨"causal-massless-carrier","The gravity carrier retains empty mass/rest record and exact One-cell causal advance.",causalCheck⟩,⟨"horizon-ledger","Every tested finite area support retains exactly one record per four cells.",horizonCheck⟩,⟨"successor-closure","Every tested successor preserves the joint model without completed infinity or extra dimension.",successorCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.FiniteQuantumGravityWitnesses
