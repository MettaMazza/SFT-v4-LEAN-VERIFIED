import SFT.Host.Text
import SFT.Applications.Discovery.Carry
namespace SFT.Applications.Discovery.Display
open SFT.Host.Text
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Carry

def digits : Nat → Nat → List Char
 | 0, _ => []
 | fuel+1, n =>
  let last := Char.ofNat (48+n%10)
  if n < 10 then [last] else digits fuel (n/10)++[last]
def number (n : Int) : String :=
 let text := String.ofList (digits (n.natAbs+1) n.natAbs)
 if n < 0 then append "-" text else text
def fractionText (q : Fraction) : String :=
 if q.denominator = 1 then number q.numerator else join [number q.numerator,"/",number q.denominator]
def familyName : Family → String
 | .standingModes => "standing_modes"
 | .coupling => "coupling"
 | .modeCount => "mode_count"
 | .orbitPeriod => "orbit_period"
 | .tower => "tower"
def verdictName : Verdict → String
 | .noSweep => "NO_SWEEP"
 | .carriesFurther => "CARRIES_FURTHER"
 | .resolvesAtPin => "RESOLVES_AT_PIN"
def hex (s : String) : String :=
 let digit := fun n => Char.ofNat (if n < 10 then 48+n else 87+n)
 String.ofList (s.toUTF8.data.toList.flatMap (fun b => [digit (b.toNat/16),digit (b.toNat%16)]))
def line (s : String) : IO Unit := do
 let out ← IO.getStdout
 out.putStr (append s "\n")
end SFT.Applications.Discovery.Display
