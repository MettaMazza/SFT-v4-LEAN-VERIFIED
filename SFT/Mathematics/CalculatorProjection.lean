import SFT.Mathematics.CalculatorRoots
namespace SFT.Mathematics.CalculatorProjection
open SFT.Host SFT.Mathematics CalculatorValues CalculatorRoots
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Original Decimal boundary: exact integer division, ROUND_HALF_EVEN,
-- context precision places+8 followed by significant-digit format precision.
def digitCount (n : Nat) : Nat := (Nat.toDigits 10 n).length
def adjustedExponent (n d : Nat) : Int :=
 let e := Int.ofNat (digitCount n) - Int.ofNat (digitCount d)
 if e < 0 then if n*10^e.natAbs < d then e-1 else e
 else if n < d*10^e.toNat then e-1 else e
def roundQuotient (n d : Nat) : Nat :=
 let q := n/d
 let r := n%d
 if 2*r > d || (2*r == d && q%2 == 1) then q+1 else q
structure DecimalValue where
 coefficient : Nat
 exponent : Int
def stripExact : Nat → DecimalValue → DecimalValue
 | 0,v => v
 | fuel+1,v =>
  if v.exponent < 0 && v.coefficient != 0 && v.coefficient%10 == 0 then
   stripExact fuel ⟨v.coefficient/10,v.exponent+1⟩
  else v
def contextDivision (n d precision : Nat) : Except String DecimalValue := do
 let adjusted := adjustedExponent n d
 let desired := adjusted - Int.ofNat precision + 1
 let tiny := (-999999 : Int) - Int.ofNat precision + 1
 let exponent := if desired < tiny then tiny else desired
 let numerator := if exponent < 0 then n*10^exponent.natAbs else n
 let denominator := if exponent < 0 then d else d*10^exponent.toNat
 let coefficient := roundQuotient numerator denominator
 let exact := numerator%denominator == 0
 let value := if exact then stripExact (digitCount coefficient) ⟨coefficient,exponent⟩ else ⟨coefficient,exponent⟩
 let value := if digitCount value.coefficient > precision then ⟨value.coefficient/10,value.exponent+1⟩ else value
 if value.coefficient != 0 && value.exponent + Int.ofNat (digitCount value.coefficient) - 1 > 999999 then throw "Overflow"
 pure value
def roundedFormat (value : DecimalValue) (precision : Nat) : DecimalValue :=
 let length := digitCount value.coefficient
 if length <= precision then value else
 let shift := length-precision
 let coefficient := roundQuotient value.coefficient (10^shift)
 let exponent := value.exponent+Int.ofNat shift
 if digitCount coefficient > precision then ⟨coefficient/10,exponent+1⟩ else ⟨coefficient,exponent⟩
def exponentText (e : Int) : String :=
 if e < 0 then Text.append "-" (digits e.natAbs) else Text.append "+" (digits e.toNat)
def formatGeneral (value : DecimalValue) : String :=
 let chars := Nat.toDigits 10 value.coefficient
 let length := chars.length
 let adjusted := value.exponent+Int.ofNat length-1
 if value.exponent > 0 || adjusted < -6 then
  let mantissa := if length == 1 then String.ofList chars else Text.join [String.ofList (chars.take 1),".",String.ofList (chars.drop 1)]
  Text.join [mantissa,"e",exponentText adjusted]
 else if value.exponent = 0 then String.ofList chars
 else
  let position := Int.ofNat length+value.exponent
  if position > 0 then Text.join [String.ofList (chars.take position.toNat),".",String.ofList (chars.drop position.toNat)]
  else Text.join ["0.",String.ofList (List.replicate position.natAbs '0'),String.ofList chars]
def decimalProjection (value : FoldScalar.Scalar) (places : Int := 18) : Except String String := do
 match value with
 | .emptyOne => pure "0"
 | .positive orientation magnitude =>
  if places+8 < 1 || places+8 > 999999999999999999 then throw "ValueError"
  let decimal ← contextDivision magnitude.numerator magnitude.denominator (places+8).toNat
  if places < 0 then throw "ValueError"
  let formatted := formatGeneral (roundedFormat decimal (max 1 places.toNat))
  match orientation with
  | .forward => pure formatted
  | .counter => pure (Text.append "-" formatted)
def valueText (value : Value) (places : Int := 18) : Except String String := do
 match value with
 | .interval interval =>
  if compareScalar interval.lower interval.upper = 0 then pure (exactText interval.lower)
  else pure (Text.join ["[",exactText interval.lower,", ",exactText interval.upper,"] ≈ [",← decimalProjection interval.lower places,", ",← decimalProjection interval.upper places,"]"])
 | .complex fibre => pure (Text.join ["fibre(real=",exactText fibre.real,", orthogonal=",exactText fibre.orthogonal,")"])
 | .scalar scalar =>
  let exact := exactText scalar
  let projected ← decimalProjection scalar places
  pure (if Text.equal exact projected then exact else Text.join [exact," ≈ ",projected])
end SFT.Mathematics.CalculatorProjection
