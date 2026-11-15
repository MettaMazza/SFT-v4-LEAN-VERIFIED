import SFT.Physics.FiniteLoopProofs
import SFT.Physics.SymmetricSourceConservation
import SFT.Physics.HorizonInformation
import SFT.Physics.LatticeOperator
namespace SFT.Physics.FiniteQuantumGravity
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def one : Rat := normalize 1 1 (by decide)
def half : Rat := normalize 1 2 (by decide)
def emptyOne : List String := ["empty-One"]
def positiveTakeWhole (whole part : CountInput) : Except String Int :=
 match whole with
 | .boolean _ => .error "positive whole take requires an ordered positive pair"
 | .integer w => match part with
  | .boolean _ => .error "positive whole take requires an ordered positive pair"
  | .integer p => if w≤p || p<1 then .error "positive whole take requires an ordered positive pair" else .ok (w-p)
def finiteLoopSum (depth : CountInput) : Except String Rat := do
 let n ← LatticeOperator.positiveCount depth "finite loop support requires positive depth"
 let pair ← FiniteLoop.appendTerms (wholeRatio 2) (n-1) half half
 pure pair.1
def doubleSupport : Nat → Nat → Nat
 | 0,support => support
 | n+1,support => doubleSupport n (support+support)
structure Model where
 carrier : String
 depth : Nat
 spatialDirections : Nat
 coordinateCount : Nat
 symmetricRank : Nat
 symmetricSlots : Nat
 conservationConstraints : Nat
 coordinateShiftRedundancies : Nat
 physicalPolarizations : Int
 massRecord : List String
 causalAdvance : Rat
 quantumSupport : Nat
 distanceFloor : Rat
 loopSum : Rat
 horizonAreaCells : Nat
 horizonRecords : Rat
 horizonQuarterLaw : Bool
 extraSpatialDirectionRecord : List String
 completedInfinityUsed : Bool
def finiteQuantumGravityModel (depth : CountInput) : Except String Model := do
 let n ← LatticeOperator.positiveCount depth "finite quantum-gravity depth must be positive"
 let spatialDirections := 3
 let timeDirections := 1
 let coordinateCount := spatialDirections+timeDirections
 let symmetricRank := 2
 let slots := coordinateCount*(coordinateCount+1)/2
 let after ← positiveTakeWhole (.integer (.ofNat slots)) (.integer (.ofNat coordinateCount))
 let polarizations ← positiveTakeWhole (.integer after) (.integer (.ofNat coordinateCount))
 let support := doubleSupport n 1
 let floor ← LeptonRatios.divide one (wholeRatio support)
 let records ← LeptonRatios.divide (wholeRatio support) (wholeRatio 4)
 let loops ← finiteLoopSum depth
 pure ⟨"single-finite-Fold-lattice",n,spatialDirections,coordinateCount,symmetricRank,slots,
  coordinateCount,coordinateCount,polarizations,emptyOne,one,support,floor,loops,support,records,
  equalRat (multiply records (wholeRatio 4)) (wholeRatio support),emptyOne,false⟩
def sameRecords : List String → List String → Bool
 | [],[] => true
 | a::as,b::bs => SFT.Host.Text.equal a b && sameRecords as bs
 | [],_::_ => false
 | _::_,[] => false
def successorPreservesModel (depth : CountInput) : Except String Bool := do
 let current ← finiteQuantumGravityModel depth
 let successor ← finiteQuantumGravityModel (.integer (.ofNat (current.depth+1)))
 pure (SFT.Host.Text.equal current.carrier successor.carrier &&
  (current.spatialDirections==successor.spatialDirections && successor.spatialDirections==3) &&
  (current.symmetricRank==successor.symmetricRank && successor.symmetricRank==2) &&
  (SFT.Mathematics.LimitComputations.equalInt current.physicalPolarizations successor.physicalPolarizations && SFT.Mathematics.LimitComputations.equalInt successor.physicalPolarizations 2) &&
  (sameRecords current.massRecord successor.massRecord && sameRecords successor.massRecord emptyOne) &&
  (equalRat current.causalAdvance successor.causalAdvance && equalRat successor.causalAdvance one) &&
  successor.quantumSupport==2*current.quantumSupport && successor.distanceFloor.blt current.distanceFloor &&
  zero.blt successor.distanceFloor && current.loopSum.blt successor.loopSum && successor.loopSum.blt one &&
  successor.horizonQuarterLaw && !successor.completedInfinityUsed)

theorem originalRankReduction :
 (do let after ← positiveTakeWhole (.integer 10) (.integer 4)
     positiveTakeWhole (.integer after) (.integer 4))=.ok 2 := rfl
theorem originalSymmetricSlots : 4*(4+1)/2=SymmetricSourceConservation.symmetricSlots.length := rfl
theorem originalDoubleSupport (depth support : Nat) : doubleSupport depth support=support*2^depth := by
 induction depth generalizing support with
 | zero => exact (Nat.mul_one support).symm
 | succ n ih =>
  change doubleSupport n (support+support)=_
  rw [ih,Nat.pow_succ]
  have twice : support+support=support*2 := (Nat.mul_two support).symm
  rw [twice,SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm 2 (2^n)]
theorem originalSupportAtDepth (depth : Nat) : doubleSupport depth 1=2^depth :=
 (originalDoubleSupport depth 1).trans (Nat.one_mul _)
theorem originalSupportSuccessor (depth : Nat) : doubleSupport (depth+1) 1=2*doubleSupport depth 1 := by
 rw [originalSupportAtDepth,originalSupportAtDepth,Nat.pow_succ,Nat.mul_comm]
open SFT.Mathematics.DyadicClosure in
theorem originalFiniteLoop (n : Nat) : finiteLoopSum (.integer (.ofNat (n+1)))=
 .ok (natRatio (total (weights (n+1))) (2^(n+1)) (Nat.pow_pos (by decide))) := by
 unfold finiteLoopSum LatticeOperator.positiveCount
 dsimp only
 rw [if_pos (Nat.zero_lt_succ n)]
 change (do let pair ← FiniteLoop.appendTerms (wholeRatio 2) n half half; pure pair.1)=_
 rw [show half=(⟨1,2,by decide,by decide⟩ : Rat) from rfl,FiniteLoopProofs.completeLoopState]
 rfl
theorem originalDepthOne : finiteQuantumGravityModel (.integer 1)=
 .ok ⟨"single-finite-Fold-lattice",1,3,4,2,10,4,4,2,emptyOne,one,2,half,half,2,half,true,emptyOne,false⟩ := rfl
end SFT.Physics.FiniteQuantumGravity
