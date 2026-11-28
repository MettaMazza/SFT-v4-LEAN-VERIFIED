import SFT.Applications.Discovery.Display
namespace SFT.Applications.Discovery.FloatText
open SFT.Host.Text
open SFT.Applications.Discovery.Display

-- Python's fixed-point report formatting: round the represented binary64
-- value to the nearest decimal quantum, with ties to even, retaining -0.
def fixed (value : Float) (places : Nat) : String :=
 let bits := value.toBits.toNat
 let negative := decide (bits ≥ 9223372036854775808)
 let exponent := bits/4503599627370496%2048
 let significand := bits%4503599627370496
 let sign := if negative then "-" else ""
 if exponent=2047 then
  if significand=0 then append sign "inf" else "nan"
 else
  let significand := if exponent=0 then significand else significand+4503599627370496
  let up := if exponent=0 then 0 else exponent-1075
  let down := if exponent=0 then 1074 else 1075-exponent
  let numerator := significand*2^up*10^places
  let denominator := 2^down
  let quotient := numerator/denominator
  let remainder := numerator%denominator
  let rounded := if 2*remainder>denominator ∨ (2*remainder=denominator ∧ quotient%2=1) then quotient+1 else quotient
  if places=0 then append sign (number (Int.ofNat rounded)) else
  let scale := 10^places
  let whole := number (Int.ofNat (rounded/scale))
  let decimal := number (Int.ofNat (rounded%scale))
  join [sign,whole,".",String.ofList (List.replicate (places-(chars decimal).length) '0'),decimal]
-- Shortest round-trip decimal used by original Python repr / JSON report fields.
-- The search compares exact rationals to the midpoint interval of adjacent binary64 values.
def magnitudeRatio (bits : Nat) : Nat × Nat :=
 let exponent := bits/4503599627370496
 let fraction := bits%4503599627370496
 let mantissa := if exponent=0 then fraction else fraction+4503599627370496
 if exponent=0 then (mantissa,2^1074)
 else (mantissa*2^(exponent-1075),2^(1075-exponent))
def decimalRatio (coefficient : Nat) (power : Int) : Nat × Nat :=
 if power≥0 then (coefficient*10^power.toNat,1) else (coefficient,10^power.natAbs)
def decimalExponent (numerator denominator : Nat) : Int :=
 let estimate := Int.ofNat (chars (number (Int.ofNat numerator))).length-Int.ofNat (chars (number (Int.ofNat denominator))).length
 let scaled := decimalRatio 1 estimate
 if numerator*scaled.2 < denominator*scaled.1 then estimate-1 else estimate
def roundedCoefficient (numerator denominator : Nat) (power : Int) : Nat :=
 let scale := decimalRatio 1 power
 let up := numerator*scale.2
 let down := denominator*scale.1
 let q := up/down
 let rem := up%down
 if 2*rem>down ∨ (2*rem=down ∧ q%2=1) then q+1 else q

def withinRoundingInterval (bits coefficient : Nat) (power : Int) : Bool :=
 let x := magnitudeRatio bits
 let lo := magnitudeRatio (bits-1)
 let hi := magnitudeRatio (bits+1)
 let candidate := decimalRatio coefficient power
 let lowerLeft := 2*candidate.1*x.2*lo.2
 let lowerRight := (x.1*lo.2+lo.1*x.2)*candidate.2
 let upperLeft := 2*candidate.1*x.2*hi.2
 let upperRight := (x.1*hi.2+hi.1*x.2)*candidate.2
 if bits%2=0 then decide (lowerLeft≥lowerRight ∧ upperLeft≤upperRight)
 else decide (lowerLeft>lowerRight ∧ upperLeft<upperRight)

def shortestCoefficient (bits numerator denominator : Nat) (exponent : Int) : Nat → Nat → Nat × Int
 | 0,digits => let power := exponent-Int.ofNat digits+1; (roundedCoefficient numerator denominator power,power)
 | fuel+1,digits =>
  let power := exponent-Int.ofNat digits+1
  let coefficient := roundedCoefficient numerator denominator power
  if withinRoundingInterval bits coefficient power then (coefficient,power)
  else shortestCoefficient bits numerator denominator exponent fuel (digits+1)

def trimCoefficient : Nat → Nat → Int → Nat × Int
 | 0,coefficient,power => (coefficient,power)
 | fuel+1,coefficient,power => if coefficient%10=0 then trimCoefficient fuel (coefficient/10) (power+1) else (coefficient,power)

def repr (value : Float) : String :=
 let raw := value.toBits.toNat
 let negative := decide (raw≥9223372036854775808)
 let bits := raw%9223372036854775808
 let sign := if negative then "-" else ""
 if bits/4503599627370496=2047 then
  if bits%4503599627370496=0 then append sign "inf" else "nan"
 else if bits=0 then append sign "0.0"
 else
  let ratio := magnitudeRatio bits
  let exponent := decimalExponent ratio.1 ratio.2
  let result := shortestCoefficient bits ratio.1 ratio.2 exponent 16 1
  let result := trimCoefficient 17 result.1 result.2
  let digits := chars (number (Int.ofNat result.1))
  let scientificExponent := Int.ofNat digits.length+result.2-1
  if scientificExponent < -4 ∨ scientificExponent≥16 then
   let first := String.ofList (digits.take 1)
   let rest := digits.drop 1
   let exponentDigits := number (Int.ofNat scientificExponent.natAbs)
   join [sign,first,if rest.isEmpty then "" else append "." (String.ofList rest),"e",if scientificExponent<0 then "-" else "+",if (chars exponentDigits).length<2 then "0" else "",exponentDigits]
  else
   let point := Int.ofNat digits.length+result.2
   if point≤0 then join [sign,"0.",String.ofList (List.replicate point.natAbs '0'),String.ofList digits]
   else if point.toNat≥digits.length then join [sign,String.ofList digits,String.ofList (List.replicate (point.toNat-digits.length) '0'),".0"]
   else join [sign,String.ofList (digits.take point.toNat),".",String.ofList (digits.drop point.toNat)]
end SFT.Applications.Discovery.FloatText
