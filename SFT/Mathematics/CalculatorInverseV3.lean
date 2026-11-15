import SFT.Mathematics.CalculatorFunctionsV3
namespace SFT.Mathematics.CalculatorInverseV3
open SFT.Physics SFT.Mathematics SFT.Host
open CalculatorValues CalculatorOperations CalculatorRoots CalculatorSeries CalculatorTrigonometry
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def atanSmallLoop : Nat → Nat → Rat → Rat → Rat → Rat → Except String Value
 | 0,_,_,_,_,_ => .error "arctangent certificate did not close inside the declared term bound"
 | fuel+1,index,magnitude,tolerance,positive,held => do
  let term ← LeptonRatios.divide (ratPower magnitude (2*index+1)) (natural (2*index+1))
  let positive := if index % 2 == 1 then positive else LeptonIntervals.add positive term
  let held := if index % 2 == 1 then LeptonIntervals.add held term else held
  let nextTerm ← LeptonRatios.divide (ratPower magnitude (2*index+3)) (natural (2*index+3))
  if !(tolerance.blt nextTerm) then
   let partialSum := LeptonIntervals.subtract positive held
   let count := index+1
   let (lower,upper) := if count % 2 == 1 then (LeptonIntervals.subtract partialSum nextTerm,partialSum) else (partialSum,LeptonIntervals.add partialSum nextTerm)
   pure (.interval (← certifiedInterval (← forward lower) (← forward upper) [Text.append "atan-small-terms:" (digits count),Text.append "next-term-bound:" (fractionText nextTerm),"parity-checked:v3"]))
  else atanSmallLoop fuel (index+1) magnitude tolerance positive held
def atanSmall (value : FoldScalar.Scalar) (places : Int) (maxTerms : Int := 4096) : Except String Value := do
 match value with
 | .emptyOne => pure (.interval (asInterval .emptyOne "atan-empty-One"))
 | .positive held m =>
  let magnitude := BoundaryGrowth.asFraction m
  if (LeptonIntervals.normalize 1 2 (by decide)).blt magnitude then throw "internal arctangent recurrence requires magnitude at most half-One"
  let tolerance ← CalculatorSeries.tolerance places
  let result ← atanSmallLoop maxTerms.toNat 0 magnitude tolerance (natural 0) (natural 0)
  match held with
  | .forward => pure result
  | .counter => negate result
-- The source's forward scalar branch at magnitude at most One.
def atanUnit (scalar : FoldScalar.Scalar) (places : Int) : Except String Value := do
 let x := scalarToFractionForProjection scalar
 let pi ← CalculatorOperationsV2.circleConstantEnclosure (max 24 (places+8))
 if !((LeptonIntervals.normalize 1 2 (by decide)).blt x) then atanSmall scalar places
 else
  let transformed ← if x.blt (natural 1) then counter (← LeptonRatios.divide (LeptonIntervals.subtract (natural 1) x) (LeptonIntervals.add (natural 1) x)) else pure .emptyOne
  let result ← add (← divide pi (.scalar (← forward (natural 4)))) (← atanSmall transformed (places+4))
  match result with
  | .interval _ => pure result
  | .scalar _ | .complex _ => throw "arctangent enclosure construction failed"
def atanScalar (scalar : FoldScalar.Scalar) (places : Int) : Except String Value := do
 match scalar with
 | .emptyOne => pure (.interval (asInterval .emptyOne "atan-empty-One"))
 | .positive orientation m =>
  let positive := FoldScalar.Scalar.positive .forward m
  let x := BoundaryGrowth.asFraction m
  let result ← if !(natural 1).blt x then atanUnit positive places else do
   let pi ← CalculatorOperationsV2.circleConstantEnclosure (max 24 (places+8))
   let reciprocal ← forward (← LeptonRatios.divide (natural 1) x)
   let result ← subtract (← divide pi (.scalar (← forward (natural 2)))) (← atanUnit reciprocal (places+4))
   match result with
   | .interval _ => pure result
   | .scalar _ | .complex _ => throw "arctangent enclosure construction failed"
  match orientation with
  | .forward => pure result
  | .counter => negate result
def atanValue (value : Value) (places : Int := 18) : Except String Value := do
 match value with
 | .scalar _ | .complex _ => atanScalar (← requireScalar value) places
 | .interval v =>
  let left ← toInterval (← atanScalar v.lower places)
  let right ← toInterval (← atanScalar v.upper places)
  pure (.interval (← certifiedInterval left.lower right.upper (v.certificate ++ left.certificate ++ right.certificate ++ ["monotone-atan-interval"])))
def asinValue (value : Value) (places : Int := 18) : Except String Value := do
 let scalar ← requireScalar value
 match scalar with
 | .emptyOne => pure (.interval (asInterval .emptyOne "asin-empty-One"))
 | .positive orientation m =>
  if m.numerator > m.denominator then throw "asin requires a magnitude no greater than One"
  if m.numerator == m.denominator then
   let halfPi ← divide (← CalculatorOperationsV2.circleConstantEnclosure (max 24 (places+8))) (.scalar (← forward (natural 2)))
   match orientation with
   | .forward => pure halfPi
   | .counter => negate halfPi
  else
   let square ← multiply (.scalar scalar) (.scalar scalar)
   let denominator ← nthRoot (← subtract (.scalar (← forward (natural 1))) square) 2
   atanValue (← divide (.scalar scalar) denominator) places
def acosValue (value : Value) (places : Int := 18) : Except String Value := do
 let result ← subtract (← divide (← CalculatorOperationsV2.circleConstantEnclosure (max 24 (places+8))) (.scalar (← forward (natural 2)))) (← asinValue value (places+4))
 match result with
 | .interval _ => pure result
 | .scalar _ | .complex _ => throw "acos enclosure construction failed"
end SFT.Mathematics.CalculatorInverseV3
