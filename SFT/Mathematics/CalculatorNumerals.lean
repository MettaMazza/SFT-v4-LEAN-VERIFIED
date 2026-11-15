import SFT.Mathematics.CalculatorValues
import SFT.Physics.LeptonDecimal
namespace SFT.Mathematics.CalculatorNumerals
open SFT.Host SFT.Physics CalculatorValues
set_option maxRecDepth 100000
-- Python Unicode13 isdigit additionally accepts these characters; int rejects them.
def extraDigitCodes : List Nat := [178, 179, 185, 4969, 4970, 4971, 4972, 4973, 4974, 4975, 4976, 4977, 6618, 8304, 8308, 8309, 8310, 8311, 8312, 8313, 8320, 8321, 8322, 8323, 8324, 8325, 8326, 8327, 8328, 8329, 9312, 9313, 9314, 9315, 9316, 9317, 9318, 9319, 9320, 9332, 9333, 9334, 9335, 9336, 9337, 9338, 9339, 9340, 9352, 9353, 9354, 9355, 9356, 9357, 9358, 9359, 9360, 9450, 9461, 9462, 9463, 9464, 9465, 9466, 9467, 9468, 9469, 9471, 10102, 10103, 10104, 10105, 10106, 10107, 10108, 10109, 10110, 10112, 10113, 10114, 10115, 10116, 10117, 10118, 10119, 10120, 10122, 10123, 10124, 10125, 10126, 10127, 10128, 10129, 10130, 68160, 68161, 68162, 68163, 69216, 69217, 69218, 69219, 69220, 69221, 69222, 69223, 69224, 69714, 69715, 69716, 69717, 69718, 69719, 69720, 69721, 69722, 127232, 127233, 127234, 127235, 127236, 127237, 127238, 127239, 127240, 127241, 127242]
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
