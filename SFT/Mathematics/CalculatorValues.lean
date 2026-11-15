import SFT.Mathematics.FoldScalar
import SFT.Physics.LeptonIntervals
import SFT.Host.Canonical
namespace SFT.Mathematics.CalculatorValues
open SFT.Foundation.ExactOperations SFT.Physics SFT.Host
open FoldScalar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Original values.py: positive magnitudes reuse the established normalized carrier.
def forward (part : Rat) : Except String Scalar :=
 if part.num = 0 then .ok .emptyOne
 else if part.num < 0 then .error "negative host magnitudes are not admitted"
 else if h : 0 < part.num.natAbs then .ok (.positive .forward (normalizePositive part.num.natAbs part.den h (Nat.pos_of_ne_zero part.den_nz)))
 else .error "a Fold magnitude must be an exact positive rational part"
def counter (part : Rat) : Except String Scalar := do
 pure (FoldScalar.reverse (← forward part))
def compareScalar : Scalar → Scalar → Int
 | .emptyOne,.emptyOne => 0
 | .emptyOne,.positive .forward _ => -1
 | .emptyOne,.positive .counter _ => 1
 | .positive .forward _,.emptyOne => 1
 | .positive .counter _,.emptyOne => -1
 | .positive .forward _,.positive .counter _ => 1
 | .positive .counter _,.positive .forward _ => -1
 | .positive .forward x,.positive .forward y =>
   if leftCross x y == rightCross x y then 0 else if rightCross x y < leftCross x y then 1 else -1
 | .positive .counter x,.positive .counter y =>
   if leftCross x y == rightCross x y then 0 else if rightCross x y < leftCross x y then -1 else 1
def reciprocalScalar : Scalar → Except String Scalar
 | .emptyOne => .error "division by structural empty-One is undefined"
 | .positive o x => .ok (.positive o (ExactRatioRelations.reciprocal x))
def divideScalar (left right : Scalar) : Except String Scalar := do
 pure (FoldScalar.multiply left (← reciprocalScalar right))
def scalarToFractionForProjection : Scalar → Rat
 | .emptyOne => LeptonIntervals.zero
 | .positive .forward x => BoundaryGrowth.asFraction x
 | .positive .counter x => LeptonIntervals.normalize (-(Int.ofNat x.numerator)) x.denominator (Nat.pos_of_ne_zero x.denominatorNonzero)
def scalarFromProjection (part : Rat) : Except String Scalar :=
 if part.num = 0 then .ok .emptyOne
 else if part.num > 0 then forward part
 else counter (LeptonIntervals.normalize (-part.num) part.den (Nat.pos_of_ne_zero part.den_nz))
structure CertifiedInterval where
 lower : Scalar
 upper : Scalar
 certificate : List String
structure ComplexFibre where
 real : Scalar
 orthogonal : Scalar
inductive Value where
 | scalar (value : Scalar)
 | interval (value : CertifiedInterval)
 | complex (value : ComplexFibre)
def certifiedInterval (lower upper : Scalar) (certificate : List String) : Except String CertifiedInterval :=
 if compareScalar lower upper > 0 then .error "an enclosure's lower boundary must precede its upper boundary"
 else if certificate.isEmpty then .error "an enclosure requires a replayable exact certificate"
 else .ok ⟨lower,upper,certificate⟩
def exactText : Scalar → String
 | .emptyOne => "empty-One"
 | .positive o x =>
  let heldPrefix := match o with | .forward => "" | .counter => "counter:"
  let numerator := String.ofList (Nat.toDigits 10 x.numerator)
  if x.denominator == 1 then Text.append heldPrefix numerator
  else Text.append heldPrefix (Text.append numerator (Text.append "/" (String.ofList (Nat.toDigits 10 x.denominator))))
end SFT.Mathematics.CalculatorValues
