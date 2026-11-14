import SFT.Physics.AtomicTransitionRate
import SFT.Physics.RadioactiveDecay
namespace SFT.Physics.DecayWidthBranchingLifetime
open LeptonIntervals VacuumLedgerProofs
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
-- decay_width_branching_lifetime_terminal_law_v1.py: source Fraction carriers.
def positiveCarrier (n : Int) (d : Int := 1) : Except String Rat :=
 if h : 0<d then
  if n<1 then .error "decay carriers must remain exact and positive"
  else .ok (normalize n d.toNat (by
   cases d with
   | ofNat k => cases k with | zero => cases h | succ k => exact Nat.zero_lt_succ k
   | negSucc k => cases h))
 else .error "decay carriers must remain exact and positive"
def closedChannel : List Rat := []
def partialTransitionWidth (leg available action : Rat) : Except String Rat := do
 if [leg,available,action].any (fun r => decide (r.num<1)) then throw "partial width requires exact positive carriers"
 let paired := multiply leg leg
 LeptonRatios.divide (multiply paired available) action
def totalTransitionWidth (widths : List Rat) : Except String Rat := do
 if widths.isEmpty || widths.any (fun r => decide (r.num<1)) then throw "total width requires a nonempty positive open-channel family"
 match widths with
 | [] => throw "total width requires a nonempty positive open-channel family"
 | first::rest => pure (rest.foldl add first)
def branchingParts (widths : List Rat) : Except String (List Rat) := do
 let total ← totalTransitionWidth widths
 widths.mapM (fun width => LeptonRatios.divide width total)
def completeBranchingPartition (widths : List Rat) : Except String Rat := do
 totalTransitionWidth (← branchingParts widths)
def lifetimeFromWidth (action width : Rat) : Except String Rat :=
 if action.num<1 || width.num<1 then .error "lifetime requires exact positive action and width carriers"
 else LeptonRatios.divide action width
def appendOpenChannel (widths : List Rat) (successor : Rat) : Except String (List Rat) := do
 let _ ← totalTransitionWidth widths
 if successor.num<1 then throw "successor channel width must remain exact and positive"
 pure (widths++[successor])
def successorTotalIncrement (widths : List Rat) (successor : Rat) : Except String Rat := do
 let before ← totalTransitionWidth widths
 let after ← totalTransitionWidth (← appendOpenChannel widths successor)
 RunningConvergence.positiveTake after before
def widerStateLifetimeTake (action narrower wider : Rat) : Except String Rat := do
 if !narrower.blt wider then throw "width ordering must be strict"
 let longer ← lifetimeFromWidth action narrower
 let shorter ← lifetimeFromWidth action wider
 RunningConvergence.positiveTake longer shorter
def samplePartialWidths : Except String (List Rat) := do
 let action := normalize 1 2 (by decide)
 pure [← partialTransitionWidth (normalize 1 2 (by decide)) (normalize 1 2 (by decide)) action,
  ← partialTransitionWidth (normalize 1 2 (by decide)) (wholeRatio 1) action,
  ← partialTransitionWidth (wholeRatio 1) (normalize 5 8 (by decide)) action]
end SFT.Physics.DecayWidthBranchingLifetime
