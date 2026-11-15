import SFT.Mathematics.CalculatorFunctionsV3
namespace SFT.Mathematics.CalculatorCompleteOperations
open SFT.Physics SFT.Mathematics SFT.Host
open CalculatorValues CalculatorOperations CalculatorSeries
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def nearestWhole (value : Rat) : Int :=
 let whole := (2*value.num.natAbs+value.den)/(2*value.den)
 if value.num < 0 then -(Int.ofNat whole) else Int.ofNat whole
def intervalWidth (value : CertifiedInterval) : Rat :=
 LeptonIntervals.subtract (scalarToFractionForProjection value.upper) (scalarToFractionForProjection value.lower)
def circleLoop : Nat → Int → Int → Rat → Except String CertifiedInterval
 | 0,_,_,_ => .error "periodic-reduction certificate exhausted its counted term bound"
 | fuel+1,terms,turns,target => do
   if terms > 512 then throw "periodic-reduction certificate exhausted its counted term bound"
   let circle ← toInterval (← CalculatorOperationsV2.circleConstantEnclosure terms)
   let width := LeptonIntervals.multiply (natural (turns.natAbs*2)) (intervalWidth circle)
   if !target.blt width then pure circle
   else circleLoop fuel (terms*2) turns target
def circleForTurns (turns places : Int) : Except String CertifiedInterval := do
 let terms := if places+8 < 32 then 32 else places+8
 if places+6 < 0 then throw "both arguments should be Rational instances"
 let target := LeptonIntervals.normalize 1 (10^(places+6).toNat) (Nat.pow_pos (by decide))
 circleLoop 6 terms turns target
def periodicReduce (value : Value) (places : Int := 18) : Except String CertifiedInterval := do
 let source ← match value with
  | .complex _ => throw "circular functions require one real Fold fibre"
  | .interval x => pure x
  | .scalar x => pure (asInterval x)
 let lower := scalarToFractionForProjection source.lower
 let upper := scalarToFractionForProjection source.upper
 let midpoint ← LeptonRatios.divide (LeptonIntervals.add lower upper) (natural 2)
 let initialCircle ← toInterval (← CalculatorOperationsV2.circleConstantEnclosure 32)
 let circleMidpoint ← LeptonRatios.divide (LeptonIntervals.add (scalarToFractionForProjection initialCircle.lower) (scalarToFractionForProjection initialCircle.upper)) (natural 2)
 let turns := nearestWhole (← LeptonRatios.divide midpoint (LeptonIntervals.multiply (natural 2) circleMidpoint))
 let circle ← circleForTurns turns places
 let translation ← multiply (.scalar (← scalarFromProjection (LeptonIntervals.normalize (2*turns) 1 (by decide)))) (.interval circle)
 let reduced ← subtract (.interval source) translation
 match reduced with
 | .scalar _ => throw "periodic reduction did not retain an exact enclosure"
 | .complex _ => throw "periodic reduction did not retain an exact enclosure"
 | .interval reduced => certifiedInterval reduced.lower reduced.upper (reduced.certificate ++ [Text.append "whole-turn-translation:" (Canonical.render (.integer turns)),"periodic-identity:angle-minus-whole-times-two-circle"])
def sinValue (value : Value) (places : Int := 18) : Except String Value := do
 CalculatorFunctionsV3.sinValue (.interval (← periodicReduce value places)) places
def cosValue (value : Value) (places : Int := 18) : Except String Value := do
 CalculatorFunctionsV3.cosValue (.interval (← periodicReduce value places)) places
def tanValue (value : Value) (places : Int := 18) : Except String Value := do
 let result ← divide (← sinValue value (places+4)) (← cosValue value (places+4))
 match result with
 | .interval _ => pure result
 | .scalar _ => throw "tangent enclosure construction failed"
 | .complex _ => throw "tangent enclosure construction failed"
end SFT.Mathematics.CalculatorCompleteOperations
