import SFT.Physics.SymmetryActionConservation
import SFT.Mathematics.LimitComputations
namespace SFT.Physics.SymmetryActionDyadic
open SymmetryAction SymmetryActionConservation SymmetryActionOddCore
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def oneRatio : Rat := ⟨1,1,by decide,by decide⟩
def traceLoop : Nat → Part → List Part
 | 0,_ => []
 | fuel+1,p => if p.numerator==p.denominator then [p]
   else p::traceLoop fuel (SFT.Foundation.ExactOperations.foldPart p)
def dyadicFoldDescent (value : Input) : Except String (List Rat) := do
 let core ← reducedOddDenominatorCore value
 if core != 1 then .error "fixed-point descent is the exact dyadic basin"
 else match value with
 | .nonFraction => .error "odd-core custody requires one exact positive Fold part"
 | .fraction x => match admitFraction x with
   | none => .error "odd-core custody requires one exact positive Fold part"
   | some p => pure ((traceLoop (p.denominator+1) p).map asFraction)
-- The source tests equality to One before its Fraction-domain check.
inductive RankInput where
 | fraction (value : Rat)
 | otherEqualOne
 | other
def rankLoop : Nat → Nat → Nat → Nat
 | 0,_,rank => rank
 | fuel+1,denominator,rank => if 2<denominator then rankLoop fuel (denominator/2) (rank+1) else rank
def dyadicDenominatorRank : RankInput → Except String Nat
 | .otherEqualOne => .error "rank requires a nonterminal dyadic Fold part"
 | .other => .error "odd-core custody requires one exact positive Fold part"
 | .fraction value => do
  if equalRat value oneRatio then .error "rank requires a nonterminal dyadic Fold part"
  else
   let core ← reducedOddDenominatorCore (.fraction value)
   if core != 1 then .error "rank requires a nonterminal dyadic Fold part"
   else pure (rankLoop value.den value.den 1)
def rankEdges : Rat → List Rat → Except String Bool
 | _,[] => .ok true
 | source,target::rest => do
  if equalRat target oneRatio then
   if source.den != 2 then pure false else rankEdges target rest
  else
   let before ← dyadicDenominatorRank (.fraction source)
   let after ← dyadicDenominatorRank (.fraction target)
   if before != after+1 then pure false else rankEdges target rest
def descentRankStrictlyFalls : List Rat → Except String Bool
 | [] => .ok false
 | [_] => .ok false
 | source::target::rest =>
   if equalRat (rest.foldl (fun _ x => x) target) oneRatio then rankEdges source (target::rest) else .ok false
end SFT.Physics.SymmetryActionDyadic
