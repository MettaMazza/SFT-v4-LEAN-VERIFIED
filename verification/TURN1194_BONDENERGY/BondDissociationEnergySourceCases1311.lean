import SFT.Chemistry.BondDissociationEnergySource
open SFT.Host.Canonical SFT.Chemistry.BondDissociationEnergySource
def rat (r : Rat) : Value := .array [.integer r.num,.integer (Int.ofNat r.den)]
def encode : Except String Rat → Value
 | .ok r => .array [.text "ok",.integer r.num,.integer (Int.ofNat r.den)]
 | .error e => .array [.text "error",.text e]
def encodeInterval : Except String (Rat × Rat × Rat × Rat) → Value
 | .ok (a,b,c,d) => .array [.text "ok",rat a,rat b,rat c,rat d]
 | .error e => .array [.text "error",.text e]
def main : IO Unit := IO.println (render (.array [
encode (fraction (.null)),
encode (fraction (.array [])),
encode (fraction (.object [])),
encode (fraction (.object [("numerator",.integer (1))])),
encode (fraction (.object [("numerator",.integer (1)),("denominator",.integer (2)),("extra",.integer (3))])),
encode (fraction (.object [("numerator",.integer (1)),("denominator",.integer (2))])),
encode (fraction (.object [("numerator",.integer (2)),("denominator",.integer (4))])),
encode (fraction (.object [("numerator",.integer (0)),("denominator",.integer (1))])),
encode (fraction (.object [("numerator",.integer (-1)),("denominator",.integer (2))])),
encode (fraction (.object [("numerator",.integer (1)),("denominator",.integer (-2))])),
encode (fraction (.object [("numerator",.integer (-1)),("denominator",.integer (-2))])),
encode (fraction (.object [("numerator",.integer (1)),("denominator",.integer (0))])),
encode (fraction (.object [("numerator",.boolean true),("denominator",.integer (2))])),
encode (fraction (.object [("numerator",.integer (1)),("denominator",.boolean true)])),
encode (fraction (.object [("numerator",.text "1"),("denominator",.integer (2))])),
encode (fraction (.object [("numerator",.integer (1)),("denominator",.text "2")])),
encodeInterval (interval (.object [("central",.object [("numerator",.integer (3)),("denominator",.integer (1))]),("uncertainty",.object [("numerator",.integer (1)),("denominator",.integer (1))]),("lower",.object [("numerator",.integer (2)),("denominator",.integer (1))]),("upper",.object [("numerator",.integer (4)),("denominator",.integer (1))])])),
encodeInterval (interval (.object [("central",.object [("numerator",.integer (3)),("denominator",.integer (1))]),("uncertainty",.object [("numerator",.integer (1)),("denominator",.integer (1))]),("lower",.object [("numerator",.integer (1)),("denominator",.integer (1))]),("upper",.object [("numerator",.integer (4)),("denominator",.integer (1))])])),
encodeInterval (interval (.object [("central",.object [("numerator",.integer (3)),("denominator",.integer (1))]),("uncertainty",.object [("numerator",.integer (1)),("denominator",.integer (1))]),("lower",.object [("numerator",.integer (2)),("denominator",.integer (1))]),("upper",.object [("numerator",.integer (5)),("denominator",.integer (1))])])),
encodeInterval (interval (.object [("central",.object [("numerator",.integer (3)),("denominator",.integer (1))]),("uncertainty",.object [("numerator",.integer (0)),("denominator",.integer (1))]),("lower",.object [("numerator",.integer (3)),("denominator",.integer (1))]),("upper",.object [("numerator",.integer (3)),("denominator",.integer (1))])]))]))
