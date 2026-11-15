import SFT.Physics.SymmetryActionRankTrace
import SFT.Physics.SymmetryActionClassCompleteness
import SFT.Physics.SymmetryActionPaths
namespace SFT.Physics.SymmetryActionWitnesses
open SymmetryAction SymmetryActionDyadic SymmetryActionClasses SymmetryActionPaths
open SFT.Physics.LeptonIntervals
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive ControlInput where | integer (value : Int) | boolean (value : Bool)
def allChecks {α : Type} (check : α → Except String Bool) : List α → Except String Bool
 | [] => .ok true
 | x::xs => do
  if ← check x then allChecks check xs else pure false
def reducedDenominatorCheck (d : Nat) : Except String Bool :=
 if positive : 0<d then
  allChecks (fun n => if Nat.gcd n d == 1 then oddCoreIsConserved (.fraction (normalize (.ofNat n) d positive)) else .ok true) ((List.range d).map (·+1))
 else .ok true
def allReducedFoldPartsPreserveOddCore : ControlInput → Except String Bool
 | .boolean _ => .error "control boundary requires a positive denominator extension"
 | .integer limit => if limit<2 then .error "control boundary requires a positive denominator extension"
   else allChecks reducedDenominatorCheck ((List.range (limit.toNat-1)).map (·+2))
def dyadicDepthCheck (depth : Nat) : Except String Bool :=
 let d := 2^depth
 allChecks (fun n => do
  let trace ← dyadicFoldDescent (.fraction (normalize (.ofNat (2*n+1)) d (Nat.pow_pos (by decide))))
  if trace.length != depth+1 then pure false else
  if !(← descentRankStrictlyFalls trace) then pure false else
  pure (equalRat (trace.foldl (fun _ x => x) oneRatio) oneRatio)) (List.range (d/2))
def allDyadicPartsDescend : ControlInput → Except String Bool
 | .boolean _ => .error "dyadic control boundary requires a positive depth"
 | .integer limit => if limit<1 then .error "dyadic control boundary requires a positive depth"
   else allChecks dyadicDepthCheck ((List.range limit.toNat).map (·+1))
def values : List Rat := [normalize 1 4 (by decide),normalize 1 2 (by decide),normalize 3 4 (by decide),oneRatio]
def paths : Nat → List (List Rat)
 | 0 => [[]]
 | n+1 => values.flatMap (fun first => (paths n).map (fun rest => first::rest))
def repeated : List Rat → Bool
 | [] => false
 | [_] => false
 | a::b::rest => equalRat a b || repeated (b::rest)
def smallPathCheck : List Rat → Except String Bool
 | [] => .ok true
 | first::rest =>
  if equalRat first (rest.foldl (fun _ x => x) first) || repeated (first::rest) then .ok true
  else do
   let path := (first::rest).map (fun x => (SFT.Physics.FoldFirstReturn.Input.fraction x))
   if !(← detourCannotLowerAction path) then pure false else
   if ← isMonotoneDescent path then descentTelescopes path else pure true
def allSmallPathsObeyActionBoundary : Except String Bool :=
 allChecks (fun n => allChecks smallPathCheck (paths n)) [2,3,4,5]
def charges : List String := ["left-fibre","left-fibre","right-fibre","right-fibre"]
def edges : List Edge := [(0,1,normalize 1 4 (by decide)),(1,0,normalize 1 4 (by decide)),(2,3,normalize 1 4 (by decide)),(3,2,normalize 1 4 (by decide))]
def completeChargeWitness : Except String Bool := do
 pure ((← chargePreservingBijections charges).length == 4)
def incidenceCarrierWitness : Except String Bool := do
 let permutations ← completeSymmetryClass charges edges
 if permutations.length == 4 then allChecks (fun p => symmetryPreservesCharge p charges) permutations else pure false
def telescopingWitness : Except String Bool :=
 descentTelescopes ([oneRatio,normalize 3 4 (by decide),normalize 1 2 (by decide),normalize 1 4 (by decide)].map (fun x => (SFT.Physics.FoldFirstReturn.Input.fraction x)))
end SFT.Physics.SymmetryActionWitnesses
