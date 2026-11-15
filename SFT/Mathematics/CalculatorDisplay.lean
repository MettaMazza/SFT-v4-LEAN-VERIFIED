import SFT.Mathematics.CalculatorSession
namespace SFT.Mathematics.CalculatorDisplay
open SFT.Mathematics SFT.Physics SFT.Host CalculatorValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def buttonRows : List (List String) := [["MC","MR","M+","M−","MS","C","⌫"],["sin","cos","tan","asin","acos","atan"],["sinh","cosh","tanh","ln","log","log₂"],["exp","10ˣ","cbrt","floor","ceil","mod"],["π","e","φ","x²","xʸ","√"],["n!","nCr","nPr","1/x","|x|","%"],["(",")","7","8","9","÷"],["gcd","lcm","4","5","6","×"],["mean","σ","1","2","3","−"],["Ans","±","0",".","=","+"]]
def insertions : List (String × String) := [("sin","sin("),("cos","cos("),("tan","tan("),("asin","asin("),("acos","acos("),("atan","atan("),("sinh","sinh("),("cosh","cosh("),("tanh","tanh("),("ln","ln("),("log","log("),("log₂","log2("),("exp","exp("),("10ˣ","10^("),("cbrt","cbrt("),("floor","floor("),("ceil","ceil("),("mod","mod("),("π","pi"),("e","e"),("φ","phi"),("x²","^2"),("xʸ","^"),("√","sqrt("),("n!","!"),("nCr","ncr("),("nPr","npr("),("1/x","recip("),("|x|","abs("),("%","%"),("(","("),(")",")"),("÷","/"),("×","*"),("−","-"),("+","+"),("gcd","gcd("),("lcm","lcm("),("mean","mean("),("σ","stddev("),("Ans","ans"),("0","0"),("1","1"),("2","2"),("3","3"),("4","4"),("5","5"),("6","6"),("7","7"),("8","8"),("9","9"),(".",".")]
def guideText : String := "How this calculator follows Smithian Fold Theory\n\nUse it like a normal scientific calculator. Type an expression or press the buttons, then press = or Enter.\n\nExamples\n  1 + 1 =\n  0.1 + 0.2 =\n  sqrt(2)\n  2^(1/3)\n  sin(30) in DEG mode\n  log(8, 2)\n  mean(1, 2, 3, 4)\n\nSFT value translation\n• A displayed 0 is the structural empty-One form, not a numerical proof value.\n• A minus sign is stored as a held orientation plus a positive magnitude.\n• Entered decimals become exact fractions before calculation.\n• Non-rational roots, π, e and transcendental functions return exact rational lower/upper certificates. The large decimal is a readable projection, not the proof.\n• Conventional complex values are typed real and orthogonal Fold fibres; no imaginary proof scalar is introduced.\n• Invalid domains, division by empty-One and any result that cannot be certified within the declared resource limit halt explicitly.\n\nMemory\nMS stores the current answer. MR inserts mem. M+ and M− update memory. MC clears it. Ans inserts the previous answer.\n\nEvidence\nThe Trace tab shows every exact operation and its counted resources. Exact details exposes the retained fraction or enclosure rather than hiding it behind a decimal.\n"
def friendly (value : Value) (places : Int := 16) : Except String String := do
 match value with
 | .interval v =>
  let lower := scalarToFractionForProjection v.lower
  let upper := scalarToFractionForProjection v.upper
  let midpoint ← scalarFromProjection (← LeptonRatios.divide (LeptonIntervals.add lower upper) (CalculatorSeries.natural 2))
  pure (Text.append "≈ " (← CalculatorProjection.decimalProjection midpoint places))
 | .complex _ => CalculatorProjection.valueText value places
 | .scalar .emptyOne => pure "0"
 | .scalar (.positive orientation m) =>
  if m.denominator == 1 then
   let signText := match orientation with | .forward => "" | .counter => "−"
   pure (Text.append signText (CalculatorRoots.digits m.numerator))
  else CalculatorProjection.decimalProjection (.positive orientation m) places
def orderedInterval (lower upper : FoldScalar.Scalar) (certificate : List String) : Except String CertifiedInterval :=
 certifiedInterval lower upper certificate
def intervalHull (intervals : List CertifiedInterval) (certificate : String) : Except String CertifiedInterval := do
 match intervals with
 | [] => throw "min() arg is an empty sequence"
 | first::rest =>
  let lower := rest.foldl (fun a b => if compareScalar b.lower a < 0 then b.lower else a) first.lower
  let upper := rest.foldl (fun a b => if compareScalar b.upper a > 0 then b.upper else a) first.upper
  certifiedInterval lower upper ((intervals.flatMap CertifiedInterval.certificate) ++ [certificate])
end SFT.Mathematics.CalculatorDisplay
