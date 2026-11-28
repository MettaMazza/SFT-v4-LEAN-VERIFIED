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
end SFT.Applications.Discovery.FloatText
