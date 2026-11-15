import SFT.Mathematics.CalculatorOperations
namespace SFT.Mathematics.CalculatorRoots
open SFT.Mathematics SFT.Foundation.ExactOperations SFT.Physics
open CalculatorValues FoldScalar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def digits (n : Nat) : String := String.ofList (Nat.toDigits 10 n)
def fractionText (r : Rat) : String :=
 let n := if r.num < 0 then SFT.Host.Text.append "-" (digits r.num.natAbs) else digits r.num.natAbs
 if r.den == 1 then n else SFT.Host.Text.join [n,"/",digits r.den]
def perfectRootLoop : Nat → Nat → Nat → Nat → Nat → Option Nat
 | 0,_,_,_,_ => none
 | fuel+1,number,degree,low,high =>
  if low > high then none else
  let middle := (low+high)/2
  let powered := middle^degree
  if powered == number then some middle
  else if powered < number then perfectRootLoop fuel number degree (middle+1) high
  else perfectRootLoop fuel number degree low (middle-1)
def perfectRoot (number degree : Nat) : Option Nat :=
 if number == 0 || number == 1 then some number else perfectRootLoop (number+1) number degree 1 number
def ratPower (q : Rat) (degree : Nat) : Rat :=
 LeptonIntervals.normalize (q.num^degree) (q.den^degree) (Nat.pow_pos (Nat.pos_of_ne_zero q.den_nz))
def positiveRoot (magnitude : PositiveFraction) (degree : Nat) (depth : Int) : Except String Value := do
 let numerator := perfectRoot magnitude.numerator degree
 let denominator := perfectRoot magnitude.denominator degree
 match numerator with
 | none =>
  let target := BoundaryGrowth.asFraction magnitude
  let one := LeptonIntervals.normalize 1 1 (by decide)
  let initialUpper := if target.blt one then one else target
  let bracket := (List.range depth.toNat).foldl (fun (lower,upper) _ =>
   let midpoint := LeptonIntervals.midpoint lower upper
   if (ratPower midpoint degree).blt target then (midpoint,upper) else (lower,midpoint)) (LeptonIntervals.zero,initialUpper)
  let certificate := [SFT.Host.Text.join ["positive-polynomial-balance:x^",digits degree,"=target"],SFT.Host.Text.append "generated-bisection-depth:" (SFT.Host.Canonical.render (.integer depth)),SFT.Host.Text.append "lower-power:" (fractionText (ratPower bracket.1 degree)),SFT.Host.Text.append "upper-power:" (fractionText (ratPower bracket.2 degree))]
  pure (.interval (← certifiedInterval (← forward bracket.1) (← forward bracket.2) certificate))
 | some n =>
  match denominator with
  | some d =>
   if h : 0 < d then pure (.scalar (← forward (LeptonIntervals.normalize (Int.ofNat n) d h)))
   else throw "Fraction(1, 0)"
  | none =>
   let target := BoundaryGrowth.asFraction magnitude
   let one := LeptonIntervals.normalize 1 1 (by decide)
   let initialUpper := if target.blt one then one else target
   let bracket := (List.range depth.toNat).foldl (fun (lower,upper) _ =>
    let midpoint := LeptonIntervals.midpoint lower upper
    if (ratPower midpoint degree).blt target then (midpoint,upper) else (lower,midpoint)) (LeptonIntervals.zero,initialUpper)
   let certificate := [SFT.Host.Text.join ["positive-polynomial-balance:x^",digits degree,"=target"],SFT.Host.Text.append "generated-bisection-depth:" (SFT.Host.Canonical.render (.integer depth)),SFT.Host.Text.append "lower-power:" (fractionText (ratPower bracket.1 degree)),SFT.Host.Text.append "upper-power:" (fractionText (ratPower bracket.2 degree))]
   pure (.interval (← certifiedInterval (← forward bracket.1) (← forward bracket.2) certificate))

def nthRoot (value : Value) (degree : Int) (depth : Int := 80) : Except String Value := do
 let scalar ← CalculatorOperations.requireScalar value
 if degree < 1 then throw "root degree must be a positive count"
 match scalar with
 | .emptyOne => pure (.scalar .emptyOne)
 | .positive orientation magnitude =>
  let rooted ← positiveRoot magnitude degree.toNat depth
  match orientation,rooted with
  | .forward,_ => pure rooted
  | .counter,.scalar x =>
   if degree % 2 = 0 then pure (.complex ⟨.emptyOne,x⟩) else pure (.scalar (FoldScalar.reverse x))
  | .counter,.interval x =>
   if degree % 2 = 0 then throw "a non-exact orthogonal root requires a paired enclosure not admitted by this operation"
   else pure (.interval (← certifiedInterval (FoldScalar.reverse x.upper) (FoldScalar.reverse x.lower) (x.certificate ++ ["odd-held-orientation"])))
  | .counter,.complex _ => throw "a non-exact orthogonal root requires a paired enclosure not admitted by this operation"
def absolute (value : Value) : Except String Value := match value with
 | .complex x => nthRoot (.scalar (FoldScalar.add (FoldScalar.multiply x.real x.real) (FoldScalar.multiply x.orthogonal x.orthogonal))) 2
 | .interval x => do
  if compareScalar x.lower .emptyOne <= 0 && compareScalar x.upper .emptyOne >= 0 then
   let reversed := FoldScalar.reverse x.lower
   let far := if compareScalar reversed x.upper >= 0 then reversed else x.upper
   pure (.interval (← certifiedInterval .emptyOne far (x.certificate ++ ["absolute-enclosure"])))
  else if compareScalar x.upper .emptyOne < 0 then CalculatorOperations.negate value
  else pure value
 | .scalar .emptyOne => pure value
 | .scalar (.positive .forward _) => pure value
 | .scalar (.positive .counter x) => pure (.scalar (.positive .forward x))
end SFT.Mathematics.CalculatorRoots
