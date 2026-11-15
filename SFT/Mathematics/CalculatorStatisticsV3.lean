import SFT.Mathematics.CalculatorOperationsV2
namespace SFT.Mathematics.CalculatorStatisticsV3
open SFT.Physics SFT.Mathematics SFT.Host
open CalculatorValues CalculatorOperations CalculatorRoots CalculatorSeries
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def wholeGcd (left right : Int) : Nat := Nat.gcd left.natAbs right.natAbs
def rootValue (value : Value) (degree : Int) : Except String Value := do
 match value with
 | .scalar _ | .complex _ => nthRoot value degree
 | .interval v =>
  if compareScalar v.lower .emptyOne < 0 then throw "an interval root must remain on one admitted nonnegative branch"
  let lowerRoot ← nthRoot (.scalar v.lower) degree
  let upperRoot ← nthRoot (.scalar v.upper) degree
  match lowerRoot with
  | .complex _ => throw "orthogonal interval roots are outside the declared surface"
  | .scalar _ | .interval _ =>
   match upperRoot with
   | .complex _ => throw "orthogonal interval roots are outside the declared surface"
   | .scalar _ | .interval _ =>
    let (lower,lc) := match lowerRoot with | .scalar x => (x,["exact-lower-root"]) | .interval x => (x.lower,x.certificate) | .complex x => (x.real,[])
    let (upper,uc) := match upperRoot with | .scalar x => (x,["exact-upper-root"]) | .interval x => (x.upper,x.certificate) | .complex x => (x.real,[])
    pure (.interval (← certifiedInterval lower upper (v.certificate ++ lc ++ uc ++ [Text.append "monotone-root-degree:" (Canonical.render (.integer degree))])))
def exactSum (values : List Value) : Except String Value := do
 if values.isEmpty then throw "sum requires at least one generated value"
 values.foldlM add (.scalar .emptyOne)
def exactProduct (values : List Value) : Except String Value := do
 if values.isEmpty then throw "product requires at least one generated value"
 values.foldlM multiply (.scalar (← forward (natural 1)))
def arithmeticMean (values : List Value) : Except String Value := do
 divide (← exactSum values) (.scalar (← forward (natural values.length)))
def populationVariance (values : List Value) : Except String Value := do
 let centre ← arithmeticMean values
 let squares ← values.mapM (fun item => do multiply (← subtract item centre) (← subtract item centre))
 divide (← exactSum squares) (.scalar (← forward (natural values.length)))
def populationStddev (values : List Value) : Except String Value := do
 rootValue (← populationVariance values) 2
def floorValue (value : Value) : Except String FoldScalar.Scalar := do
 match value with
 | .interval v =>
  let a := scalarToFractionForProjection v.lower
  let b := scalarToFractionForProjection v.upper
  let lower ← scalarFromProjection (LeptonIntervals.normalize (a.num / Int.ofNat a.den) 1 (by decide))
  let upper ← scalarFromProjection (LeptonIntervals.normalize (b.num / Int.ofNat b.den) 1 (by decide))
  if ¬ compareScalar lower upper = 0 then throw "floor is not unique across the certified interval"
  pure lower
 | .scalar _ | .complex _ =>
  let p := scalarToFractionForProjection (← requireScalar value)
  scalarFromProjection (LeptonIntervals.normalize (p.num / Int.ofNat p.den) 1 (by decide))
def ceilValue (value : Value) : Except String FoldScalar.Scalar := do
 match value with
 | .interval v =>
  let a := scalarToFractionForProjection v.lower
  let b := scalarToFractionForProjection v.upper
  let lower ← scalarFromProjection (LeptonIntervals.normalize (-((-a.num) / Int.ofNat a.den)) 1 (by decide))
  let upper ← scalarFromProjection (LeptonIntervals.normalize (-((-b.num) / Int.ofNat b.den)) 1 (by decide))
  if ¬ compareScalar lower upper = 0 then throw "ceiling is not unique across the certified interval"
  pure lower
 | .scalar _ | .complex _ =>
  let p := scalarToFractionForProjection (← requireScalar value)
  scalarFromProjection (LeptonIntervals.normalize (-((-p.num) / Int.ofNat p.den)) 1 (by decide))
def gcdValue (left right : Value) : Except String FoldScalar.Scalar := do
 let a := scalarToFractionForProjection (← requireScalar left)
 let b := scalarToFractionForProjection (← requireScalar right)
 if a.den != 1 || b.den != 1 then throw "gcd requires whole counted inputs"
 forward (natural (wholeGcd a.num b.num))
def lcmValue (left right : Value) : Except String FoldScalar.Scalar := do
 let a := scalarToFractionForProjection (← requireScalar left)
 let b := scalarToFractionForProjection (← requireScalar right)
 if a.den != 1 || b.den != 1 then throw "lcm requires whole counted inputs"
 if a.num = 0 ∨ b.num = 0 then pure .emptyOne else
 forward (natural ((a.num*b.num).natAbs / wholeGcd a.num b.num))
def moduloValue (left right : Value) : Except String FoldScalar.Scalar := do
 let a := scalarToFractionForProjection (← requireScalar left)
 let b := scalarToFractionForProjection (← requireScalar right)
 if a.den ≠ 1 ∨ b.den ≠ 1 ∨ b.num = 0 then throw "mod requires whole counts and a non-empty divisor"
 let rem := if b.num < 0 then -((-a.num) % (-b.num)) else a.num % b.num
 scalarFromProjection (LeptonIntervals.normalize rem 1 (by decide))
def goldenRatioEnclosure : Except String Value := do
 let result ← divide (← add (.scalar (← forward (natural 1))) (← nthRoot (.scalar (← forward (natural 5))) 2)) (.scalar (← forward (natural 2)))
 match result with
 | .interval _ => pure result
 | .scalar _ | .complex _ => throw "golden-ratio enclosure construction failed"
end SFT.Mathematics.CalculatorStatisticsV3
