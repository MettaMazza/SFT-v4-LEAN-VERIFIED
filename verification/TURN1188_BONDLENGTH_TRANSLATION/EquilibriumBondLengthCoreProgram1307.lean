import SFT.Chemistry.EquilibriumBondLengthSource
open SFT.Host.Canonical SFT.Chemistry
def encode : Except String Rat → Value
 | .ok q => .array [.text "ok",.integer q.num,.integer (Int.ofNat q.den)]
 | .error e => .array [.text "error",.text e]
def main : IO Unit := do
 IO.println (render (.array [
encode (EquilibriumBondLength.equilibriumLengthMultiplier "H2"),
encode (EquilibriumBondLength.equilibriumLengthMultiplier "D2"),
encode (EquilibriumBondLength.equilibriumLengthMultiplier "HD"),
encode (EquilibriumBondLength.equilibriumLengthMultiplier ""),
encode (EquilibriumBondLength.equilibriumLengthMultiplier "h2"),
encode (EquilibriumBondLength.equilibriumLengthMultiplier "H2 "),
encode (EquilibriumBondLengthSource.fraction (.object [("numerator",.integer (1)),("denominator",.integer (2))])),
encode (EquilibriumBondLengthSource.fraction (.object [("numerator",.integer (2)),("denominator",.integer (4))])),
encode (EquilibriumBondLengthSource.fraction (.object [("numerator",.integer (-2)),("denominator",.integer (-4))])),
encode (EquilibriumBondLengthSource.fraction (.object [("numerator",.integer (-1)),("denominator",.integer (2))])),
encode (EquilibriumBondLengthSource.fraction (.object [("numerator",.integer (0)),("denominator",.integer (1))])),
encode (EquilibriumBondLengthSource.fraction (.object [("numerator",.integer (1)),("denominator",.integer (0))])),
encode (EquilibriumBondLengthSource.fraction (.object [("numerator",.boolean true),("denominator",.boolean true)])),
encode (EquilibriumBondLengthSource.fraction (.object [("numerator",.integer (1)),("denominator",.boolean false)]))]))
