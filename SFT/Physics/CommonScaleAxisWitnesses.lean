import SFT.Physics.CommonScaleAxis
namespace SFT.Physics.CommonScaleAxisWitnesses
open CommonScaleAxis
set_option maxRecDepth 100000
set_option maxHeartbeats 8000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def passed : Except String Bool → Bool
 | .error _ => false
 | .ok value => value
def expectNats (r : Except String (List Nat)) (expected : List Nat) : Bool :=
 match r with
 | .error _ => false
 | .ok values => values == expected
def check0 : Bool := expectNats ((List.range 8).mapM fun k => RunningConvergence.generatedScaleSupport (.integer (.ofNat (k+1)))) [1,2,4,8,16,32,64,128]
def check1 : Bool := passed do
 let rows ← (List.range 7).mapM fun k => do
  let before ← scaleSpacing (.integer (.ofNat (k+1)))
  let after ← scaleSpacing (.integer (.ofNat (k+2)))
  .ok (LeptonIntervals.multiply after (LeptonIntervals.normalize 2 1 (by decide)) == before)
 .ok (rows.all id)
def check2 : Bool := passed do
 let rows ← (List.range 8).mapM fun k => do
  let count ← traversalCount (.integer (.ofNat (k+1)))
  let support ← RunningConvergence.generatedScaleSupport (.integer (.ofNat (k+1)))
  .ok (count == support)
 .ok (rows.all id)
def check3 : Bool := passed do
 let vector ← RunningConvergence.commonScaleVector (.integer 1)
 let sectors ← PrimeSectorLadder.primeSectorLadder
 .ok (vector.map Prod.fst == sectors)
def check4 : Bool := passed do
 let curve ← (List.range 4).mapM fun k => leadingElectroweakShare (.integer (.ofNat (k+1)))
 .ok (curve.length == 4 && (curve.zip ([(9,25),(4,13),(9,34),(25,106)] : List (Int × Nat))).all (fun (q,(n,d)) => (@decide (q.num=n) (Int.decEq q.num n)) && q.den==d))
def check5 : Bool := passed (leadingCurveStrictlyDescends (.integer 12))
def check6 : Bool := expectNats (internalSquareAnchorLevels (.integer 16)) [2]
def check7 : Bool := passed do
 let chain ← terminalElectroweakChain
 .ok (chain.completeSupport == 16 && chain.activeLevel == 13)
def check8 : Bool := passed do
 let chain ← terminalElectroweakChain
 .ok (chain.baseShare == LeptonIntervals.normalize 225 1009 (by decide) &&
  chain.terminalShare == LeptonIntervals.normalize 1930922298157999 8642477221479757 (by decide))
def check9 : Bool := passed do
 let ratio ← commonRationalRescalingRatio (.fraction (LeptonIntervals.normalize 7 5 (by decide)))
  (.fraction (LeptonIntervals.normalize 11 3 (by decide))) (.fraction (LeptonIntervals.normalize 13 17 (by decide)))
 .ok (ratio == LeptonIntervals.normalize 21 55 (by decide))
def check10 : Bool := expectNats (scaleAxisLandmarks.map (List.map Landmark.support)) [1,2,8,16,13,32,128,127]
def witnesses : List Witness := [⟨"binary-support","The first eight generated supports are exact powers produced only by succession.",check0⟩,⟨"reciprocal-spacing","Every successor halves exact spacing.",check1⟩,⟨"one-cell-transport","Traversal count equals complete support at every registered witness rung.",check2⟩,⟨"complete-sector-axis","The shared vector retains exactly the forced sectors two, three, five and seven.",check3⟩,⟨"leading-curve","The first four leading weak shares reproduce the exact V1 structural vector.",check4⟩,⟨"strict-weak-descent","Every tested binary successor lowers the exact weak share and the induction identity extends it.",check5⟩,⟨"unique-internal-anchor","Only positive level two closes the binary source on a Fold power.",check6⟩,⟨"terminal-held-level","Complete support sixteen holds three directions and forces level thirteen.",check7⟩,⟨"terminal-share","The held level and sole return reproduce the admitted exact terminal share.",check8⟩,⟨"unit-invariance","A common exact held unit cancels from a like-dimension ratio.",check9⟩,⟨"named-landmarks","Every source-family landmark has one typed generated support or held-support record.",check10⟩]
theorem check0Passed : check0=true := rfl
theorem check1Passed : check1=true := rfl
theorem check2Passed : check2=true := rfl
theorem check3Passed : check3=true := rfl
theorem check4Passed : check4=true := rfl
theorem check5Passed : check5=true := rfl
theorem check6Passed : check6=true := rfl
theorem check7Passed : check7=true := rfl
theorem check8Passed : check8=true := rfl
theorem check9Passed : check9=true := rfl
theorem check10Passed : check10=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (check0 && check1 && check2 && check3 && check4 && check5 && check6 && check7 && check8 && check9 && check10 && true)=true
 rw [check0Passed,check1Passed,check2Passed,check3Passed,check4Passed,check5Passed,check6Passed,check7Passed,check8Passed,check9Passed,check10Passed]
 rfl
end SFT.Physics.CommonScaleAxisWitnesses
