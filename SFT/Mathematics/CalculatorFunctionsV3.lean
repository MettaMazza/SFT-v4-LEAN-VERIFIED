import SFT.Mathematics.CalculatorStatisticsV3
namespace SFT.Mathematics.CalculatorFunctionsV3
open SFT.Physics SFT.Mathematics SFT.Host
open CalculatorValues CalculatorOperations CalculatorRoots CalculatorSeries CalculatorTrigonometry
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def expValue (value : Value) (places : Int := 18) : Except String Value := do
 match value with
 | .scalar _ => expEnclosure value places
 | .complex _ => throw "complex exponential is outside the declared two-fibre scientific surface"
 | .interval v =>
  let lower ← expEnclosure (.scalar v.lower) places
  let upper ← expEnclosure (.scalar v.upper) places
  let a ← toInterval lower
  let b ← toInterval upper
  pure (.interval (← certifiedInterval a.lower b.upper (v.certificate ++ a.certificate ++ b.certificate ++ ["monotone-exp-interval"])))
def lnValue (value : Value) (places : Int := 18) : Except String Value := do
 match value with
 | .scalar _ => lnEnclosure value places
 | .complex _ => throw "complex logarithm is outside the declared two-fibre scientific surface"
 | .interval v =>
  if compareScalar v.lower .emptyOne <= 0 then throw "ln interval must remain strictly forward-held"
  let lower ← lnEnclosure (.scalar v.lower) places
  let upper ← lnEnclosure (.scalar v.upper) places
  let a ← toInterval lower
  let b ← toInterval upper
  pure (.interval (← certifiedInterval a.lower b.upper (v.certificate ++ a.certificate ++ b.certificate ++ ["monotone-ln-interval"])))
def rationalPower (base exponent : Value) (places : Int := 18) : Except String Value := do
 if isComplex exponent then throw "orthogonal-fibre exponents are outside the declared scientific surface"
 if isInterval exponent || isInterval base then
  let baseInterval ← toInterval base
  if compareScalar baseInterval.lower .emptyOne <= 0 then throw "a non-rational exponent requires a strictly forward-held base enclosure"
  expValue (← multiply exponent (← lnValue (.interval baseInterval) (places+6))) places
 else
  let power ← requireScalar exponent
  match power with
  | .emptyOne => pure (.scalar (← forward (natural 1)))
  | .positive held magnitude =>
   let rooted ← nthRoot base (Int.ofNat magnitude.denominator)
   let result ← wholePower rooted (.scalar (← forward (natural magnitude.numerator)))
   match held with
   | .forward => pure result
   | .counter => reciprocal result
def logBase (value base : Value) (places : Int := 18) : Except String Value := do
 let scalar ← requireScalar base
 if compareScalar scalar .emptyOne ≤ 0 ∨ compareScalar scalar (← forward (natural 1)) = 0 then throw "logarithm base must be positive and distinct from One"
 let result ← divide (← lnValue value (places+5)) (← lnValue base (places+5))
 match result with
 | .interval _ => pure result
 | .scalar _ | .complex _ => throw "logarithm enclosure construction failed"
def trigInterval (value : CertifiedInterval) (cosine : Bool) (places : Int) : Except String Value := do
 let lowerFraction := scalarToFractionForProjection value.lower
 let upperFraction := scalarToFractionForProjection value.upper
 let midpoint ← LeptonRatios.divide (LeptonIntervals.add lowerFraction upperFraction) (natural 2)
 let radius ← LeptonRatios.divide (LeptonIntervals.subtract upperFraction lowerFraction) (natural 2)
 let centre := Value.scalar (← scalarFromProjection midpoint)
 let centreInterval ← toInterval (← if cosine then cosEnclosure centre (places+4) else sinEnclosure centre (places+4))
 let lower ← subtract (.scalar centreInterval.lower) (.scalar (← forward radius))
 let upper ← add (.scalar centreInterval.upper) (.scalar (← forward radius))
 match lower with
 | .complex _ | .interval _ => throw "trigonometric interval expansion failed"
 | .scalar a =>
  match upper with
  | .complex _ | .interval _ => throw "trigonometric interval expansion failed"
  | .scalar b => pure (.interval (← certifiedInterval a b (value.certificate ++ centreInterval.certificate ++ ["unit-derivative-Lipschitz-enclosure"])))
def sinValue (value : Value) (places : Int := 18) : Except String Value := do
 match value with
 | .interval x => trigInterval x false places
 | .scalar _ | .complex _ => sinEnclosure (.scalar (← requireScalar value)) places
def cosValue (value : Value) (places : Int := 18) : Except String Value := do
 match value with
 | .interval x => trigInterval x true places
 | .scalar _ | .complex _ => cosEnclosure (.scalar (← requireScalar value)) places
def tanValue (value : Value) (places : Int := 18) : Except String Value := do
 let result ← divide (← sinValue value (places+4)) (← cosValue value (places+4))
 match result with
 | .interval _ => pure result
 | .scalar _ | .complex _ => throw "tangent enclosure construction failed"
def toRadians (value : Value) (mode : String) : Except String Value := do
 if mode == "rad" then pure value
 else if mode == "deg" then divide (← multiply value (← CalculatorOperationsV2.circleConstantEnclosure)) (.scalar (← forward (natural 180)))
 else if mode == "grad" then divide (← multiply value (← CalculatorOperationsV2.circleConstantEnclosure)) (.scalar (← forward (natural 200)))
 else throw "angle mode must be rad, deg or grad"
def fromRadians (value : Value) (mode : String) : Except String Value := do
 if mode == "rad" then pure value
 else if mode == "deg" then divide (← multiply value (.scalar (← forward (natural 180)))) (← CalculatorOperationsV2.circleConstantEnclosure)
 else if mode == "grad" then divide (← multiply value (.scalar (← forward (natural 200)))) (← CalculatorOperationsV2.circleConstantEnclosure)
 else throw "angle mode must be rad, deg or grad"
def sinhValue (value : Value) (places : Int := 18) : Except String Value := do
 let result ← divide (← subtract (← expValue value (places+4)) (← expValue (← negate value) (places+4))) (.scalar (← forward (natural 2)))
 match result with
 | .interval _ => pure result
 | .scalar _ | .complex _ => throw "sinh enclosure construction failed"
def coshValue (value : Value) (places : Int := 18) : Except String Value := do
 let result ← divide (← add (← expValue value (places+4)) (← expValue (← negate value) (places+4))) (.scalar (← forward (natural 2)))
 match result with
 | .interval _ => pure result
 | .scalar _ | .complex _ => throw "cosh enclosure construction failed"
def tanhValue (value : Value) (places : Int := 18) : Except String Value := do
 let result ← divide (← sinhValue value (places+4)) (← coshValue value (places+4))
 match result with
 | .interval _ => pure result
 | .scalar _ | .complex _ => throw "tanh enclosure construction failed"
def asinhValue (value : Value) (places : Int := 18) : Except String Value := do
 let scalar ← requireScalar value
 let positive := match scalar with | .positive .counter m => FoldScalar.Scalar.positive .forward m | .emptyOne => .emptyOne | .positive .forward m => .positive .forward m
 let v := Value.scalar positive
 let result ← lnValue (← add v (← nthRoot (← add (← multiply v v) (.scalar (← forward (natural 1)))) 2)) places
 match scalar with
 | .positive .counter _ => negate result
 | .emptyOne | .positive .forward _ => pure result
def acoshValue (value : Value) (places : Int := 18) : Except String Value := do
 let scalar ← requireScalar value
 if compareScalar scalar (← forward (natural 1)) < 0 then throw "acosh requires a forward-held magnitude at least One"
 let v := Value.scalar scalar
 lnValue (← add v (← nthRoot (← subtract (← multiply v v) (.scalar (← forward (natural 1)))) 2)) places
def atanhValue (value : Value) (places : Int := 18) : Except String Value := do
 let scalar ← requireScalar value
 match scalar with
 | .positive _ m => if m.numerator >= m.denominator then throw "atanh requires magnitude strictly below One"
 | .emptyOne => pure ()
 let v := Value.scalar scalar
 let one := Value.scalar (← forward (natural 1))
 let ratio ← divide (← add one v) (← subtract one v)
 let result ← divide (← lnValue ratio (places+4)) (.scalar (← forward (natural 2)))
 match result with
 | .interval _ => pure result
 | .scalar _ | .complex _ => throw "atanh enclosure construction failed"
end SFT.Mathematics.CalculatorFunctionsV3
