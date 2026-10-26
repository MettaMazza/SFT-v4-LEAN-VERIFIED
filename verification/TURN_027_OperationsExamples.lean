import SFT.Foundation.ExactOperations
open SFT.Foundation.ExactOperations
#eval (fromPair 2 4).map fun p => (p.numerator,p.denominator)
#eval (fromPair 6 9).map fun p => (p.numerator,p.denominator)
#eval (fromPair 3 4).map fun p => let q := foldPart p; (q.numerator,q.denominator)
#eval (fromPair 3 4).bind fun a => (fromPair 1 2).bind fun b =>
  (takePart a b).map fun p => (p.numerator,p.denominator)
#eval (fromPair 1 2).bind fun a => (fromPair 2 4).map fun b => unison a b
#eval (fromPair 1 4).bind fun a => (fromPair 1 1).bind fun b =>
  (takePart a b).map fun p => (p.numerator,p.denominator)
#eval (fromPair 0 1).map fun p => (p.numerator,p.denominator)
#eval (fromPair 2 1).map fun p => (p.numerator,p.denominator)
