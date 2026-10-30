import SFT.Physics.VacuumOddOrbit
open SFT.Physics.VacuumOddOrbit SFT.Physics.GeneratorOperations
open SFT.Foundation.ExactPartCarrier
def showResult : Except String (List Part) → String
 | .error e => "error:" ++ e
 | .ok xs => "ok:" ++ String.intercalate "," (xs.map fun p => toString p.numerator ++ "/" ++ toString p.denominator)
def main : IO Unit := do
 for x in ([.integer (-2), .integer (-1), .integer (0), .integer (1), .integer (2), .integer (3), .integer (4), .integer (5), .integer (6), .integer (7), .integer (8), .integer (9), .integer (10), .integer (11), .integer (12), .integer (13), .integer (14), .integer (15), .integer (16), .integer (17), .integer (18), .integer (19), .integer (20), .integer (21), .integer (22), .integer (23), .integer (24), .integer (25), .integer (26), .integer (27), .integer (28), .integer (29), .integer (30), .integer (31), .boolean false, .boolean true] : List CountInput) do
  IO.println (showResult (oddDenominatorOrbit x))
