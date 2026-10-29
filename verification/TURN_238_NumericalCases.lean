import Lean
import SFT.Computation.NumericalLedger
open SFT.Computation.NumericalError SFT.Foundation.ExactOperations
open Lean
set_option maxRecDepth 100000
set_option maxHeartbeats 0
 def encode : Except String (List Row) → Json
 | .error reason => Json.mkObj [("error",toJson reason)]
 | .ok rows => Json.mkObj [("rows",toJson (rows.map (fun r => [r.1,toString r.2.1.numerator ++ "/" ++ toString r.2.1.denominator,r.2.2])))]
 def samples : List Number := [(.negative (normalizePositive 1 1 (by decide) (by decide))),.zero,(.positive (normalizePositive 1 3 (by decide) (by decide))),(.positive (normalizePositive 1 2 (by decide) (by decide))),(.positive (normalizePositive 1 1 (by decide) (by decide))),(.positive (normalizePositive 2 1 (by decide) (by decide)))]
 def supports : List (List Number) := [[]] ++ samples.map (fun x => [x]) ++ samples.flatMap (fun x => samples.map (fun y => [x,y]))
 def main : IO Unit := do
  for a in supports do
    for b in supports do
      IO.println (encode (exactErrorLedger a b)).compress
