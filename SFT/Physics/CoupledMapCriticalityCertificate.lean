import SFT.Physics.CoupledMapCriticality
namespace SFT.Physics.CoupledMapCriticalityCertificate
open CoupledMapCriticality LeptonIntervals
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
structure ThresholdRow where
 labelCount : Nat
 threshold : Rat
 below : Rat
 above : Rat
 belowMultiplier : Rat
 boundaryMultiplier : Rat
 aboveMultiplier : Rat
 classes : List String
structure Certificate where
 rows : List ThresholdRow
 uniqueThreshold : Bool
 binaryThresholdIsHalfOne : Bool
 topologyScope : String
 analyticProofValueRequired : Bool
def thresholdRow (m : Nat) : Except String ThresholdRow := do
 let threshold ← holdingThreshold (.integer (.ofNat m))
 let below := normalize (.ofNat (m-1)) (m+1) (Nat.zero_lt_succ m)
 let above := normalize (.ofNat m) (m+1) (Nat.zero_lt_succ m)
 pure ⟨m,threshold,below,above,
  ← retainedTransverseMultiplier (.integer (.ofNat m)) below,
  ← retainedTransverseMultiplier (.integer (.ofNat m)) threshold,
  ← retainedTransverseMultiplier (.integer (.ofNat m)) above,
  ← [below,threshold,above].mapM (stabilityClass (.integer (.ofNat m)))⟩
def criticalityCertificate : Except String Certificate := do
 let rows ← [2,3,5,7].mapM thresholdRow
 pure ⟨rows,
  rows.all (fun row => row.boundaryMultiplier==normalize 1 1 (by decide) && row.classes==["strict-expansion","neutral-boundary","strict-contraction"]),
  (← holdingThreshold (.integer 2))==normalize 1 2 (by decide),
  "normalized-drive-response-transverse-channel",false⟩
def certificateFacts : Except String Bool := do
 let c ← criticalityCertificate
 pure (c.uniqueThreshold && c.binaryThresholdIsHalfOne && !c.analyticProofValueRequired)
theorem originalComputedFacts : certificateFacts=.ok true := rfl
end SFT.Physics.CoupledMapCriticalityCertificate
