import SFT.Physics.VacuumSpectrum
import SFT.Mathematics.LimitComputations
import SFT.Physics.LatticeCurvatureProofs
import SFT.Physics.FreePhase
import SFT.Foundation.FoldControls
namespace SFT.Physics.LatticeOperator
open SFT.Foundation GeneratorOperations
open LeptonIntervals VacuumLedgerProofs
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def one : Rat := normalize 1 1 (by decide)
def half : Rat := normalize 1 2 (by decide)
def quarter : Rat := normalize 1 4 (by decide)
def positiveCount (input : CountInput) (message : String) : Except String Nat :=
 match input with
 | .integer (.ofNat n) => if 0<n then .ok n else .error message
 | .boolean _ | .integer (.negSucc _) => .error message
structure Stencil where
 dimension : Nat
 centreShare : Rat
 neighbourCount : Nat
 neighbourShare : Rat
 neighbourTotal : Rat
 completeTotal : Rat
def stencil (d : Nat) (hd : 0<d) : Stencil :=
 let count := 2*d
 let share := normalize 1 (2*count) (Nat.mul_pos (by decide) (Nat.mul_pos (by decide) hd))
 let total := multiply share (wholeRatio count)
 ⟨d,half,count,share,total,add half total⟩
def conservativeStencil (input : CountInput) : Except String Stencil :=
 match input with
 | .integer (.ofNat d) => if hd : 0<d then .ok (stencil d hd)
   else .error "a lattice stencil requires a positive dimension count"
 | .boolean _ | .integer (.negSucc _) => .error "a lattice stencil requires a positive dimension count"
def siteAt : List Rat → Nat → Rat
 | [],_ => one
 | q::_,0 => q
 | _::qs,n+1 => siteAt qs n
def cyclicUpdate (state : List FoldFirstReturn.Input) : Except String (List Rat) := do
 if state.length<3 then throw "cyclic update requires at least three positive exact carriers"
 let values ← state.mapM (fun input => match input with
  | .nonFraction => .error "cyclic update requires at least three positive exact carriers"
  | .fraction q => if zero.blt q then .ok q else .error "cyclic update requires at least three positive exact carriers")
 let n := values.length
 pure ((List.range n).map (fun i => add (add (multiply half (siteAt values i))
  (multiply quarter (siteAt values ((i+n-1)%n))))
  (multiply quarter (siteAt values ((i+1)%n)))))
structure PhaseModeCarrier where
 index : Nat
 period : Nat
 centreShare : Rat
 forwardShare : Rat
 reverseShare : Rat
 identityPhase : Bool
def mode (size index : Nat) : PhaseModeCarrier :=
 ⟨index,size,half,quarter,quarter,index==size⟩
def modeCarriers (size : Nat) : List PhaseModeCarrier :=
 (List.range size).map (fun i => mode size (i+1))
def exactModeCarriers (input : CountInput) : Except String (List PhaseModeCarrier) :=
 match input with
 | .integer (.ofNat n) => if n<3 then .error "mode support requires a positive cycle of at least three sites" else .ok (modeCarriers n)
 | .boolean _ | .integer (.negSucc _) => .error "mode support requires a positive cycle of at least three sites"
structure PointSource where
 peakMagnitude : Nat
 peakOrientation : String
 ring : List (String × Rat)
 ringCount : Nat
 balancedMagnitude : Bool
def pointSourceOperator (input : CountInput) : Except String PointSource := do
 let st ← conservativeStencil input
 let ring := List.replicate st.neighbourCount ("opposition",one)
 pure ⟨st.neighbourCount,"source",ring,st.neighbourCount,
  equalRat (wholeRatio st.neighbourCount) (subtract (ring.foldl (fun acc row => add acc row.2) one) one)⟩
inductive AxisPosition where
 | origin
 | lower (magnitude : Nat)
 | upper (magnitude : Nat)
 deriving BEq, DecidableEq
def axisMagnitude : AxisPosition → Nat
 | .origin => 0
 | .lower n | .upper n => n
def positions (radius : Nat) : List AxisPosition :=
 .origin :: (List.range radius).flatMap (fun i => [.lower (i+1),.upper (i+1)])
def axisPositions (input : CountInput) : Except String (List AxisPosition) := do
 let n ← positiveCount input "a causal radius requires a positive tick count"
 pure (positions n)
def coordinates (alphabet : List AxisPosition) : Nat → List (List AxisPosition)
 | 0 => [[]]
 | n+1 => alphabet.flatMap (fun a => (coordinates alphabet n).map (List.cons a))
def radius (axes : List AxisPosition) : Nat := (axes.map axisMagnitude).foldl (·+·) 0
def ball (dimension ticks : Nat) : List (List AxisPosition) :=
 (coordinates (positions ticks) dimension).filter (fun axes => radius axes≤ticks)
def causalBall (dimension ticks : CountInput) : Except String (List (List AxisPosition)) := do
 let d ← positiveCount dimension "a causal ball requires a positive dimension count"
 let t ← positiveCount ticks "a causal ball requires a positive tick count"
 pure (ball d t)
def causalBallCount (dimension ticks : CountInput) : Except String Nat := do
 pure (← causalBall dimension ticks).length
structure Certificate where
 stencils : List Stencil
 operators : List PointSource
 causalCounts : List (Nat × List Nat)
 bumpUpdate : List Rat
 bumpCentre : Rat
 flatStationary : Bool
 presenceConserved : Bool
 modeCount : Nat
 identityModeCount : Nat
 modeRelation : String
 irrationalModeValueEvaluated : Bool
def sameRats : List Rat → List Rat → Bool
 | [],[] => true
 | a::as,b::bs => equalRat a b && sameRats as bs
 | [],_::_ => false
 | _::_,[] => false
def total (xs : List Rat) : Rat := subtract (xs.foldl add one) one
def latticeFamilyCertificate : Except String Certificate := do
 let dimensions := [1,2,3]
 let stencils ← dimensions.mapM (fun d => conservativeStencil (.integer (.ofNat d)))
 let operators ← dimensions.mapM (fun d => pointSourceOperator (.integer (.ofNat d)))
 let counts := dimensions.map (fun d => (d,[1,2,3].map (fun t => (ball d t).length)))
 let bump := [quarter,half,quarter]
 let updated ← cyclicUpdate (bump.map FoldFirstReturn.Input.fraction)
 let third : Rat := normalize 1 3 (by decide)
 let flat := [third,third,third]
 let flatUpdated ← cyclicUpdate (flat.map FoldFirstReturn.Input.fraction)
 let modes ← exactModeCarriers (.integer 7)
 pure ⟨stencils,operators,counts,updated,siteAt updated 1,sameRats flatUpdated flat,
  equalRat (total updated) (total bump),modes.length,(modes.filter PhaseModeCarrier.identityPhase).length,
  "half-One centre plus quarter forward phase plus quarter reverse phase",false⟩
theorem sourceOneDirection : (stencil 1 (by decide)).neighbourShare=quarter := rfl
theorem sourcePlanar : (stencil 2 (by decide)).neighbourShare=normalize 1 8 (by decide) := rfl
theorem sourceThreeDirections : (stencil 3 (by decide)).neighbourCount=6 := rfl
theorem sourceCausalCounts :
 ([1,2,3].map (fun d => [1,2,3].map (fun t => (ball d t).length)))=
 [[3,5,7],[5,13,25],[7,25,63]] := rfl
theorem sourceModeCount (n : Nat) : (modeCarriers n).length=n := by
 unfold modeCarriers
 rw [VacuumSpectrum.mappedLength]
 exact (VacuumSpectrum.rangeLoopLength n []).trans (Nat.add_zero _)
theorem sourceAxisSuccessor (d : Nat) (hd : 0<d) :
 (stencil (d+1) (Nat.zero_lt_succ d)).neighbourCount=(stencil d hd).neighbourCount+2 := by
 change 2*(d+1)=2*d+2
 exact Nat.mul_succ 2 d
theorem sourceNeighbourHalf (d : Nat) (hd : 0<d) : (stencil d hd).neighbourTotal=half := by
 change multiply (natRatio 1 (2*(2*d)) _) (wholeRatio (2*d))=natRatio 1 2 (by decide)
 rw [← natRatioWhole,VacuumScaleProofs.multiplyNormalized]
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.mul_one,Nat.one_mul,Nat.mul_comm (2*d) 2]
theorem sourceConservesOne (d : Nat) (hd : 0<d) : (stencil d hd).completeTotal=one := by
 change add half (stencil d hd).neighbourTotal=one
 rw [sourceNeighbourHalf]
 rfl
end SFT.Physics.LatticeOperator
