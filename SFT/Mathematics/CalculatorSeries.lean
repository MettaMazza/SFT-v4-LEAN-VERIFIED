import SFT.Mathematics.CalculatorRoots
import SFT.Physics.LeptonRatios
namespace SFT.Mathematics.CalculatorSeries
open SFT.Physics SFT.Mathematics SFT.Host
open CalculatorValues CalculatorRoots
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def natural (n : Nat) : Rat := LeptonIntervals.normalize (Int.ofNat n) 1 (by decide)
def tolerance (places : Int) : Except String Rat :=
 if places < 1 || places > 60 then .error "requested projection precision is outside the counted bound 1..60"
 else .ok (LeptonIntervals.normalize 1 (10^places.toNat) (Nat.pow_pos (by decide)))
def expLoop : Nat → Nat → Rat → Rat → Rat → Rat → Except String Value
 | 0,_,_,_,_,_ => .error "exp certificate did not close inside the declared term bound"
 | fuel+1,count,x,total,term,tol => do
  let term ← LeptonRatios.divide (LeptonIntervals.multiply term x) (natural count)
  let total := LeptonIntervals.add total term
  let nextTerm ← LeptonRatios.divide (LeptonIntervals.multiply term x) (natural (count+1))
  if x.blt (natural (count+1)) then
   let ratio ← LeptonRatios.divide x (natural (count+2))
   let tail ← LeptonRatios.divide nextTerm (LeptonIntervals.subtract (natural 1) ratio)
   if !tol.blt tail then
    pure (.interval (← certifiedInterval (← forward total) (← forward (LeptonIntervals.add total tail)) [Text.append "exp-positive-series-terms:" (digits (count+1)),Text.append "geometric-tail:" (fractionText tail)]))
   else expLoop fuel (count+1) x total term tol
  else expLoop fuel (count+1) x total term tol
def expEnclosure (value : Value) (places : Int := 18) (maxTerms : Int := 4096) : Except String Value := do
 let scalar ← CalculatorOperations.requireScalar value
 match scalar with
 | .emptyOne => pure (.interval (CalculatorOperations.asInterval (← forward (natural 1)) "exp-empty-One-identity"))
 | .positive orientation magnitude =>
  let tol ← tolerance places
  let positive ← expLoop maxTerms.toNat 1 (BoundaryGrowth.asFraction magnitude) (natural 1) (natural 1) tol
  match orientation with
  | .forward => pure positive
  | .counter => CalculatorOperations.reciprocal positive
def lnLoop : Nat → Nat → Bool → Rat → Rat → Rat → Rat → Except String Value
 | 0,_,_,_,_,_,_ => .error "ln certificate did not close inside the declared term bound"
 | fuel+1,count,isForward,zSquared,total,power,tol => do
  let total := LeptonIntervals.add total (← LeptonRatios.divide power (natural (2*count+1)))
  let nextPower := LeptonIntervals.multiply power zSquared
  let tail ← LeptonRatios.divide (LeptonIntervals.multiply (natural 2) nextPower) (LeptonIntervals.multiply (natural (2*count+3)) (LeptonIntervals.subtract (natural 1) zSquared))
  if !tol.blt tail then
   let centre := LeptonIntervals.multiply (natural 2) total
   let centreValue ← if isForward then forward centre else counter centre
   let bound ← forward tail
   pure (.interval (← certifiedInterval (FoldScalar.subtract centreValue bound) (FoldScalar.add centreValue bound) [Text.append "ln-atanh-series-terms:" (digits (count+1)),Text.append "positive-tail:" (fractionText tail)]))
  else lnLoop fuel (count+1) isForward zSquared total nextPower tol
def lnEnclosure (value : Value) (places : Int := 18) (maxTerms : Int := 4096) : Except String Value := do
 let scalar ← CalculatorOperations.requireScalar value
 match scalar with
 | .emptyOne => throw "ln requires a forward-held positive magnitude"
 | .positive .counter _ => throw "ln requires a forward-held positive magnitude"
 | .positive .forward magnitude =>
  let x := BoundaryGrowth.asFraction magnitude
  if magnitude.numerator == magnitude.denominator then pure (.interval (CalculatorOperations.asInterval .emptyOne "ln-One-is-empty-One"))
  else
   let isForward := (natural 1).blt x
   let z ← LeptonRatios.divide (if isForward then LeptonIntervals.subtract x (natural 1) else LeptonIntervals.subtract (natural 1) x) (LeptonIntervals.add x (natural 1))
   let tol ← tolerance places
   lnLoop maxTerms.toNat 0 isForward (LeptonIntervals.multiply z z) (natural 0) z tol
def log10Enclosure (value : Value) (places : Int := 18) : Except String Value := do
 CalculatorOperations.divide (← lnEnclosure value (places+4)) (← lnEnclosure (.scalar (← forward (natural 10))) (places+4))
end SFT.Mathematics.CalculatorSeries
