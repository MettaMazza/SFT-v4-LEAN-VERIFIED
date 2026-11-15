import SFT.Mathematics.CalculatorCompleteSession
namespace SFT.Mathematics.CalculatorCompletePresentation
open SFT.Mathematics SFT.Physics SFT.Host CalculatorValues
def friendly (value : Value) (places : Int := 16) : Except String String := do
 match value with
 | .interval v =>
  let lower := scalarToFractionForProjection v.lower
  let upper := scalarToFractionForProjection v.upper
  let midpoint ← scalarFromProjection (← LeptonRatios.divide (LeptonIntervals.add lower upper) (CalculatorSeries.natural 2))
  pure (Text.append "≈ " (← CalculatorProjection.decimalProjection midpoint places))
 | .complex _ => CalculatorProjection.valueText value places
 | .scalar .emptyOne => pure "0"
 | .scalar (.positive orientation magnitude) =>
  if magnitude.denominator == 1 then
   let signText := match orientation with | .forward => "" | .counter => "−"
   pure (Text.append signText (CalculatorRoots.digits magnitude.numerator))
  else CalculatorProjection.decimalProjection (.positive orientation magnitude) places
end SFT.Mathematics.CalculatorCompletePresentation
