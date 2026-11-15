import SFT.Mathematics.CalculatorValues
namespace SFT.Mathematics.CalculatorOperations
open SFT.Foundation.ExactOperations SFT.Physics
open CalculatorValues FoldScalar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def asInterval (v : Scalar) (reason : String := "exact-degenerate-enclosure") : CertifiedInterval := ⟨v,v,[reason]⟩
def requireScalar : Value → Except String Scalar
 | .scalar v => .ok v
 | .interval _ | .complex _ => .error "operation requires one exact Fold scalar"
def toComplex (v : Value) : Except String ComplexFibre := match v with
 | .complex x => .ok x
 | .scalar x => .ok ⟨x,.emptyOne⟩
 | .interval _ => .error "operation requires one exact Fold scalar"
def toInterval (v : Value) : Except String CertifiedInterval := match v with
 | .interval x => .ok x
 | .scalar x => .ok (asInterval x)
 | .complex _ => .error "operation requires one exact Fold scalar"
def isComplex : Value → Bool | .complex _ => true | .scalar _ | .interval _ => false
def isInterval : Value → Bool | .interval _ => true | .scalar _ | .complex _ => false
def add (left right : Value) : Except String Value := do
 if isComplex left || isComplex right then
  let a ← toComplex left
  let b ← toComplex right
  pure (.complex ⟨FoldScalar.add a.real b.real,FoldScalar.add a.orthogonal b.orthogonal⟩)
 else if isInterval left || isInterval right then
  let a ← toInterval left
  let b ← toInterval right
  pure (.interval (← certifiedInterval (FoldScalar.add a.lower b.lower) (FoldScalar.add a.upper b.upper) (a.certificate ++ b.certificate ++ ["endpoint-addition"])))
 else pure (.scalar (FoldScalar.add (← requireScalar left) (← requireScalar right)))
def negate : Value → Except String Value
 | .scalar v => .ok (.scalar (FoldScalar.reverse v))
 | .complex v => .ok (.complex ⟨FoldScalar.reverse v.real,FoldScalar.reverse v.orthogonal⟩)
 | .interval v => do pure (.interval (← certifiedInterval (FoldScalar.reverse v.upper) (FoldScalar.reverse v.lower) (v.certificate ++ ["held-orientation-reversal"])))
def subtract (left right : Value) : Except String Value := do add left (← negate right)
def multiply (left right : Value) : Except String Value := do
 if isComplex left || isComplex right then
  let a ← toComplex left
  let b ← toComplex right
  pure (.complex ⟨FoldScalar.subtract (FoldScalar.multiply a.real b.real) (FoldScalar.multiply a.orthogonal b.orthogonal),FoldScalar.add (FoldScalar.multiply a.real b.orthogonal) (FoldScalar.multiply a.orthogonal b.real)⟩)
 else if isInterval left || isInterval right then
  let a ← toInterval left
  let b ← toInterval right
  let first := FoldScalar.multiply a.lower b.lower
  let rest := [FoldScalar.multiply a.lower b.upper,FoldScalar.multiply a.upper b.lower,FoldScalar.multiply a.upper b.upper]
  let lower := rest.foldl (fun x y => if compareScalar y x < 0 then y else x) first
  let upper := rest.foldl (fun x y => if compareScalar y x > 0 then y else x) first
  pure (.interval (← certifiedInterval lower upper (a.certificate ++ b.certificate ++ ["four-endpoint-product"])))
 else pure (.scalar (FoldScalar.multiply (← requireScalar left) (← requireScalar right)))
def reciprocal : Value → Except String Value
 | .scalar v => do pure (.scalar (← reciprocalScalar v))
 | .complex v => do
  let denominator := FoldScalar.add (FoldScalar.multiply v.real v.real) (FoldScalar.multiply v.orthogonal v.orthogonal)
  pure (.complex ⟨← divideScalar v.real denominator,← divideScalar (FoldScalar.reverse v.orthogonal) denominator⟩)
 | .interval v => do
  if compareScalar v.lower .emptyOne <= 0 && compareScalar v.upper .emptyOne >= 0 then
   throw "an interval crossing empty-One has no single reciprocal enclosure"
  pure (.interval (← certifiedInterval (← reciprocalScalar v.upper) (← reciprocalScalar v.lower) (v.certificate ++ ["reciprocal-endpoint-reversal"])))
def divide (left right : Value) : Except String Value := do multiply left (← reciprocal right)
def requireWhole (value : Value) (allowEmpty : Bool := true) : Except String Nat := do
 let scalar ← requireScalar value
 match scalar with
 | .emptyOne => if allowEmpty then pure 0 else throw "operation requires a positive whole count"
 | .positive .counter _ => throw "operation requires a forward-held whole count"
 | .positive .forward x =>
  if x.denominator != 1 then throw "operation requires a forward-held whole count"
  pure x.numerator
def wholePowerLoop : Nat → Nat → Value → Value → Except String Value
 | 0,_,_,_ => .error "unreachable counted power boundary"
 | fuel+1,count,result,factor => do
  if count == 0 then pure result
  else
   let result ← if count % 2 == 1 then multiply result factor else pure result
   let remaining := count / 2
   if remaining == 0 then pure result else
    wholePowerLoop fuel remaining result (← multiply factor factor)
def wholePower (base exponent : Value) : Except String Value := do
 let scalar ← requireScalar exponent
 let one := Value.scalar (← forward (LeptonIntervals.normalize 1 1 (by decide)))
 match scalar with
 | .emptyOne => pure one
 | .positive held magnitude =>
  if magnitude.denominator != 1 then throw "power requires a whole counted exponent"
  let result ← wholePowerLoop (magnitude.numerator+1) magnitude.numerator one base
  match held with
  | .forward => pure result
  | .counter => reciprocal result
def factorial (value : Value) : Except String Scalar := do
 let count ← requireWhole value
 let product := (List.range (count-1)).foldl (fun held i => held*(i+2)) 1
 forward (LeptonIntervals.normalize (Int.ofNat product) 1 (by decide))
def permutation (total held : Value) : Except String Scalar := do
 let n ← requireWhole total
 let r ← requireWhole held
 if r > n then throw "held selection cannot exceed generated support"
 let product := (List.range r).foldl (fun held i => held*(n-r+1+i)) 1
 forward (LeptonIntervals.normalize (Int.ofNat product) 1 (by decide))
def combination (total held : Value) : Except String Scalar := do
 let n ← requireWhole total
 let r ← requireWhole held
 if r > n then throw "held selection cannot exceed generated support"
 let selected := min r (n-r)
 let result ← (List.range selected).foldlM (fun held i => do
  let numerator ← forward (LeptonIntervals.normalize (Int.ofNat (n-selected+i+1)) 1 (by decide))
  let denominator ← forward (LeptonIntervals.normalize (Int.ofNat (i+1)) 1 (by decide))
  divideScalar (FoldScalar.multiply held numerator) denominator)
  (← forward (LeptonIntervals.normalize 1 1 (by decide)))
 pure result
def conjugate : Value → Value
 | .complex v => .complex ⟨v.real,FoldScalar.reverse v.orthogonal⟩
 | .scalar v => .scalar v
 | .interval v => .interval v
end SFT.Mathematics.CalculatorOperations
