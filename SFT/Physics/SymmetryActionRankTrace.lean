import SFT.Physics.SymmetryActionRank
namespace SFT.Physics.SymmetryActionRankTrace
open SymmetryAction SymmetryActionDyadic SymmetryActionDescent SymmetryActionRank
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Foundation.FractionReduction
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
theorem originalRankEdgesTrace (depth fuel : Nat) (p : Part)
 (shape : p.denominator=2^(depth+1)) (enough : depth+1≤fuel) :
 rankEdges (asFraction p) ((traceLoop fuel (SFT.Foundation.ExactOperations.foldPart p)).map asFraction)=.ok true := by
 induction depth generalizing fuel p with
 | zero =>
  cases fuel with
  | zero => exact False.elim (Nat.not_succ_le_zero _ enough)
  | succ fuel =>
   have next := originalDyadicNextDenominator p 0 shape
   unfold traceLoop
   rw [originalDenominatorOneStops _ next]
   change rankEdges (asFraction p) [asFraction (SFT.Foundation.ExactOperations.foldPart p)]=.ok true
   rw [originalOneValue _ next]
   unfold rankEdges
   change (if p.denominator != 2 then Except.ok false else Except.ok true)=Except.ok true
   rw [shape]
   rfl
 | succ depth ih =>
  cases fuel with
  | zero => exact False.elim (Nat.not_succ_le_zero _ enough)
  | succ fuel =>
   have next := originalDyadicNextDenominator p (depth+1) shape
   unfold traceLoop
   rw [originalPositiveDepthContinues _ depth next]
   change rankEdges (asFraction p) (asFraction (SFT.Foundation.ExactOperations.foldPart p)::
    (traceLoop fuel (SFT.Foundation.ExactOperations.foldPart (SFT.Foundation.ExactOperations.foldPart p))).map asFraction)=.ok true
   unfold rankEdges
   rw [originalPositiveDepthNotOneValue _ depth next]
   rw [originalEveryPositiveRank p (depth+1) shape]
   dsimp only [Except.bind,Bind.bind]
   rw [originalEveryPositiveRank _ depth next]
   dsimp only [Except.bind,Bind.bind]
   have same : (depth+1+1 != depth+1+1)=false := by
    change (!Nat.beq (depth+1+1) (depth+1+1))=false
    rw [SFT.Mathematics.OrbitLoopCompletion.natBeqSelf]
    rfl
   rw [same]
   exact ih fuel _ next (Nat.le_of_succ_le_succ enough)
theorem originalTraceLastValue (p : Part) (trace : List Part) (run : SourceDescent p trace) (initial : Rat) :
 (trace.map asFraction).foldl (fun _ x => x) initial=oneRatio := by
 induction run generalizing initial with
 | stop p one =>
  have red : Nat.gcd p.numerator p.denominator=1 := p.reduced
  rw [one,gcdSelf] at red
  exact originalOneValue p red
 | step p rest nonterminal tail ih => exact ih (asFraction p)
theorem originalWholeTraceRankCheck (depth fuel : Nat) (p : Part)
 (shape : p.denominator=2^(depth+1)) (enough : depth+1≤fuel) :
 descentRankStrictlyFalls ((traceLoop (fuel+1) p).map asFraction)=.ok true := by
 have next := originalDyadicNextDenominator p depth shape
 have run := originalDyadicTrace depth fuel (SFT.Foundation.ExactOperations.foldPart p) next enough
 have length := originalTraceLength depth fuel (SFT.Foundation.ExactOperations.foldPart p) next enough
 have edges := originalRankEdgesTrace depth fuel p shape enough
 unfold traceLoop
 rw [originalPositiveDepthContinues p depth shape]
 cases h : traceLoop fuel (SFT.Foundation.ExactOperations.foldPart p) with
 | nil =>
  rw [h] at length
  exact False.elim (Nat.noConfusion length)
 | cons target rest =>
  have last := originalTraceLastValue _ _ run (asFraction target)
  rw [h] at last edges
  change (rest.map asFraction).foldl (fun _ x => x) (asFraction target)=oneRatio at last
  change descentRankStrictlyFalls (asFraction p::asFraction target::rest.map asFraction)=.ok true
  unfold descentRankStrictlyFalls
  dsimp only
  rw [last]
  exact edges
theorem originalEveryReturnedRankCheck (depth : Nat) (p : Part)
 (shape : p.denominator=2^(depth+1)) :
 descentRankStrictlyFalls ((traceLoop (p.denominator+1) p).map asFraction)=.ok true := by
 apply originalWholeTraceRankCheck depth p.denominator p shape
 rw [shape]
 exact Nat.le_trans (Nat.le_succ _) (AccumulatedSeparationTolerance.sourcePowerCoversCount (depth+1))
end SFT.Physics.SymmetryActionRankTrace
