from pathlib import Path
extra=[i for i in range(0x110000) if chr(i).isdigit() and not chr(i).isdecimal()]
s='''import SFT.Mathematics.CalculatorValues
import SFT.Physics.LeptonDecimal
namespace SFT.Mathematics.CalculatorNumerals
open SFT.Host SFT.Physics CalculatorValues
set_option maxRecDepth 100000
-- Python Unicode13 isdigit additionally accepts these characters; int rejects them.
def extraDigitCodes : List Nat := '''+str(extra)+'''
def digitCharacter (c : Char) : Bool := (LeptonDecimal.decimalDigit c).isSome || extraDigitCodes.contains c.toNat
def splitFirst (separator : Char) (cs : List Char) : List Char × Option (List Char) :=
 match cs with
 | [] => ([],none)
 | c::rest => if c == separator then ([],some rest) else
  let pair := splitFirst separator rest
  (c::pair.1,pair.2)
-- CalculatorHalt retains its message. A host int conversion failure is the
-- original ValueError alternative, rather than an added calculator guard.
def parseExactNumber (token : String) : Except String FoldScalar.Scalar := do
 let chars := Text.chars (Text.lowerAscii (String.ofList (LeptonDecimal.strip (Text.chars token))))
 if chars.isEmpty then throw "empty numeric token"
 if chars.head? == some '+' || chars.head? == some '-' then throw "orientation is parsed separately from magnitude"
 let (mantissa,expChars) := splitFirst 'e' chars
 let exponent ← match expChars with
  | none => pure (0 : Int)
  | some cs =>
   if cs.isEmpty || cs == ['+'] || cs == ['-'] then throw "invalid counted exponent"
   else match LeptonDecimal.exponent cs with
    | none => throw "ValueError"
    | some e => pure e
 if (mantissa.filter (fun c => c == '.')).length > 1 then throw "invalid decimal projection"
 let (whole,parts) := splitFirst '.' mantissa
 let whole := if whole.isEmpty then ['0'] else whole
 let parts := parts.getD []
 if !whole.all digitCharacter || !parts.all digitCharacter then throw "numeric input must be generated from decimal digits"
 let digits ← match LeptonDecimal.digits (whole++parts) with
  | none => throw "ValueError"
  | some n => pure n
 match exponent with
 | .ofNat power => forward (LeptonIntervals.normalize (Int.ofNat (digits*10^power)) (10^parts.length) (Nat.pow_pos (by decide)))
 | .negSucc power => forward (LeptonIntervals.normalize (Int.ofNat digits) (10^(parts.length+power+1)) (Nat.pow_pos (by decide)))
end SFT.Mathematics.CalculatorNumerals
'''
for r in [Path('work/constants-recovery'),Path('/Volumes/One Touch/SFT v4 Full model LEAN')]: (r/'SFT/Mathematics/CalculatorNumerals.lean').write_text(s)
print('Retained Unicode13 digit boundary',len(extra))
