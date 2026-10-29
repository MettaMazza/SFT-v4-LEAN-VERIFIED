import Lean
import SFT.Computation.SymbolicEvaluation
open Lean SFT.Computation.NumericalError SFT.Computation.SymbolicEvaluation SFT.Foundation.ExactOperations
 def numberText : Number → String
 | .zero => "0/1"
 | .positive p => toString p.numerator ++ "/" ++ toString p.denominator
 | .negative p => "-" ++ toString p.numerator ++ "/" ++ toString p.denominator
 def encode : Except String Number → Json
 | .error reason => Json.mkObj [("error",toJson reason)]
 | .ok value => Json.mkObj [("value",toJson (numberText value))]
 def samples : List Number := [(.negative (normalizePositive 1 1 (by decide) (by decide))),.zero,(.positive (normalizePositive 1 3 (by decide) (by decide))),(.positive (normalizePositive 1 2 (by decide) (by decide))),(.positive (normalizePositive 1 1 (by decide) (by decide))),(.positive (normalizePositive 2 1 (by decide) (by decide)))]
 def leaves : List SFT.Computation.SymbolicEvaluation.Expr := samples.map (fun value => .value (some value)) ++ [.value none,.name "x",.name "y",.name "missing",.outside "outside"]
 def expressions : List SFT.Computation.SymbolicEvaluation.Expr := leaves ++ leaves.flatMap (fun a => leaves.map (fun b => .join a b)) ++ leaves.map (fun a => .join (.join a (.value (some (.positive (normalizePositive 1 1 (by decide) (by decide)))))) (.name "x"))
 def environments : List SFT.Computation.SymbolicEvaluation.Environment := [[]] ++ samples.map (fun v => [("x",v)]) ++ samples.flatMap (fun a => samples.map (fun b => [("x",a),("y",b)])) ++ samples.map (fun v => [("x",v),("x",.positive (normalizePositive 1 1 (by decide) (by decide)))])
 def main : IO Unit := do
  for env in environments do
    for expression in expressions do
      IO.println (encode (evaluate env expression)).compress
